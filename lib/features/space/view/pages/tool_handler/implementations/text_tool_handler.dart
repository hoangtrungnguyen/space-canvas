import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/factories/space_object_factory.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';

class TextToolHandler extends ToolHandler {
  const TextToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      details.localPosition,
    );

    final id = getIt<SpaceDataService>().nextUniqueId;
    final textObject = SpaceObjectFactory.createText(
      id: id,
      text: "",
      position: worldPoint,
      fontSize: 20.0,
    );

    // We don't add to history yet, we just start editing.
    // The InlineTextEditor will commit to history on finish.
    context.read<ToolbarBloc>().add(ToolbarEvent.startedEditing(textObject));
  }

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      details.localPosition,
    );

    final id = getIt<SpaceDataService>().nextUniqueId;
    final textObject = SpaceObjectFactory.createText(
      id: id,
      text: "",
      position: worldPoint,
      fontSize: 20.0,
    );

    context.read<ActiveLayerBloc>().add(
      ActiveLayerEvent.interactionStarted(
        object: textObject,
        point: worldPoint,
      ),
    );

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
    final startPoint = activeState.dragStartPoint;

    if (startPoint != null && activeState.activeObjects.isNotEmpty) {
      final currentObject = activeState.activeObjects.values.first;

      if (currentObject is TextObject) {
        final currentPoint = MatrixUtils.transformPoint(
          Matrix4.inverted(controller.value),
          details.localPosition,
        );

        final distance = (currentPoint - startPoint).distance;
        final newFontSize = distance.clamp(10.0, 500.0);

        final updatedText = currentObject.copyWith(fontSize: newFontSize);

        context.read<ActiveLayerBloc>().add(
          ActiveLayerEvent.objectChanged(updatedText),
        );

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

    if (activeState.activeObjects.isNotEmpty) {
      final finalObject = activeState.activeObjects.values.first;

      if (finalObject is TextObject) {
        context.read<ToolbarBloc>().add(
          ToolbarEvent.startedEditing(finalObject),
        );
      }

      // Clear active layer immediately
      context.read<ActiveLayerBloc>().add(
        ActiveLayerEvent.objectDeactivated(finalObject.id),
      );

      context.read<ToolbarBloc>().add(
        const ToolbarEvent.updateDrawingObject(null),
      );
    }
  }
}
