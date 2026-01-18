import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';

part 'toolbar_bloc.freezed.dart';
part 'toolbar_event.dart';
part 'toolbar_state.dart';

class ToolbarBloc extends Bloc<ToolbarEvent, ToolbarState> {
  ToolbarBloc() : super(ToolbarState()) {
    on<_Selected>(_onSelected);
    on<_ShapeSelected>(_onShapeSelected);
    on<_ToDefault>(_onToDefault);
  }

  FutureOr<void> _onSelected(_Selected event, Emitter<ToolbarState> emit) {
    emit(state.copyWith(tool: event.tool));
  }

  FutureOr<void> _onToDefault(_ToDefault event, Emitter<ToolbarState> emit) {
    emit(ToolbarState());
  }

  FutureOr<void> _onShapeSelected(_ShapeSelected event, Emitter<ToolbarState> emit) {
    emit(state.copyWith(tool: SpaceTool.shape, activeShapeType: event.type));
  }
}
