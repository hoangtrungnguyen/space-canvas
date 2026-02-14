part of 'canvas_bloc.dart';

@freezed
abstract class CanvasState with _$CanvasState {
  const factory CanvasState({
    @Default({}) Map<int, Node> objects,
    @Default(Offset.zero) Offset offset,
    @Default(1.0) double scale,
  }) = _CanvasState;
}
