import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

part 'canvas_bloc.freezed.dart';
part 'canvas_event.dart';
part 'canvas_state.dart';

class CanvasBloc extends Bloc<CanvasEvent, CanvasState> {
  CanvasBloc() : super(const CanvasState()) {
    on<_Started>(_onStarted);
    on<_TransformUpdated>(_onTransformUpdated);
    on<_ObjectsUpdated>(_onObjectsUpdated);
  }

  void _onStarted(_Started event, Emitter<CanvasState> emit) {
    // TODO: Implement initialization logic if needed
  }

  void _onTransformUpdated(_TransformUpdated event, Emitter<CanvasState> emit) {
    emit(state.copyWith(offset: event.offset, scale: event.scale));
  }

  void _onObjectsUpdated(_ObjectsUpdated event, Emitter<CanvasState> emit) {
    emit(state.copyWith(objects: event.objects));
  }
}
