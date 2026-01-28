import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/commands/add_shape_command.dart';
import 'package:ideascape/features/space/domain/factories/space_object_factory.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';

class PenToolHandler extends ToolHandler {
  const PenToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {}

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
    final newListObject = SpaceObjectFactory.createListOfPoint(
      id: id,
      points: [worldPoint],
    );

    context.read<ActiveLayerBloc>().add(
      ActiveLayerEvent.interactionStarted(
        object: newListObject,
        point: worldPoint,
      ),
    );

    context.read<ToolbarBloc>().add(
      ToolbarEvent.updateDrawingObject(newListObject),
    );
  }

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeState = context.read<ActiveLayerBloc>().state;

    if (activeState.activeObjects.isNotEmpty) {
      final currentObject = activeState.activeObjects.values.first;

      if (currentObject is ListOfPointObject) {
        final worldPoint = MatrixUtils.transformPoint(
          Matrix4.inverted(controller.value),
          details.localPosition,
        );

        // Optimization: Only add point if it's far enough from the last point
        const distanceThreshold = 2.0;
        final lastPoint = currentObject.points.last;
        final distance = (worldPoint - lastPoint).distance;

        if (distance > distanceThreshold) {
          final updatedObject = currentObject.copyWith(
            points: [...currentObject.points, worldPoint],
          );

          context.read<ActiveLayerBloc>().add(
            ActiveLayerEvent.objectChanged(updatedObject),
          );

          context.read<ToolbarBloc>().add(
            ToolbarEvent.updateDrawingObject(updatedObject),
          );
        }
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

      // Commit to history/main layer
      context.read<HistoryManager>().execute(AddShapeCommand(finalObject));

      // Clear active layer
      context.read<ActiveLayerBloc>().add(
        ActiveLayerEvent.objectDeactivated(finalObject.id),
      );

      context.read<ToolbarBloc>().add(
        const ToolbarEvent.updateDrawingObject(null),
      );
    }
  }
}
