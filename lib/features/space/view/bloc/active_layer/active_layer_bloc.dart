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
        objectDeactivated: (e) {
          final newObjects = Map<int, SpaceObject>.from(state.activeObjects);
          newObjects.remove(e.objectId);
          emit(state.copyWith(activeObjects: newObjects, dragStartPoint: null));
        },
        clear: (_) {
          emit(state.copyWith(activeObjects: {}, dragStartPoint: null));
        },
      );
    });
  }
}
