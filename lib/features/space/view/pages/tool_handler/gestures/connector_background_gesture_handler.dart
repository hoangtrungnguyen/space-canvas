import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_handler.dart';

/// Default handler for when nothing is hit.
///
/// **Priority:** Low.
///
/// **Responsibility:** Deselects active connectors and clears any active handles.
class ConnectorBackgroundGestureHandler extends GestureHandler {
  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    // Only handle if nothing else has handled it (lowest priority)
    return true;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();
    final activeBloc = context.read<ActiveLayerBloc>();

    // Select nothing (clears selection)
    mediator.selectConnectorAt(
      event.worldPoint,
      isDrag: event.type == GestureType.panStart,
    );

    // Clear any handle selection
    activeBloc.add(const ActiveLayerEvent.connectorHandleSelected(null));
  }
}
