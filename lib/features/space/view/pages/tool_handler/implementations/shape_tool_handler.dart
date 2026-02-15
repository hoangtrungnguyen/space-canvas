import 'package:flutter/material.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/factories/node_factory.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/base_tool_handler.dart';

class ShapeToolHandler extends BaseToolHandler {
  const ShapeToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = toWorldPoint(details.localPosition, controller);
    final mediator = getMediator(context);
    final shapeType = getToolbarBloc(context).state.activeShapeType;

    final id = getIt<SpaceDataService>().nextUniqueId;
    final newShape = NodeFactory.createShape(
      id: id,
      type: shapeType,
      center: worldPoint,
    );

    mediator.commitImmediate(newShape);
  }

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = toWorldPoint(details.localPosition, controller);
    final mediator = getMediator(context);
    final shapeType = getToolbarBloc(context).state.activeShapeType;

    final id = getIt<SpaceDataService>().nextUniqueId;
    final newShape = NodeFactory.createShape(
      id: id,
      type: shapeType,
      center: worldPoint,
    );

    final zeroSizeShape = newShape.copyWith(
      rect: Rect.fromPoints(worldPoint, worldPoint),
    );

    mediator.startNewShape(zeroSizeShape, worldPoint);

    getToolbarBloc(context).add(
      ToolbarEvent.updateDrawingObject(zeroSizeShape),
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

      if (currentObject is ShapeNode) {
        final currentPoint = toWorldPoint(details.localPosition, controller);
        final newRect = Rect.fromPoints(startPoint, currentPoint);
        final updatedShape = currentObject.copyWith(rect: newRect);

        mediator.updateNewShape(updatedShape, currentPoint);

        getToolbarBloc(context).add(
          ToolbarEvent.updateDrawingObject(updatedShape),
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
    final mediator = getMediator(context);
    mediator.commitAndDeactivate();

    getToolbarBloc(context).add(
      const ToolbarEvent.updateDrawingObject(null),
    );
  }
}
