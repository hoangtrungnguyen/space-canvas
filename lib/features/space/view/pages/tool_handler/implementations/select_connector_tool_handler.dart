import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:provider/provider.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';

import 'package:ideascape/features/space/domain/models/connector_handle.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_object.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';

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
    final state = activeBloc.state;

    final mediator = context.read<CanvasInteractionMediator>();
    mediator.selectConnectorAt(worldPoint, isDrag: true);

    // Check if we hit start or end point using hitTest directly to handle
    // cases where the object is not yet active in the state (async update).
    final hitObject = mediator.hitTest(
      worldPoint,
      filter: SelectionFilter.connectorsOnly,
    );

    if (hitObject is ConnectorObject) {
      const double hitThreshold = 10.0; // Adjust threshold as needed
      if ((hitObject.startPoint - worldPoint).distance < hitThreshold) {
        activeBloc.add(
          const ActiveLayerEvent.connectorHandleSelected(ConnectorHandle.start),
        );
      } else if ((hitObject.endPoint - worldPoint).distance < hitThreshold) {
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
  /// If a handle (start/end) is selected, it updates that specific point.
  /// Otherwise, it acts as a move operation for the entire connector.
  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;

    final mediator = context.read<CanvasInteractionMediator>();
    final worldPoint = _toWorldPoint(details.localPosition, controller);

    // If we have a connector handle selected, we are reshaping
    if (state.connectorHandle != null) {
      if (state.dragStartPoint != null) {
        final delta = worldPoint - state.dragStartPoint!;
        // When reshaping, we want the point to follow the cursor exactly relative to start
        // But dragActiveConnector adds delta to original point.
        // It seems InteractionStateManager uses delta from dragStartPoint.
        // So we just pass the delta.
        mediator.dragActiveConnector(worldPoint, delta);
      }
    } else {
      // Moving the whole connector
      if (state.dragStartPoint != null) {
        final delta = worldPoint - state.dragStartPoint!;
        mediator.dragActiveConnector(worldPoint, delta);
      }
    }
  }

  /// Finalizes the connector interaction.
  ///
  /// It commits any reshaping changes to the history (via ReshapeConnectorCommand)
  /// and resets the selected handle state.
  @override
  void onPanEnd(
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
