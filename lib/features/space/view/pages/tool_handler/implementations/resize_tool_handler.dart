import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/resize_visitor.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

/// Handles resize interactions for selected objects.
///
/// This handler is typically invoked by [SelectToolHandler] when a resize handle
/// is active. It calculates the new geometry using [ResizeVisitor] and updates
/// the [ActiveLayerBloc].
class ResizeToolHandler extends ToolHandler {
  const ResizeToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {}

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {}

  /// Updates the object's geometry based on drag gestures.
  ///
  /// Uses [ResizeVisitor] to calculate the new [Rect] for the active object
  /// by comparing the current drag position to the drag start point.
  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;
    final worldPoint = _toWorldPoint(details.localPosition, controller);

    if (state.resizeHandle != null && state.activeNodes.isNotEmpty) {
      final object = state.activeNodes.values.first;
      final startPoint = state.dragStartPoint;

      if (startPoint != null) {
        final delta = worldPoint - startPoint; // Total delta
        final original = state.originalNode;

        if (original != null && original.id == object.id) {
          final visitor = ResizeVisitor(
            handle: state.resizeHandle!,
            delta: delta,
          );
          final newObject = original.accept(visitor);
          activeBloc.add(ActiveLayerEvent.nodeChanged(newObject));
        }
      }
    }
  }

  /// Finalizes the resize operation.
  ///
  /// Commits changes via [CanvasInteractionMediator], handles cleanup to prevent
  /// "ghosting" in the [ShapeLayer], and updates the `originalNode` in
  /// [ActiveLayerState] to support continuous interaction.
  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final mediator = context.read<CanvasInteractionMediator>();

    // Finalize the interaction (commits changes to history).
    mediator.finalizeInteraction();

    // Fix ghosting: Remove from ShapeLayer after finalize, as it remains active.
    final state = activeBloc.state;
    if (state.activeNodes.isNotEmpty) {
      final activeNodeect = state.activeNodes.values.first;
      context.read<ShapeLayerBloc>().add(
        ShapeLayerEvent.removeNode(activeNodeect.id),
      );
    }

    // UPDATE POSITION FOR CONTINUOUS INTERACTION
    // After finalization, the originalNode reference in the Bloc is cleared.
    // However, since the user might continue dragging or resizing immediately (without lifting finger fully or re-selecting),
    // we must Update the `originalNode` to match the *current* state of the object.
    // This ensures that the next delta calculation uses the new, resized position as its base,
    // rather than the stale/old position from before the resize started.
    // Note: We use the *current* state from the bloc, as it might have been updated.
    if (activeBloc.state.activeNodes.isNotEmpty) {
      activeBloc.add(
        ActiveLayerEvent.originalNodeSet(
          activeBloc.state.activeNodes.values.first,
        ),
      );
    }

    // Clear handle on end
    activeBloc.add(const ActiveLayerEvent.handleChanged(null));
  }

  Offset _toWorldPoint(Offset local, TransformationController controller) {
    return MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      local,
    );
  }
}
