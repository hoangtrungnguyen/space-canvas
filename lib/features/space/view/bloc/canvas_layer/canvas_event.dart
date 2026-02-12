part of 'canvas_bloc.dart';

@freezed
sealed class CanvasEvent with _$CanvasEvent {
  const factory CanvasEvent.started() = _Started;
  const factory CanvasEvent.transformUpdated({
    required Offset offset,
    required double scale,
  }) = _TransformUpdated;
  const factory CanvasEvent.objectsUpdated(Map<int, SpaceObject> objects) =
      _ObjectsUpdated;
}
