import 'package:bloc/bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';

import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';

class ActiveLayerBloc extends Bloc<ActiveLayerEvent, ActiveLayerState> {
  ActiveLayerBloc() : super(const ActiveLayerState()) {
    on<ActiveLayerEvent>((event, emit) {
      event.map(
        started: (_) {},
        objectActivated: (e) {
          final newObjects = Map<int, SpaceObject>.from(state.activeObjects);
          newObjects[e.object.id] = e.object;
          emit(state.copyWith(activeObjects: newObjects));
        },
        objectChanged: (e) {
          if (state.activeObjects.containsKey(e.object.id)) {
            final newObjects = Map<int, SpaceObject>.from(state.activeObjects);
            newObjects[e.object.id] = e.object;
            emit(state.copyWith(activeObjects: newObjects));
          }
        },
        interactionStarted: (e) {
          final newObjects = Map<int, SpaceObject>.from(state.activeObjects);
          newObjects[e.object.id] = e.object;
          emit(
            state.copyWith(activeObjects: newObjects, dragStartPoint: e.point),
          );
        },
        shapeUpdated: (e) {
          final newObjects = Map<int, SpaceObject>.from(state.activeObjects);
          newObjects[e.object.id] = e.object;
          emit(state.copyWith(activeObjects: newObjects));
        },
        objectDeactivated: (e) {
          final newObjects = Map<int, SpaceObject>.from(state.activeObjects);
          newObjects.remove(e.objectId);
          emit(
            state.copyWith(
              activeObjects: newObjects,
              dragStartPoint: null,
              originalObject: null,
            ),
          );
        },
        originalObjectSet: (e) {
          emit(state.copyWith(originalObject: e.object));
        },
        clear: (_) {
          emit(
            state.copyWith(
              activeObjects: {},
              dragStartPoint: null,
              originalObject: null,
            ),
          );
        },
        handleChanged: (e) {
          emit(state.copyWith(activeHandle: e.handle));
        },
        connectorDragStarted: (e) {
          emit(
            state.copyWith(
              connectorStartObjectId: e.startObjectId,
              connectorStartPoint: e.startPoint,
              connectorDragPosition: null,
            ),
          );
        },
        connectorDragUpdated: (e) {
          emit(state.copyWith(connectorDragPosition: e.position));
        },
        connectorDragEnded: (_) {
          emit(
            state.copyWith(
              connectorStartObjectId: null,
              connectorStartPoint: null,
              connectorDragPosition: null,
            ),
          );
        },
        connectorHoverChanged: (e) {
          emit(state.copyWith(connectorHoverObjectId: e.objectId));
        },
      );
    });
  }
}
