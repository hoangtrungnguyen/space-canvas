import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/commands/add_shape_command.dart';
import 'package:ideascape/features/space/domain/commands/batch_delete_command.dart';
import 'package:ideascape/features/space/domain/commands/delete_object_command.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/hit_test_visitor.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

abstract class CanvasInteractionMediator {
  void selectAt(Offset worldPoint, {required bool isDrag});
  void dragActiveObject(Offset worldPoint, Offset delta);
  void finalizeInteraction();
  void commitAndDeactivate();
  void commitImmediate(SpaceObject object);
  void startNewShape(SpaceObject object, Offset worldPoint);
  void updateNewShape(SpaceObject object, Offset worldPoint);
  void startDrawing(ListOfPointObject object, Offset worldPoint);
  void updateDrawing(ListOfPointObject object, Offset worldPoint);
  void deleteObject(SpaceObject object);
  void deleteObjects(List<SpaceObject> objects);
}

class CanvasInteractionMediatorImpl implements CanvasInteractionMediator {
  final ShapeLayerBloc shapeBloc;
  final ActiveLayerBloc activeBloc;
  final HistoryManager history;

  CanvasInteractionMediatorImpl({
    required this.shapeBloc,
    required this.activeBloc,
    required this.history,
  });

  @override
  void selectAt(Offset worldPoint, {required bool isDrag}) {
    final activeState = activeBloc.state;
    final visitor = HitTestVisitor(worldPoint);

    // 1. Check if we hit an ALREADY active object
    if (activeState.activeObjects.isNotEmpty) {
      final activeObj = activeState.activeObjects.values.first;
      if (activeObj.accept(visitor)) {
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
        // Deselect: Commit and deactivate
        commitAndDeactivate();
      }
    }

    // 2. Check if we hit a NEW object in ShapeLayer
    final objects = shapeBloc.state.data.objects.values.toList();
    final hitObjects = objects.where((obj) => obj.accept(visitor)).toList();

    if (hitObjects.isNotEmpty) {
      hitObjects.sort((a, b) => b.zIndex.compareTo(a.zIndex));
      final selected = hitObjects.first;

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
  void dragActiveObject(Offset worldPoint, Offset delta) {
    final state = activeBloc.state;
    if (state.activeObjects.isNotEmpty && state.dragStartPoint != null) {
      final obj = state.activeObjects.values.first;
      final updatedObj = _moveObject(obj, delta);

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
  void finalizeInteraction() {
    final state = activeBloc.state;
    if (state.activeObjects.isNotEmpty) {
      final obj = state.activeObjects.values.first;
      activeBloc.add(ActiveLayerEvent.objectActivated(obj));
    }
  }

  @override
  void commitAndDeactivate() {
    final state = activeBloc.state;
    if (state.activeObjects.isNotEmpty) {
      final obj = state.activeObjects.values.first;
      history.execute(AddShapeCommand(obj));
      activeBloc.add(ActiveLayerEvent.objectDeactivated(obj.id));
    }
  }

  @override
  void commitImmediate(SpaceObject object) {
    history.execute(AddShapeCommand(object));
  }

  @override
  void startNewShape(SpaceObject object, Offset worldPoint) {
    activeBloc.add(
      ActiveLayerEvent.interactionStarted(object: object, point: worldPoint),
    );
  }

  @override
  void updateNewShape(SpaceObject object, Offset worldPoint) {
    activeBloc.add(ActiveLayerEvent.shapeUpdated(object));
  }

  @override
  void startDrawing(ListOfPointObject object, Offset worldPoint) {
    activeBloc.add(
      ActiveLayerEvent.interactionStarted(object: object, point: worldPoint),
    );
  }

  @override
  void updateDrawing(ListOfPointObject object, Offset worldPoint) {
    activeBloc.add(
      ActiveLayerEvent.interactionStarted(object: object, point: worldPoint),
    );
  }

  @override
  void deleteObject(SpaceObject object) {
    history.execute(DeleteObjectCommand(object));
  }

  @override
  void deleteObjects(List<SpaceObject> objects) {
    if (objects.isEmpty) return;
    if (objects.length == 1) {
      deleteObject(objects.first);
    } else {
      history.execute(BatchDeleteCommand(objects));
    }
  }

  SpaceObject? _moveObject(SpaceObject obj, Offset delta) {
    if (obj is ShapeObject) {
      return obj.copyWith(rect: obj.rect.shift(delta));
    } else if (obj is TextObject) {
      return obj.copyWith(position: obj.position + delta);
    } else if (obj is PathObject) {
      return obj.copyWith(path: obj.path.shift(delta));
    } else if (obj is ListOfPointObject) {
      return obj.copyWith(points: obj.points.map((p) => p + delta).toList());
    } else if (obj is ConnectorObject) {
      return obj.copyWith(
        startPoint: obj.startPoint + delta,
        endPoint: obj.endPoint + delta,
      );
    }
    return null;
  }
}
