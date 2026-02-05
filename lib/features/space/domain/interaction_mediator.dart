import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/commands/add_shape_command.dart';
import 'package:ideascape/features/space/domain/commands/batch_delete_command.dart';
import 'package:ideascape/features/space/domain/commands/delete_object_command.dart';
import 'package:ideascape/features/space/domain/commands/move_object_command.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/hit_test_visitor.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/extensions/space_object_extensions.dart';

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
  void createConnector({
    required Offset startPoint,
    required Offset endPoint,
    int? startObjectId,
    int? endObjectId,
  });
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
          // Store the original object state for undo/redo
          activeBloc.add(ActiveLayerEvent.originalObjectSet(activeObj));
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

      // Store the original object state for undo/redo when selecting from ShapeLayer
      activeBloc.add(ActiveLayerEvent.originalObjectSet(selected));

      shapeBloc.add(ShapeLayerEvent.removeObject(selected.id));
      activeBloc.add(
        ActiveLayerEvent.interactionStarted(
          object: selected,
          point: worldPoint,
        ),
      );
    } else {
      activeBloc.add(const ActiveLayerEvent.originalObjectSet(null));
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
      final originalObject = state.originalObject;

      // If we have an original object and position changed, record the move
      if (originalObject != null && originalObject.id == obj.id) {
        // Check if the object actually moved
        // Check if the object actually moved
        if (_hasObjectMoved(originalObject, obj)) {
          history.execute(
            MoveObjectCommand(originalObject: originalObject, movedObject: obj),
          );
        }
        // Do NOT clear the original object here.
        // It serves as a reference for 'commitAndDeactivate' to know
        // that this object is a modified version of an existing one (identity match),
        // preventing it from being added as a 'new' shape command.
        // The original object will be cleared when the object is finally deactivated.
        // activeBloc.add(const ActiveLayerEvent.originalObjectSet(null));
      }

      activeBloc.add(ActiveLayerEvent.objectActivated(obj));
    }
  }

  /// Checks if an object has actually moved from its original position.
  /// Uses the HasMovedVisitor via the extension method for clean, polymorphic logic.
  bool _hasObjectMoved(SpaceObject original, SpaceObject current) {
    return current.hasMovedFrom(original);
  }

  @override
  void commitAndDeactivate() {
    final state = activeBloc.state;
    if (state.activeObjects.isNotEmpty) {
      final obj = state.activeObjects.values.first;

      // Check if the object already exists in ShapeLayer (e.g., from MoveObjectCommand)
      // If it does, we don't need to add it again
      final existsInShapeLayer = shapeBloc.state.data.objects.containsKey(
        obj.id,
      );

      if (!existsInShapeLayer) {
        // If the object was originally in the ShapeLayer (we have an original reference)
        // AND it hasn't effectively changed identity (id match),
        // we should just put it back without a History Command (AddShapeCommand).
        // Using AddShapeCommand here would mean "Undo" deletes the object, which is wrong
        // if we just selected it and clicked away/undo.
        final original = state.originalObject;
        if (original != null && original.id == obj.id) {
          shapeBloc.add(ShapeLayerEvent.addObject(obj));
        } else {
          // It's a truly new object (or we lost tracking), so add it via Command
          history.execute(AddShapeCommand(obj));
        }
      }

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

  @override
  void createConnector({
    required Offset startPoint,
    required Offset endPoint,
    int? startObjectId,
    int? endObjectId,
  }) {
    final id = DateTime.now().microsecondsSinceEpoch; // Simple unique ID
    final connector = ConnectorObject(
      id: id,
      startObjectId: startObjectId,
      endObjectId: endObjectId,
      startPoint: startPoint,
      endPoint: endPoint,
      strokeWidth: 2.0,
      color: Colors.black.value,
    );
    history.execute(AddShapeCommand(connector));
  }

  /// Moves an object by the given delta.
  /// Uses the MoveVisitor via the extension method for clean, polymorphic logic.
  SpaceObject? _moveObject(SpaceObject obj, Offset delta) {
    return obj.move(delta);
  }
}
