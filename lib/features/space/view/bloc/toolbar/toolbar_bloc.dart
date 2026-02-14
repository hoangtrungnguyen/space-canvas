import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';

part 'toolbar_bloc.freezed.dart';
part 'toolbar_event.dart';
part 'toolbar_state.dart';

class ToolbarBloc extends Bloc<ToolbarEvent, ToolbarState> {
  ToolbarBloc() : super(ToolbarState()) {
    on<_Selected>(_onSelected);
    on<_ShapeSelected>(_onShapeSelected);
    on<_ToDefault>(_onToDefault);
    on<_UpdateDrawingObject>(_onUpdateDrawingObject);
    on<_StartedEditing>(_onStartedEditing);
    on<_EndedEditing>(_onEndedEditing);
    on<_ToggledSelectionTool>(_onToggledSelectionTool);
  }

  FutureOr<void> _onSelected(_Selected event, Emitter<ToolbarState> emit) {
    emit(state.copyWith(tool: event.tool));
  }

  FutureOr<void> _onToDefault(_ToDefault event, Emitter<ToolbarState> emit) {
    emit(ToolbarState());
  }

  FutureOr<void> _onShapeSelected(
    _ShapeSelected event,
    Emitter<ToolbarState> emit,
  ) {
    emit(state.copyWith(tool: SpaceTool.shape, activeShapeType: event.type));
  }

  FutureOr<void> _onUpdateDrawingObject(
    _UpdateDrawingObject event,
    Emitter<ToolbarState> emit,
  ) {
    emit(state.copyWith(activeDrawingObject: event.object));
  }

  FutureOr<void> _onStartedEditing(
    _StartedEditing event,
    Emitter<ToolbarState> emit,
  ) {
    emit(state.copyWith(editingObject: event.object));
  }

  FutureOr<void> _onEndedEditing(
    _EndedEditing event,
    Emitter<ToolbarState> emit,
  ) {
    emit(state.copyWith(editingObject: null));
  }

  FutureOr<void> _onToggledSelectionTool(
    _ToggledSelectionTool event,
    Emitter<ToolbarState> emit,
  ) {
    // For now, we default to generic select as we don't have a point to hit-test against
    // from a simple toggle event.
    // The SelectionManager capability is available if we need to expand this.
    emit(state.copyWith(tool: SpaceTool.select));
  }
}
