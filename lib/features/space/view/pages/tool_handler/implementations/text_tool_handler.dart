import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/factories/node_factory.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:provider/provider.dart';

class TextToolHandler extends ToolHandler {
  const TextToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = _toWorldPoint(details.localPosition, controller);

    final id = getIt<SpaceDataService>().nextUniqueId;
    final textObject = NodeFactory.createText(
      id: id,
      text: "",
      position: worldPoint,
      fontSize: 20.0,
    );

    context.read<ToolbarBloc>().add(ToolbarEvent.startedEditing(textObject));
  }

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = _toWorldPoint(details.localPosition, controller);
    final mediator = context.read<CanvasInteractionMediator>();

    final id = getIt<SpaceDataService>().nextUniqueId;
    final textObject = NodeFactory.createText(
      id: id,
      text: "",
      position: worldPoint,
      fontSize: 20.0,
    );

    mediator.startNewShape(textObject, worldPoint);

    context.read<ToolbarBloc>().add(
      ToolbarEvent.updateDrawingObject(textObject),
    );
  }

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeState = context.read<ActiveLayerBloc>().state;
    final mediator = context.read<CanvasInteractionMediator>();
    final startPoint = activeState.dragStartPoint;

    if (startPoint != null && activeState.activeNodes.isNotEmpty) {
      final currentObject = activeState.activeNodes.values.first;

      if (currentObject is TextNode) {
        final currentPoint = _toWorldPoint(details.localPosition, controller);

        final distance = (currentPoint - startPoint).distance;
        final newFontSize = distance.clamp(10.0, 500.0);

        final updatedText = currentObject.copyWith(fontSize: newFontSize);

        mediator.updateNewShape(updatedText, currentPoint);

        context.read<ToolbarBloc>().add(
          ToolbarEvent.updateDrawingObject(updatedText),
        );
      }
    }
  }

  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeState = context.read<ActiveLayerBloc>().state;
    final activeBloc = context.read<ActiveLayerBloc>();

    if (activeState.activeNodes.isNotEmpty) {
      final finalObject = activeState.activeNodes.values.first;

      if (finalObject is TextNode) {
        context.read<ToolbarBloc>().add(
          ToolbarEvent.startedEditing(finalObject),
        );
      }

      // Deactivate without commit (InlineTextEditor handles commit)
      activeBloc.add(ActiveLayerEvent.nodeDeactivated(finalObject.id));

      context.read<ToolbarBloc>().add(
        const ToolbarEvent.updateDrawingObject(null),
      );
    }
  }

  Offset _toWorldPoint(Offset local, TransformationController controller) {
    return MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      local,
    );
  }
}
