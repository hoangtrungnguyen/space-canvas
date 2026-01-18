part of 'toolbar_bloc.dart';

@freezed
abstract class ToolbarState with _$ToolbarState {
  factory ToolbarState({
    @Default(SpaceTool.pan) SpaceTool tool,
    @Default(ShapeType.rectangle) ShapeType activeShapeType,
  }) = _ToolbarState;
}
