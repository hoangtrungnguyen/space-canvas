import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/visitors/resize_visitor.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/strategies/interaction_strategy.dart';
import 'package:ideascape/features/space/view/utils/canvas_utils.dart';

/// Strategy for moving selected nodes.
class MoveStrategy implements InteractionStrategy {
  const MoveStrategy();

  @override
  void onUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;
    final mediator = context.read<CanvasInteractionMediator>();
    final worldPoint = CanvasUtils.toWorldPoint(
      details.localPosition,
      controller,
    );

    if (state.dragStartPoint != null) {
      final delta = worldPoint - state.dragStartPoint!;
      mediator.dragActiveNode(worldPoint, delta);
    }
  }

  @override
  void onEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final mediator = context.read<CanvasInteractionMediator>();

    mediator.finalizeInteraction();

    // Fix ghosting: Remove from ShapeLayer after finalize, as it remains active.
    final state = activeBloc.state;
    if (state.activeNodes.isNotEmpty) {
      final activeConfig = activeBloc.state.activeNodes.values.first;
      context.read<ShapeLayerBloc>().add(
        ShapeLayerEvent.removeNode(activeConfig.id),
      );
    }
  }
}

/// Strategy for resizing selected nodes via handles.
class ResizeStrategy implements InteractionStrategy {
  const ResizeStrategy();

  @override
  void onUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;
    final worldPoint = CanvasUtils.toWorldPoint(
      details.localPosition,
      controller,
    );

    if (state.resizeHandle != null && state.activeNodes.isNotEmpty) {
      final node = state.activeNodes.values.first;
      final startPoint = state.dragStartPoint;

      if (startPoint != null) {
        final delta = worldPoint - startPoint; // Total delta
        final original = state.originalNode;

        if (original != null && original.id == node.id) {
          final visitor = ResizeVisitor(
            handle: state.resizeHandle!,
            delta: delta,
          );
          final newNode = original.accept(visitor);
          activeBloc.add(ActiveLayerEvent.nodeChanged(newNode));
        }
      }
    }
  }

  @override
  void onEnd(
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
      final activeNode = state.activeNodes.values.first;
      context.read<ShapeLayerBloc>().add(
        ShapeLayerEvent.removeNode(activeNode.id),
      );
    }

    // UPDATE POSITION FOR CONTINUOUS INTERACTION
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
}

/// Strategy when no node-specific interaction is active.
class IdleStrategy implements InteractionStrategy {
  const IdleStrategy();

  @override
  void onUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {}

  @override
  void onEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final mediator = context.read<CanvasInteractionMediator>();
    mediator.finalizeInteraction();
  }
}
