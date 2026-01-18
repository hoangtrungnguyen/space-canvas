import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

part 'active_layer_bloc.freezed.dart';

@freezed
abstract class ActiveLayerEvent with _$ActiveLayerEvent {
  const factory ActiveLayerEvent.started() = _Started;

  /// Triggered when an object is selected/grabbed for manipulation.
  /// This object should be removed from the ShapeLayer temporarily.
  const factory ActiveLayerEvent.objectActivated(SpaceObject object) =
      _ObjectActivated;

  /// Triggered when manipulation updates the object (e.g. dragging).
  const factory ActiveLayerEvent.objectChanged(SpaceObject object) =
      _ObjectChanged;

  /// Triggered when interaction is done.
  /// The object should be committed back to ShapeLayer.
  const factory ActiveLayerEvent.objectDeactivated(int objectId) =
      _ObjectDeactivated;

  /// Clears all active objects (e.g. when clicking empty space).
  const factory ActiveLayerEvent.clear() = _Clear;
}

@freezed
abstract class ActiveLayerState with _$ActiveLayerState {
  const factory ActiveLayerState({
    @Default({}) Map<int, SpaceObject> activeObjects,
  }) = _ActiveLayerState;
}

class ActiveLayerBloc extends Bloc<ActiveLayerEvent, ActiveLayerState> {
  ActiveLayerBloc() : super(const ActiveLayerState()) {
    on<_ObjectActivated>((event, emit) {
      final newObjects = Map<int, SpaceObject>.from(state.activeObjects);
      newObjects[event.object.id] = event.object;
      emit(state.copyWith(activeObjects: newObjects));
    });

    on<_ObjectChanged>((event, emit) {
      if (state.activeObjects.containsKey(event.object.id)) {
        final newObjects = Map<int, SpaceObject>.from(state.activeObjects);
        newObjects[event.object.id] = event.object;
        emit(state.copyWith(activeObjects: newObjects));
      }
    });

    on<_ObjectDeactivated>((event, emit) {
      final newObjects = Map<int, SpaceObject>.from(state.activeObjects);
      newObjects.remove(event.objectId);
      emit(state.copyWith(activeObjects: newObjects));
    });

    on<_Clear>((event, emit) {
      emit(state.copyWith(activeObjects: {}));
    });
  }
}
