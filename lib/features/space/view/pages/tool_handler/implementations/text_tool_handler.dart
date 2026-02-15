import 'package:flutter/material.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/factories/node_factory.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/base_tool_handler.dart';

class TextToolHandler extends BaseToolHandler {
  const TextToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = toWorldPoint(details.localPosition, controller);

    final id = getIt<SpaceDataService>().nextUniqueId;
    final textObject = NodeFactory.createText(
      id: id,
      text: "",
      position: worldPoint,
      fontSize: 20.0,
    );

    getToolbarBloc(context).add(ToolbarEvent.startedEditing(textObject));
  }

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = toWorldPoint(details.localPosition, controller);
    final mediator = getMediator(context);

    final id = getIt<SpaceDataService>().nextUniqueId;
    final textObject = NodeFactory.createText(
      id: id,
      text: "",
      position: worldPoint,
      fontSize: 20.0,
    );

    mediator.startNewShape(textObject, worldPoint);

    getToolbarBloc(context).add(
      ToolbarEvent.updateDrawingObject(textObject),
    );
  }

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeState = getActiveLayerBloc(context).state;
    final mediator = getMediator(context);
    final startPoint = activeState.dragStartPoint;

    if (startPoint != null && activeState.activeNodes.isNotEmpty) {
      final currentObject = activeState.activeNodes.values.first;

      if (currentObject is TextNode) {
        final currentPoint = toWorldPoint(details.localPosition, controller);

        final distance = (currentPoint - startPoint).distance;
        final newFontSize = distance.clamp(10.0, 500.0);

        final updatedText = currentObject.copyWith(fontSize: newFontSize);

        mediator.updateNewShape(updatedText, currentPoint);

        getToolbarBloc(context).add(
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
    final activeState = getActiveLayerBloc(context).state;
    final activeBloc = getActiveLayerBloc(context);

    if (activeState.activeNodes.isNotEmpty) {
      final finalObject = activeState.activeNodes.values.first;

      if (finalObject is TextNode) {
        getToolbarBloc(context).add(
          ToolbarEvent.startedEditing(finalObject),
        );
      }

      // Deactivate without commit (InlineTextEditor handles commit)
      activeBloc.add(ActiveLayerEvent.nodeDeactivated(finalObject.id));

      getToolbarBloc(context).add(
        const ToolbarEvent.updateDrawingObject(null),
      );
    }
  }
}
