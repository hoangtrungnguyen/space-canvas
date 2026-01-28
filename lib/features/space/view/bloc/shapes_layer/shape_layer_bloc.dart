import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/failure.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

part 'shape_layer_bloc.freezed.dart';
part 'shape_layer_event.dart';
part 'shape_layer_state.dart';

// A unique ID generator for our objects to simplify finding them.
class ShapeLayerBloc extends Bloc<ShapeLayerEvent, ShapeLayerState> {
  final SpaceDataService _spaceDataService = getIt();

  final String id;

  ShapeLayerBloc(this.id)
    : super(ShapeLayerState.initialize(data: ShapeLayerData())) {
    on<_Initialized>(_onInitialize);

    on<_ObjectDragged>((event, emit) {});

    on<_AddObject>((event, emit) {
      final newObjects = Map<int, SpaceObject>.from(state.data.objects);
      newObjects[event.object.id] = event.object;
      emit(state.copyWith(data: state.data.copyWith(objects: newObjects)));
    });

    on<_RemoveObject>((event, emit) {
      final newObjects = Map<int, SpaceObject>.from(state.data.objects);
      newObjects.remove(event.objectId);
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
      final generatedObjects = _spaceDataService.generateInitialObjects();

      emit(
        ShapeLayerState.success(
          data: ShapeLayerData(objects: generatedObjects),
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
