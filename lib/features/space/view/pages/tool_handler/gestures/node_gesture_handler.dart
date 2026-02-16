import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_handler.dart';

/// Handles regular (non-connector) node interactions.
///
/// **Priority:** Medium — should be after connectors but before background.
///
/// **Responsibility:** Detects if the user tapped/dragged on a regular node
/// (shape, text, image, etc.) and initiates a selection or move operation.
///
/// Connectors are excluded from the hit test using [SelectionFilter.excludeConnectors].
class NodeGestureHandler extends GestureHandler {
  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();
    final hitNode = mediator.hitTest(
      event.worldPoint,
      filter: SelectionFilter.excludeConnectors,
    );
    return hitNode != null;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();
    final isDrag = event.type == GestureType.panStart;

    mediator.selectAt(
      event.worldPoint,
      isDrag: isDrag,
      filter: SelectionFilter.excludeConnectors,
    );

    // Clear any active resize handles
    context.read<ActiveLayerBloc>().add(
      const ActiveLayerEvent.handleChanged(null),
    );
  }
}
