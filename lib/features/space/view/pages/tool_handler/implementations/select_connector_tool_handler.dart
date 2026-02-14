import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:provider/provider.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';

import 'package:ideascape/features/space/domain/models/connector_handle.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/strategies/interaction_strategy.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/strategies/connector_strategies.dart';

/// Handles selection of connectors ONLY.
class SelectConnectorToolHandler extends ToolHandler {
  const SelectConnectorToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final mediator = context.read<CanvasInteractionMediator>();
    final worldPoint = _toWorldPoint(details.localPosition, controller);
    mediator.selectConnectorAt(worldPoint, isDrag: false);
  }

  /// Initiates the drag operation.
  ///
  /// It first selects the connector at the touch point.
  /// Then it checks if the touch point is close to the start or end point of the connector
  /// to determine if we are reshaping (dragging a handle) or moving the whole connector.
  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = _toWorldPoint(details.localPosition, controller);
    final activeBloc = context.read<ActiveLayerBloc>();
    final mediator = context.read<CanvasInteractionMediator>();

    // We select/configure the state here, which then dictates the Strategy used in Update/End
    mediator.selectConnectorAt(worldPoint, isDrag: true);

    // Check if we hit start or end point using hitTest directly to handle
    // cases where the object is not yet active in the state (async update).
    final hitNode = mediator.hitTest(
      worldPoint,
      filter: SelectionFilter.connectorsOnly,
    );

    if (hitNode is ConnectorNode) {
      const double hitThreshold = 10.0; // Adjust threshold as needed
      if ((hitNode.startPoint - worldPoint).distance < hitThreshold) {
        activeBloc.add(
          const ActiveLayerEvent.connectorHandleSelected(ConnectorHandle.start),
        );
      } else if ((hitNode.endPoint - worldPoint).distance < hitThreshold) {
        activeBloc.add(
          const ActiveLayerEvent.connectorHandleSelected(ConnectorHandle.end),
        );
      } else {
        activeBloc.add(const ActiveLayerEvent.connectorHandleSelected(null));
      }
    } else {
      activeBloc.add(const ActiveLayerEvent.connectorHandleSelected(null));
    }
  }

  /// Updates the connector position or shape during the drag.
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

  /// Finalizes the connector interaction.
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
    if (state.connectorHandle != null) {
      return const ReshapeConnectorStrategy();
    } else if (state.activeNodes.isNotEmpty) {
      return const MoveConnectorStrategy();
    }
    return const IdleStrategy();
  }

  Offset _toWorldPoint(Offset local, TransformationController controller) {
    return MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      local,
    );
  }
}
