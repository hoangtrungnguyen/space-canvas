import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/connector_handle.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_handler.dart';

/// Handles interactions with connector start/end points.
///
/// **Priority:** High.
///
/// **Responsibility:** Detects if the user dragged close to the start or end point
/// of a connector and activates that handle for reshaping.
class ConnectorHandleGestureHandler extends GestureHandler {
  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    // We only care about pan start for handle dragging
    if (event.type != GestureType.panStart) return false;

    final mediator = context.read<CanvasInteractionMediator>();
    final hitNode = mediator.hitTest(
      event.worldPoint,
      filter: SelectionFilter.connectorsOnly,
    );

    if (hitNode is ConnectorNode) {
      const double hitThreshold = 10.0;
      if ((hitNode.startPoint - event.worldPoint).distance < hitThreshold) {
        return true;
      }
      if ((hitNode.endPoint - event.worldPoint).distance < hitThreshold) {
        return true;
      }
    }
    return false;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();
    final activeBloc = context.read<ActiveLayerBloc>();

    // Select the connector
    mediator.selectConnectorAt(event.worldPoint, isDrag: true);

    // Determine which handle was hit
    final hitNode =
        mediator.hitTest(
              event.worldPoint,
              filter: SelectionFilter.connectorsOnly,
            )
            as ConnectorNode;

    const double hitThreshold = 10.0;
    if ((hitNode.startPoint - event.worldPoint).distance < hitThreshold) {
      activeBloc.add(
        const ActiveLayerEvent.connectorHandleSelected(ConnectorHandle.start),
      );
    } else {
      activeBloc.add(
        const ActiveLayerEvent.connectorHandleSelected(ConnectorHandle.end),
      );
    }
  }
}
