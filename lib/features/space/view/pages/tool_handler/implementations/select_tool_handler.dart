import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/strategies/interaction_strategy.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/strategies/select_strategies.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:ideascape/features/space/view/utils/canvas_utils.dart';
import 'package:provider/provider.dart';

/// Handles selection and manipulation (move/resize) of nodes.
///
/// This handler serves as the primary entry point for node interaction.
/// It delegates specific interaction logic to [InteractionStrategy] implementations
/// based on the current state (e.g., [ResizeStrategy] or [MoveStrategy]).
class SelectToolHandler extends ToolHandler {
  const SelectToolHandler();

  /// Handles tap gestures to select nodes.
  ///
  /// Uses [CanvasInteractionMediator.selectAt] to verify hits on the canvas.
  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final mediator = context.read<CanvasInteractionMediator>();
    final worldPoint = CanvasUtils.toWorldPoint(
      details.localPosition,
      controller,
    );

    final hitNode = mediator.hitTest(worldPoint);
    if (hitNode is ConnectorNode) {
      context.read<ToolbarBloc>().add(
        const ToolbarEvent.selected(SpaceTool.selectConnector),
      );
      mediator.selectConnectorAt(worldPoint, isDrag: false);
      return;
    }

    mediator.selectAt(
      worldPoint,
      isDrag: false,
      filter: SelectionFilter.excludeConnectors,
    );
  }

  /// Initiates a drag or resize operation.
  ///
  /// Performs hit-testing to determine if a [ResizeHandle] was touched.
  /// If a handle is hit, it transitions to resize mode by setting the active handle
  /// and firing [ActiveLayerEvent.interactionStarted].
  /// Otherwise, it initiates a move or selection operation via [CanvasInteractionMediator].
  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = CanvasUtils.toWorldPoint(
      details.localPosition,
      controller,
    );
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;

    // Check for handle hit
    ResizeHandle? hitHandle;
    if (state.activeNodes.isNotEmpty) {
      // Check handles of the first active node (or iterate).
      // If we hit a handle of an ALREADY selected node, that takes precedence.

      final scale = controller.value.getMaxScaleOnAxis();
      final hitRadius = 20.0 / scale; // Larger target for touch

      for (final node in state.activeNodes.values) {
        final rect = node.rect.inflate(4.0); // Padding from SelectionPainter
        hitHandle = _getHitHandle(worldPoint, rect, hitRadius);
        if (hitHandle != null) break;
      }
    }

    if (hitHandle != null) {
      // Start Resize
      activeBloc.add(ActiveLayerEvent.handleChanged(hitHandle));

      final activeNode = state.activeNodes.values.first;
      // Temporarily remove from ShapeLayer so we don't see the "old" version
      // beneath the active one being resized.
      context.read<ShapeLayerBloc>().add(
        ShapeLayerEvent.removeNode(activeNode.id),
      );

      context.read<ActiveLayerBloc>().add(
        ActiveLayerEvent.interactionStarted(
          node: activeNode,
          point: worldPoint,
        ),
      );
    } else {
      // Normal selection logic
      final mediator = context.read<CanvasInteractionMediator>();

      final hitNode = mediator.hitTest(worldPoint);
      if (hitNode is ConnectorNode) {
        context.read<ToolbarBloc>().add(
          const ToolbarEvent.selected(SpaceTool.selectConnector),
        );
        mediator.selectConnectorAt(worldPoint, isDrag: true);
        activeBloc.add(const ActiveLayerEvent.handleChanged(null));
        return;
      }

      mediator.selectAt(
        worldPoint,
        isDrag: true,
        filter: SelectionFilter.excludeConnectors,
      );

      // Also ensure handle is cleared if we started a move/select
      activeBloc.add(const ActiveLayerEvent.handleChanged(null));
    }
  }

  /// Handles ongoing drag gestures.
  ///
  /// Delegates to the appropriate [InteractionStrategy] based on the current state.
  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;

    final strategy = _getStrategyForState(state);
    strategy.onUpdate(details, context, controller);
  }

  /// Handles the end of a drag or resize operation.
  ///
  /// Delegates to the appropriate [InteractionStrategy] based on the current state.
  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;

    final strategy = _getStrategyForState(state);
    strategy.onEnd(details, context, controller);
  }

  InteractionStrategy _getStrategyForState(ActiveLayerState state) {
    if (state.resizeHandle != null) {
      return const ResizeStrategy();
    } else if (state.activeNodes.isNotEmpty) {
      return const MoveStrategy();
    }
    return const IdleStrategy();
  }

  /// Helper to determine if a point hits any of the resize handles.
  ResizeHandle? _getHitHandle(Offset elementPoint, Rect rect, double radius) {
    // Check all handles
    if ((elementPoint - rect.topLeft).distance <= radius) {
      return ResizeHandle.topLeft;
    }
    if ((elementPoint - rect.topRight).distance <= radius) {
      return ResizeHandle.topRight;
    }
    if ((elementPoint - rect.bottomLeft).distance <= radius) {
      return ResizeHandle.bottomLeft;
    }
    if ((elementPoint - rect.bottomRight).distance <= radius) {
      return ResizeHandle.bottomRight;
    }
    if ((elementPoint - rect.topCenter).distance <= radius) {
      return ResizeHandle.topCenter;
    }
    if ((elementPoint - rect.bottomCenter).distance <= radius) {
      return ResizeHandle.bottomCenter;
    }
    if ((elementPoint - rect.centerLeft).distance <= radius) {
      return ResizeHandle.centerLeft;
    }
    if ((elementPoint - rect.centerRight).distance <= radius) {
      return ResizeHandle.centerRight;
    }
    return null;
  }
}
