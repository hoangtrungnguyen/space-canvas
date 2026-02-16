import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_handler.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart'; // Import mediator

/// Handles interactions with the body of a connector (tapping or dragging to move).
///
/// **Priority:** Medium.
///
/// **Responsibility:** Detects if the user hit a connector (but not a handle).
/// Selects the connector and prepares it for movement by clearing any active handle.
class ConnectorBodyGestureHandler extends GestureHandler {
  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();
    final hitNode = mediator.hitTest(
      event.worldPoint,
      filter: SelectionFilter.connectorsOnly,
    );
    return hitNode is ConnectorNode;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();
    final activeBloc = context.read<ActiveLayerBloc>();

    // Select the connector
    final isDrag = event.type == GestureType.panStart;
    mediator.selectConnectorAt(event.worldPoint, isDrag: isDrag);

    // Clear any handle selection since we are interacting with the body (move operation)
    activeBloc.add(const ActiveLayerEvent.connectorHandleSelected(null));
  }
}
