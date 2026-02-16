import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_handler.dart';

/// Handles interactions on the empty canvas background.
///
/// **Priority:** Lowest — should always be the last handler in the chain.
///
/// **Responsibility:** Acts as a fallback when no other handler processed
/// the gesture. Triggers deselection by calling [CanvasInteractionMediator.selectAt]
/// on an empty point, which will commit and deactivate any current selection.
///
/// This handler always returns `true` from [canHandle] since it's
/// the catch-all handler for clicks on empty space.
class BackgroundGestureHandler extends GestureHandler {
  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    // Always can handle — this is the fallback
    return true;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();
    final isDrag = event.type == GestureType.panStart;

    // Calling selectAt on an empty point triggers deselection logic
    // in the SelectionManager (commitAndDeactivate or clean slate).
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
