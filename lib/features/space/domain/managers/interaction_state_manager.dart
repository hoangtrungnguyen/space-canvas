import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/commands/add_connector_command.dart';
import 'package:ideascape/features/space/domain/commands/add_shape_command.dart';
import 'package:ideascape/features/space/domain/models/connector_handle.dart';
import 'package:ideascape/features/space/domain/commands/reshape_connector_command.dart';
import 'package:ideascape/features/space/domain/commands/batch_delete_command.dart';
import 'package:ideascape/features/space/domain/commands/delete_object_command.dart';
import 'package:ideascape/features/space/domain/commands/move_object_command.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/objects/extensions/space_object_extensions.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

/// Manages the lifecycle of interactions, including committing changes,
/// finalizing moves, and handling deletions.
class InteractionStateManager {
  final ActiveLayerBloc activeBloc;
  final ShapeLayerBloc shapeBloc;
  final HistoryManager history;

  InteractionStateManager({
    required this.activeBloc,
    required this.shapeBloc,
    required this.history,
  });

  void finalizeInteraction() {
    final state = activeBloc.state;
    if (state.activeObjects.isNotEmpty) {
      final obj = state.activeObjects.values.first;
      final originalObject = state.originalObject;

      // If we have an original object and position changed, record the move
      if (originalObject != null && originalObject.id == obj.id) {
        // Check if the object actually moved
        if (_hasObjectMoved(originalObject, obj)) {
          history.execute(
            MoveObjectCommand(originalObject: originalObject, movedObject: obj),
          );
        }
      }

      activeBloc.add(ActiveLayerEvent.objectActivated(obj));
    }
  }

  void commitAndDeactivate() {
    final state = activeBloc.state;
    if (state.activeObjects.isNotEmpty) {
      final obj = state.activeObjects.values.first;
      final originalObj = state.originalObject;

      final existsInShapeLayer = shapeBloc.state.data.objects.containsKey(
        obj.id,
      );

      // An object is "existing" if it's in the ShapeLayer OR if we have its original state tracked
      final isExisting =
          existsInShapeLayer ||
          (originalObj != null && originalObj.id == obj.id);

      if (isExisting) {
        // If the object exists, we should finalize any pending interactions (moves, reshapes)
        if (obj is ConnectorObject) {
          finalizeConnectorInteraction();
        } else {
          finalizeInteraction();
        }

        // If the object was removed from ShapeLayer (e.g. valid "Layer Hopping") but NOT modified,
        // no Command would have been executed by finalize* methods.
        // We must manually restore it to the ShapeLayer in this case.
        if (!existsInShapeLayer && originalObj != null) {
          bool changed = false;
          if (obj is ConnectorObject) {
            // Connector interactions generally create a new instance if changed
            changed = (originalObj != obj);
          } else {
            changed = _hasObjectMoved(originalObj, obj);
          }

          if (!changed) {
            shapeBloc.add(ShapeLayerEvent.addObject(obj));
          }
        }
      } else {
        // It's a truly new object (or we lost tracking), so add it via Command
        history.execute(AddShapeCommand(obj));
      }

      activeBloc.add(ActiveLayerEvent.objectDeactivated(obj.id));
    }
  }

  void commitImmediate(SpaceObject object) {
    history.execute(AddShapeCommand(object));
  }

  void deleteObject(SpaceObject object) {
    history.execute(DeleteObjectCommand(object));
  }

  void deleteObjects(List<SpaceObject> objects) {
    if (objects.isEmpty) return;
    if (objects.length == 1) {
      deleteObject(objects.first);
    } else {
      history.execute(BatchDeleteCommand(objects));
    }
  }

  void createConnector({
    required Offset startPoint,
    required Offset endPoint,
    int? startObjectId,
    int? endObjectId,
    ConnectorEdge? startLocation,
    ConnectorEdge? endLocation,
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
      startLocation: startLocation,
      endLocation: endLocation,
    );
    history.execute(AddConnectorCommand(connector));
  }

  /// Checks if an object has actually moved from its original position.
  bool _hasObjectMoved(SpaceObject original, SpaceObject current) {
    return current.hasMovedFrom(original);
  }

  void dragActiveObject(Offset worldPoint, Offset delta) {
    final state = activeBloc.state;
    if (state.activeObjects.isNotEmpty && state.dragStartPoint != null) {
      final obj = state.activeObjects.values.first;
      final updatedObj = obj.move(delta);

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

  void dragActiveConnector(Offset worldPoint, Offset delta) {
    final state = activeBloc.state;
    if (state.activeObjects.isNotEmpty && state.dragStartPoint != null) {
      final obj = state.activeObjects.values.first;

      if (obj is ConnectorObject) {
        ConnectorObject updatedConnector;
        if (state.connectorHandle == ConnectorHandle.start) {
          updatedConnector = obj.copyWith(startPoint: obj.startPoint + delta);
        } else if (state.connectorHandle == ConnectorHandle.end) {
          updatedConnector = obj.copyWith(endPoint: obj.endPoint + delta);
        } else {
          updatedConnector = obj.copyWith(
            startPoint: obj.startPoint + delta,
            endPoint: obj.endPoint + delta,
          );
        }

        activeBloc.add(
          ActiveLayerEvent.interactionStarted(
            object: updatedConnector,
            point: worldPoint,
          ),
        );
      }
    }
  }

  void finalizeConnectorInteraction() {
    final state = activeBloc.state;
    if (state.activeObjects.isNotEmpty) {
      final obj = state.activeObjects.values.first;
      if (obj is ConnectorObject) {
        final original = state.originalObject;
        if (original is ConnectorObject && original.id == obj.id) {
          if (original != obj) {
            history.execute(
              ReshapeConnectorCommand(
                originalObject: original,
                modifiedObject: obj,
              ),
            );
          }
        }
        activeBloc.add(ActiveLayerEvent.objectActivated(obj));
      }
    }
  }
}
