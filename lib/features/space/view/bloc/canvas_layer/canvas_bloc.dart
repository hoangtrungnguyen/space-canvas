import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

part 'canvas_bloc.freezed.dart';

@freezed
abstract class CanvasEvent with _$CanvasEvent {
  const factory CanvasEvent.started() = _Started;
  const factory CanvasEvent.transformUpdated({
    required Offset offset,
    required double scale,
  }) = _TransformUpdated;
  const factory CanvasEvent.objectsUpdated(Map<int, SpaceObject> objects) =
      _ObjectsUpdated;
}

@freezed
abstract class CanvasState with _$CanvasState {
  const factory CanvasState({
    @Default({}) Map<int, SpaceObject> objects,
    @Default(Offset.zero) Offset offset,
    @Default(1.0) double scale,
  }) = _CanvasState;
}

class CanvasBloc extends Bloc<CanvasEvent, CanvasState> {
  CanvasBloc() : super(const CanvasState()) {
    on<_Started>((event, emit) {
      // TODO: Implement initialization logic if needed
    });

    on<_TransformUpdated>((event, emit) {
      emit(state.copyWith(offset: event.offset, scale: event.scale));
    });

    on<_ObjectsUpdated>((event, emit) {
      emit(state.copyWith(objects: event.objects));
    });
  }
}
