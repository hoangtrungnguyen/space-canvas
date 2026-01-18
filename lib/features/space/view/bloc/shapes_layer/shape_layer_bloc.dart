import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/data_layer/repositories/space_view_repository.dart';
import 'package:ideascape/domain/failure.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

part 'shape_layer_bloc.freezed.dart';
part 'shape_layer_event.dart';
part 'shape_layer_state.dart';

// A unique ID generator for our objects to simplify finding them.
class ShapeLayerBloc extends Bloc<ShapeLayerEvent, ShapeLayerState> {
  final SpaceViewRepository _spaceViewRepository = getIt();
  final SpaceDataService _spaceDataService = getIt();

  final String id;

  ShapeLayerBloc(this.id)
    : super(ShapeLayerState.initialize(data: ShapeLayerData())) {
    on<_Initialized>(_onInitialize);

    on<_ObjectDragged>((event, emit) {});

    on<_ShapeAdded>((event, emit) {
      final id = _spaceDataService.nextUniqueId;
      final newObject = ShapeObject(
        id: id,
        type: event.type,
        rect: Rect.fromCenter(center: event.position, width: 100, height: 100),
        paint:
            Paint()
              ..color = Colors.blue
              ..style = PaintingStyle.fill,
      );
      final newObjects = Map<int, SpaceObject>.from(state.data.objects);
      newObjects[id] = newObject;
      emit(state.copyWith(data: state.data.copyWith(objects: newObjects)));
    });

    on<_TextAdded>((event, emit) {
      final id = _spaceDataService.nextUniqueId;
      final newObject = TextObject(
        id: id,
        text: event.text,
        position: event.position,
        fontSize: 20,
        color: Colors.black.value,
      );
      final newObjects = Map<int, SpaceObject>.from(state.data.objects);
      newObjects[id] = newObject;
      emit(state.copyWith(data: state.data.copyWith(objects: newObjects)));
    });

    on<_ConnectorAdded>((event, emit) {
      final id = _spaceDataService.nextUniqueId;
      // Need to find start and end objects to get their centers?
      // For now assuming startPoint and endPoint are calculated by UI or we use object centers.
      // The event passes IDs.
      final startObj = state.data.objects[event.startId];
      final endObj = state.data.objects[event.endId];
      if (startObj == null || endObj == null) return;

      final newObject = ConnectorObject(
        id: id,
        startObjectId: event.startId,
        endObjectId: event.endId,
        startPoint: startObj.rect.center,
        endPoint: endObj.rect.center,
        strokeWidth: 2,
        color: Colors.black.value,
      );
      final newObjects = Map<int, SpaceObject>.from(state.data.objects);
      newObjects[id] = newObject;
      emit(state.copyWith(data: state.data.copyWith(objects: newObjects)));
    });

    on<_ObjectSelected>((event, emit) {
      emit(
        state.copyWith(
          data: state.data.copyWith(selectedObjectId: event.objectId),
        ),
      );
    });
  }

  Future _onInitialize(
    _Initialized event,
    Emitter<ShapeLayerState> emit,
  ) async {
    try {
      emit(ShapeLayerState.loading(data: state.data));
      final data = await _spaceViewRepository.findById(id);
      final generatedObjects = _spaceDataService.generateInitialObjects();

      emit(
        ShapeLayerState.success(
          data: ShapeLayerData(
            title: data?.name ?? '',
            objects: generatedObjects,
          ),
        ),
      );
    } on Exception catch (e) {
      emit(
        ShapeLayerStateFailure(
          data: ShapeLayerData(),
          failure: Failure(message: e.toString()),
        ),
      );
    }
  }
}
