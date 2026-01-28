part of 'shape_layer_bloc.dart';

@freezed
class ShapeLayerEvent with _$ShapeLayerEvent {
  const factory ShapeLayerEvent.initialize() = _Initialized;

  const factory ShapeLayerEvent.objectDragged({
    required int objectId,
    required Offset delta,
  }) = _ObjectDragged;

  const factory ShapeLayerEvent.addObject(SpaceObject object) = _AddObject;

  const factory ShapeLayerEvent.removeObject(int objectId) = _RemoveObject;

  const factory ShapeLayerEvent.shapeSelected({required int objectId}) =
      _ShapeSelected;

  const factory ShapeLayerEvent.objectSelected(int? objectId) = _ObjectSelected;
}
