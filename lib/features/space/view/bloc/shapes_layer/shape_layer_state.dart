part of 'shape_layer_bloc.dart';

@freezed
abstract class ShapeLayerState with _$ShapeLayerState {
  factory ShapeLayerState.initialize({required ShapeLayerData data}) =
      ShapeLayerStateInitialize;

  factory ShapeLayerState.loading({required ShapeLayerData data}) =
      ShapeLayerStateLoading;

  factory ShapeLayerState.success({required ShapeLayerData data}) =
      ShapeLayerStateSuccess;

  factory ShapeLayerState.failure({
    required ShapeLayerData data,
    required Exception failure,
  }) = ShapeLayerStateFailure;
}

@freezed
abstract class ShapeLayerData with _$ShapeLayerData {
  const factory ShapeLayerData({
    @Default({}) Map<int, SpaceObject> objects,
    int? selectedTool,
    int? selectedObjectId,
  }) = _ShapeLayerData;
}
