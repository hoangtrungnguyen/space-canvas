import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:provider/provider.dart';

class SelectToolHandler extends ToolHandler {
  const SelectToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final mediator = context.read<CanvasInteractionMediator>();
    final worldPoint = _toWorldPoint(details.localPosition, controller);
    mediator.selectAt(worldPoint, isDrag: false);
  }

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final mediator = context.read<CanvasInteractionMediator>();
    final worldPoint = _toWorldPoint(details.localPosition, controller);
    mediator.selectAt(worldPoint, isDrag: true);
  }

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final mediator = context.read<CanvasInteractionMediator>();
    final worldPoint = _toWorldPoint(details.localPosition, controller);

    // We need the delta in world coordinates.
    // However, the mediator.dragActiveObject expects world worldPoint and delta.
    // Let's calculate delta based on previous dragStartPoint from state.
    // To keep handler simple, maybe mediator should handle delta internally?
    // But delta depends on the previous event.
    // For now, let's keep the delta calculation here or improve mediator.

    // Actually, mediator's dragActiveObject needs to know where we are now
    // and what the delta is since the LAST interaction started.
    // In my mediator implementation, delta is world-point delta.

    // Let's check how onPanUpdate was implemented before:
    // final delta = worldPoint - state.dragStartPoint!;

    // I will refactor mediator slightly to make this even easier if needed,
    // but for now I'll use the existing mediator method.
    // But I need the state from ActiveLayerBloc to get dragStartPoint.

    // Wait, if I'm within the tool handler, I can still read the bloc state.
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;

    if (state.dragStartPoint != null) {
      final delta = worldPoint - state.dragStartPoint!;
      mediator.dragActiveObject(worldPoint, delta);
    }
  }

  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final mediator = context.read<CanvasInteractionMediator>();
    mediator.finalizeInteraction();
  }

  Offset _toWorldPoint(Offset local, TransformationController controller) {
    return MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      local,
    );
  }
}
