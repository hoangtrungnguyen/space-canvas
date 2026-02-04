import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';

part 'active_layer_state.freezed.dart';

@freezed
abstract class ActiveLayerState with _$ActiveLayerState {
  const factory ActiveLayerState({
    @Default({}) Map<int, SpaceObject> activeObjects,
    Offset? dragStartPoint,

    /// The original object state before a move operation started.
    /// Used for creating MoveObjectCommand for undo/redo.
    SpaceObject? originalObject,
    ResizeHandle? activeHandle,
  }) = _ActiveLayerState;
}
