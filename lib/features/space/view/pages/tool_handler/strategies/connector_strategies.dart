import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/strategies/interaction_strategy.dart';

/// Strategy for moving a connector.
class MoveConnectorStrategy implements InteractionStrategy {
  const MoveConnectorStrategy();

  @override
  void onUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;
    final mediator = context.read<CanvasInteractionMediator>();
    final worldPoint = _toWorldPoint(details.localPosition, controller);

    if (state.dragStartPoint != null) {
      final delta = worldPoint - state.dragStartPoint!;
      mediator.dragActiveConnector(worldPoint, delta);
    }
  }

  @override
  void onEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final mediator = context.read<CanvasInteractionMediator>();
    mediator.finalizeConnectorInteraction();
    context.read<ActiveLayerBloc>().add(
      const ActiveLayerEvent.connectorHandleSelected(null),
    );
  }

  Offset _toWorldPoint(Offset local, TransformationController controller) {
    return MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      local,
    );
  }
}

/// Strategy for reshaping a connector (dragging start/end handles).
class ReshapeConnectorStrategy implements InteractionStrategy {
  const ReshapeConnectorStrategy();

  @override
  void onUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;
    final mediator = context.read<CanvasInteractionMediator>();
    final worldPoint = _toWorldPoint(details.localPosition, controller);

    if (state.connectorHandle != null && state.dragStartPoint != null) {
      final delta = worldPoint - state.dragStartPoint!;
      mediator.dragActiveConnector(worldPoint, delta);
    }
  }

  @override
  void onEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final mediator = context.read<CanvasInteractionMediator>();
    mediator.finalizeConnectorInteraction();
    context.read<ActiveLayerBloc>().add(
      const ActiveLayerEvent.connectorHandleSelected(null),
    );
  }

  Offset _toWorldPoint(Offset local, TransformationController controller) {
    return MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      local,
    );
  }
}

/// No-op strategy when no interaction is active.
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
  ) {}
}
