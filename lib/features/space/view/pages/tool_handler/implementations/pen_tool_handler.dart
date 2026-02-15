import 'package:flutter/material.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/factories/node_factory.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/base_tool_handler.dart';

class PenToolHandler extends BaseToolHandler {
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
    final worldPoint = toWorldPoint(details.localPosition, controller);
    final mediator = getMediator(context);

    final id = getIt<SpaceDataService>().nextUniqueId;
    final newListObject = NodeFactory.createListOfPoint(
      id: id,
      points: [worldPoint],
    );

    mediator.startDrawing(newListObject, worldPoint);

    getToolbarBloc(context).add(
      ToolbarEvent.updateDrawingObject(newListObject),
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

    if (activeState.activeNodes.isNotEmpty) {
      final currentObject = activeState.activeNodes.values.first;

      if (currentObject is ListOfPointNode) {
        final worldPoint = toWorldPoint(details.localPosition, controller);

        // Optimization: Only add point if it's far enough from the last point
        const distanceThreshold = 0.5;
        final lastPoint = currentObject.points.last;
        final distance = (worldPoint - lastPoint).distance;

        if (distance > distanceThreshold) {
          final updatedObject = currentObject.copyWith(
            points: [...currentObject.points, worldPoint],
          );

          mediator.updateDrawing(updatedObject, worldPoint);

          getToolbarBloc(context).add(
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
    final mediator = getMediator(context);
    mediator.commitAndDeactivate();

    getToolbarBloc(context).add(
      const ToolbarEvent.updateDrawingObject(null),
    );
  }
}
