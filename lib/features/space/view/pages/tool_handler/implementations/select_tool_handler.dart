import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/commands/add_shape_command.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/hit_test_visitor.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';

class SelectToolHandler extends ToolHandler {
  const SelectToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    _handleSelection(details.localPosition, context, controller, isDrag: false);
  }

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    _handleSelection(details.localPosition, context, controller, isDrag: true);
  }

  void _handleSelection(
    Offset localPosition,
    BuildContext context,
    TransformationController controller, {
    required bool isDrag,
  }) {
    final worldPoint = MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      localPosition,
    );

    final shapeBloc = context.read<ShapeLayerBloc>();
    final activeBloc = context.read<ActiveLayerBloc>();
    final history = context.read<HistoryManager>();

    final activeState = activeBloc.state;
    final visitor = HitTestVisitor(worldPoint);

    // 1. Check if we hit an ALREADY active object
    if (activeState.activeObjects.isNotEmpty) {
      final activeObj = activeState.activeObjects.values.first;
      if (activeObj.accept(visitor)) {
        // If it's a drag, start interaction
        if (isDrag) {
          activeBloc.add(
            ActiveLayerEvent.interactionStarted(
              object: activeObj,
              point: worldPoint,
            ),
          );
        }
        return;
      } else {
        // We clicked outside the active object.
        // Commit it back to main layer first.
        history.execute(AddShapeCommand(activeObj));
        activeBloc.add(ActiveLayerEvent.objectDeactivated(activeObj.id));
      }
    }

    // 2. Check if we hit a NEW object in ShapeLayer
    final objects = shapeBloc.state.data.objects.values.toList();
    final hitObjects = objects.where((obj) => obj.accept(visitor)).toList();

    if (hitObjects.isNotEmpty) {
      // Pick top-most
      hitObjects.sort((a, b) => b.zIndex.compareTo(a.zIndex));
      final selected = hitObjects.first;

      // Transfer to active layer
      shapeBloc.add(ShapeLayerEvent.removeObject(selected.id));
      activeBloc.add(
        ActiveLayerEvent.interactionStarted(
          object: selected,
          point: worldPoint,
        ),
      );
    } else {
      shapeBloc.add(const ShapeLayerEvent.objectSelected(null));
    }
  }

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;

    if (state.activeObjects.isNotEmpty && state.dragStartPoint != null) {
      final worldPoint = MatrixUtils.transformPoint(
        Matrix4.inverted(controller.value),
        details.localPosition,
      );

      final delta = worldPoint - state.dragStartPoint!;

      // Update object position
      final obj = state.activeObjects.values.first;

      SpaceObject? updatedObj;
      if (obj is ShapeObject) {
        updatedObj = obj.copyWith(rect: obj.rect.shift(delta));
      } else if (obj is TextObject) {
        updatedObj = obj.copyWith(position: obj.position + delta);
      } else if (obj is PathObject) {
        updatedObj = obj.copyWith(path: obj.path.shift(delta));
      } else if (obj is ListOfPointObject) {
        updatedObj = obj.copyWith(
          points: obj.points.map((p) => p + delta).toList(),
        );
      } else if (obj is ConnectorObject) {
        updatedObj = obj.copyWith(
          startPoint: obj.startPoint + delta,
          endPoint: obj.endPoint + delta,
        );
      }

      if (updatedObj != null) {
        activeBloc.add(
          ActiveLayerEvent.interactionStarted(
            object: updatedObj,
            point: worldPoint,
          ),
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
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;

    // We do NOT deactivate here. Just stop the "drag" state by clearing dragStartPoint.
    // However, ActiveLayerEvent.objectActivated keeps the object but sets dragStartPoint to null
    // Actually, interactionStarted sets it. We need an event that just resets the point or
    // we use objectActivated.

    if (state.activeObjects.isNotEmpty) {
      final obj = state.activeObjects.values.first;
      activeBloc.add(ActiveLayerEvent.objectActivated(obj));
    }
  }
}
