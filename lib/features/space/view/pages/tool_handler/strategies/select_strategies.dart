import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/resize_visitor.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/strategies/interaction_strategy.dart';
import 'package:ideascape/features/space/view/utils/canvas_utils.dart';

/// Strategy for moving selected objects.
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
      mediator.dragActiveObject(worldPoint, delta);
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
    if (state.activeObjects.isNotEmpty) {
      final activeConfig = activeBloc.state.activeObjects.values.first;
      context.read<ShapeLayerBloc>().add(
        ShapeLayerEvent.removeObject(activeConfig.id),
      );
    }
  }
}

/// Strategy for resizing selected objects via handles.
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

    if (state.resizeHandle != null && state.activeObjects.isNotEmpty) {
      final object = state.activeObjects.values.first;
      final startPoint = state.dragStartPoint;

      if (startPoint != null) {
        final delta = worldPoint - startPoint; // Total delta
        final original = state.originalObject;

        if (original != null && original.id == object.id) {
          final visitor = ResizeVisitor(
            handle: state.resizeHandle!,
            delta: delta,
          );
          final newObject = original.accept(visitor);
          activeBloc.add(ActiveLayerEvent.objectChanged(newObject));
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
    if (state.activeObjects.isNotEmpty) {
      final activeObject = state.activeObjects.values.first;
      context.read<ShapeLayerBloc>().add(
        ShapeLayerEvent.removeObject(activeObject.id),
      );
    }

    // UPDATE POSITION FOR CONTINUOUS INTERACTION
    if (activeBloc.state.activeObjects.isNotEmpty) {
      activeBloc.add(
        ActiveLayerEvent.originalObjectSet(
          activeBloc.state.activeObjects.values.first,
        ),
      );
    }

    // Clear handle on end
    activeBloc.add(const ActiveLayerEvent.handleChanged(null));
  }
}

/// Strategy when no object-specific interaction is active.
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
