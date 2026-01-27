import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

part 'active_layer_state.freezed.dart';

@freezed
abstract class ActiveLayerState with _$ActiveLayerState {
  const factory ActiveLayerState({
    @Default({}) Map<int, SpaceObject> activeObjects,
    Offset? dragStartPoint,
  }) = _ActiveLayerState;
}
