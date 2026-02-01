import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/factories/space_object_factory.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:ideascape/features/space/view/utils/canvas_utils.dart';
import 'package:provider/provider.dart';

class ShapeToolHandler extends ToolHandler {
  const ShapeToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = CanvasUtils.toWorldPoint(
      details.localPosition,
      controller,
    );
    final mediator = context.read<CanvasInteractionMediator>();
    final shapeType = context.read<ToolbarBloc>().state.activeShapeType;

    final id = getIt<SpaceDataService>().nextUniqueId;
    final newShape = SpaceObjectFactory.createShape(
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
    final worldPoint = CanvasUtils.toWorldPoint(
      details.localPosition,
      controller,
    );
    final mediator = context.read<CanvasInteractionMediator>();
    final shapeType = context.read<ToolbarBloc>().state.activeShapeType;

    final id = getIt<SpaceDataService>().nextUniqueId;
    final newShape = SpaceObjectFactory.createShape(
      id: id,
      type: shapeType,
      center: worldPoint,
    );

    final zeroSizeShape = newShape.copyWith(
      rect: Rect.fromPoints(worldPoint, worldPoint),
    );

    mediator.startNewShape(zeroSizeShape, worldPoint);

    context.read<ToolbarBloc>().add(
      ToolbarEvent.updateDrawingObject(zeroSizeShape),
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

    if (startPoint != null && activeState.activeObjects.isNotEmpty) {
      final currentObject = activeState.activeObjects.values.first;

      if (currentObject is ShapeObject) {
        final currentPoint = CanvasUtils.toWorldPoint(
          details.localPosition,
          controller,
        );
        final newRect = Rect.fromPoints(startPoint, currentPoint);
        final updatedShape = currentObject.copyWith(rect: newRect);

        mediator.updateNewShape(updatedShape, currentPoint);

        context.read<ToolbarBloc>().add(
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
    final mediator = context.read<CanvasInteractionMediator>();
    mediator.commitAndDeactivate();

    context.read<ToolbarBloc>().add(
      const ToolbarEvent.updateDrawingObject(null),
    );
  }
}
