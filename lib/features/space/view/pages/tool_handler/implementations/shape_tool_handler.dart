import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/commands/add_shape_command.dart';
import 'package:ideascape/features/space/domain/factories/space_object_factory.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

class ShapeToolHandler extends ToolHandler {
  const ShapeToolHandler();

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
    final shapeType = context.read<ToolbarBloc>().state.activeShapeType;

    // Create object using Factory
    final id = getIt<SpaceDataService>().nextUniqueId;
    final newShape = SpaceObjectFactory.createShape(
      id: id,
      type: shapeType,
      center: worldPoint,
    );

    // Execute via HistoryManager (Command Pattern)
    context.read<HistoryManager>().execute(AddShapeCommand(newShape));
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
    final shapeType = context.read<ToolbarBloc>().state.activeShapeType;

    final id = getIt<SpaceDataService>().nextUniqueId;
    final newShape = SpaceObjectFactory.createShape(
      id: id,
      type: shapeType,
      center: worldPoint,
    );

    // Override rect to be zero-size at start point, as we are dragging to create size
    final zeroSizeShape = newShape.copyWith(
      rect: Rect.fromPoints(worldPoint, worldPoint),
    );

    context.read<ActiveLayerBloc>().add(
      ActiveLayerEvent.interactionStarted(
        object: zeroSizeShape,
        point: worldPoint,
      ),
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

    // We expect a single active object during shape creation
    if (startPoint != null && activeState.activeObjects.isNotEmpty) {
      final currentObject = activeState.activeObjects.values.first;

      if (currentObject is ShapeObject) {
        final currentPoint = MatrixUtils.transformPoint(
          Matrix4.inverted(controller.value),
          details.localPosition,
        );

        final newRect = Rect.fromPoints(startPoint, currentPoint);
        final updatedShape = currentObject.copyWith(rect: newRect);

        context.read<ActiveLayerBloc>().add(
          ActiveLayerEvent.objectChanged(updatedShape),
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

      // Commit to history/main layer
      context.read<HistoryManager>().execute(AddShapeCommand(finalObject));

      // Clear active layer
      context.read<ActiveLayerBloc>().add(
        ActiveLayerEvent.objectDeactivated(finalObject.id),
      );
    }
  }
}
