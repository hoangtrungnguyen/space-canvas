part of 'toolbar_bloc.dart';

// Since this is a part file, imports must be in the main file (toolbar_bloc.dart) OR we assume they are available.
// But wait, Freezed classes usually need imports where they are defined if they are separate files.
// However, `toolbar_event.dart` is `part of`, so it shares imports with `toolbar_bloc.dart`.
// I need to add import to `toolbar_bloc.dart`.

@freezed
sealed class ToolbarEvent with _$ToolbarEvent {
  const factory ToolbarEvent.selected(SpaceTool tool) = _Selected;
  const factory ToolbarEvent.shapeSelected(ShapeType type) = _ShapeSelected;
  const factory ToolbarEvent.toDefault() = _ToDefault;
  const factory ToolbarEvent.updateDrawingObject(SpaceObject? object) =
      _UpdateDrawingObject;
}
