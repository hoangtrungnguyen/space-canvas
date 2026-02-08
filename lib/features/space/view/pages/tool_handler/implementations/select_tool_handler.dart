import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:provider/provider.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/resize_tool_handler.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';

/// Handles selection and manipulation (move/resize) of objects.
///
/// This handler serves as the primary entry point for object interaction.
/// It delegates specific resize logic to [ResizeToolHandler] when a handle is hit.
class SelectToolHandler extends ToolHandler {
  const SelectToolHandler();

  /// Handles tap gestures to select objects.
  ///
  /// Uses [CanvasInteractionMediator.selectAt] to verify hits on the canvas.
  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final mediator = context.read<CanvasInteractionMediator>();
    final worldPoint = _toWorldPoint(details.localPosition, controller);

    final hitObject = mediator.hitTest(worldPoint);
    if (hitObject is ConnectorObject) {
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
    final worldPoint = _toWorldPoint(details.localPosition, controller);
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;

    // Check for handle hit
    ResizeHandle? hitHandle;
    if (state.activeObjects.isNotEmpty) {
      // Check handles of the first active object (or iterate).
      // If we hit a handle of an ALREADY selected object, that takes precedence.

      final scale = controller.value.getMaxScaleOnAxis();
      final hitRadius = 20.0 / scale; // Larger target for touch

      for (final object in state.activeObjects.values) {
        final rect = object.rect.inflate(4.0); // Padding from SelectionPainter
        hitHandle = _getHitHandle(worldPoint, rect, hitRadius);
        if (hitHandle != null) break;
      }
    }

    if (hitHandle != null) {
      // Start Resize
      activeBloc.add(ActiveLayerEvent.handleChanged(hitHandle));

      // If we hit a handle, we should SKIP `selectAt` hit testing on bodies.

      final activeObject = state.activeObjects.values.first;
      // Temporarily remove from ShapeLayer so we don't see the "old" version
      // beneath the active one being resized.
      // This does NOT add a DeleteObjectCommand, it just updates the view state.
      context.read<ShapeLayerBloc>().add(
        ShapeLayerEvent.removeObject(activeObject.id),
      );

      context.read<ActiveLayerBloc>().add(
        ActiveLayerEvent.interactionStarted(
          object: activeObject,
          point: worldPoint,
        ),
      );
    } else {
      // Normal selection logic
      final mediator = context.read<CanvasInteractionMediator>();

      final hitObject = mediator.hitTest(worldPoint);
      if (hitObject is ConnectorObject) {
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
  /// Delegates to [ResizeToolHandler] if an [activeHandle] is present.
  /// Otherwise, handles object movement via [CanvasInteractionMediator.dragActiveObject].
  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;

    // Delegate to ResizeToolHandler if resizing
    if (state.resizeHandle != null) {
      const resizeHandler = ResizeToolHandler();
      resizeHandler.onPanUpdate(details, context, controller);
      return;
    }

    // MOVE LOGIC
    final mediator = context.read<CanvasInteractionMediator>();
    final worldPoint = _toWorldPoint(details.localPosition, controller);

    if (state.dragStartPoint != null) {
      final delta = worldPoint - state.dragStartPoint!;
      mediator.dragActiveObject(worldPoint, delta);
    }
  }

  /// Handles the end of a drag or resize operation.
  ///
  /// Delegates to [ResizeToolHandler] if resizing.
  /// Otherwise, calls [CanvasInteractionMediator.finalizeInteraction] and ensures
  /// proper visibility management in the [ShapeLayer].
  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();

    // Delegate to ResizeToolHandler if we are in a resize operation (active handle exists).
    // The ResizeToolHandler manages its own finalization and state cleanup.
    // We strictly return here to avoid double-finalization or conflicts.
    if (activeBloc.state.resizeHandle != null) {
      const ResizeToolHandler().onPanEnd(details, context, controller);
      return;
    }

    final mediator = context.read<CanvasInteractionMediator>();
    mediator.finalizeInteraction();

    // After finalization, the object is committed to ShapeLayer (via History).
    // But since it remains Active (selected), we must visually remove it from ShapeLayer
    // to avoid "Ghosting" (seeing duplicates).
    // This handles the "Selected but not dragging" state.
    if (activeBloc.state.activeObjects.isNotEmpty) {
      final activeConfig = activeBloc.state.activeObjects.values.first;
      context.read<ShapeLayerBloc>().add(
        ShapeLayerEvent.removeObject(activeConfig.id),
      );
    }
  }

  Offset _toWorldPoint(Offset local, TransformationController controller) {
    return MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      local,
    );
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

enum DraggingState { none, moving, resizing }
