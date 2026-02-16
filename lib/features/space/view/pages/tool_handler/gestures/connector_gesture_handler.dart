import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_handler.dart';

/// Handles connector node interactions when tapped or dragged.
///
/// **Priority:** High — should be after resize handles but before regular nodes.
///
/// **Responsibility:** Detects if the user tapped/dragged on a connector node
/// and switches to the connector selection tool.
///
/// When a connector is hit, this handler:
/// 1. Switches the toolbar tool to [SpaceTool.selectConnector]
/// 2. Selects the connector via the mediator
/// 3. Clears any active resize handles
class ConnectorGestureHandler extends GestureHandler {
  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();
    final hitNode = mediator.hitTest(event.worldPoint);
    return hitNode is ConnectorNode;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();

    // Switch to connector selection tool
    context.read<ToolbarBloc>().add(
      const ToolbarEvent.selected(SpaceTool.selectConnector),
    );

    // Select the connector
    final isDrag = event.type == GestureType.panStart;
    mediator.selectConnectorAt(event.worldPoint, isDrag: isDrag);

    // Clear any active resize handles
    context.read<ActiveLayerBloc>().add(
      const ActiveLayerEvent.handleChanged(null),
    );
  }
}
