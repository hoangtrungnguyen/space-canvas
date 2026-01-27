import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

part 'active_layer_event.freezed.dart';

@freezed
class ActiveLayerEvent with _$ActiveLayerEvent {
  const factory ActiveLayerEvent.started() = _Started;

  /// Triggered when an object is selected/grabbed for manipulation.
  /// This object should be removed from the ShapeLayer temporarily.
  const factory ActiveLayerEvent.objectActivated(SpaceObject object) =
      _ObjectActivated;

  /// Triggered when manipulation updates the object (e.g. dragging).
  const factory ActiveLayerEvent.objectChanged(SpaceObject object) =
      _ObjectChanged;

  /// Triggered when a new interaction starts (e.g. creating a shape).
  const factory ActiveLayerEvent.interactionStarted({
    required SpaceObject object,
    required Offset point,
  }) = _InteractionStarted;

  /// Triggered when interaction is done.
  /// The object should be committed back to ShapeLayer.
  const factory ActiveLayerEvent.objectDeactivated(int objectId) =
      _ObjectDeactivated;

  /// Clears all active objects (e.g. when clicking empty space).
  const factory ActiveLayerEvent.clear() = _Clear;
}
