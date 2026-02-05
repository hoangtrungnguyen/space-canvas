import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';

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

  /// Triggered when a shape is updated during creation (dragging).
  /// Does NOT modify dragStartPoint - preserves original start point.
  const factory ActiveLayerEvent.shapeUpdated(SpaceObject object) =
      _ShapeUpdated;

  /// Triggered when interaction is done.
  /// The object should be committed back to ShapeLayer.
  const factory ActiveLayerEvent.objectDeactivated(int objectId) =
      _ObjectDeactivated;

  /// Sets the original object state before a move operation.
  /// Used for creating MoveObjectCommand for undo/redo.
  const factory ActiveLayerEvent.originalObjectSet(SpaceObject? object) =
      _OriginalObjectSet;

  /// Clears all active objects (e.g. when clicking empty space).
  const factory ActiveLayerEvent.clear() = _Clear;

  const factory ActiveLayerEvent.handleChanged(ResizeHandle? handle) =
      _HandleChanged;

  /// Triggered when a connector drag starts.
  const factory ActiveLayerEvent.connectorDragStarted({
    int? startObjectId,
    required Offset startPoint,
  }) = _ConnectorDragStarted;

  /// Triggered when the connector drag position updates.
  const factory ActiveLayerEvent.connectorDragUpdated(Offset position) =
      _ConnectorDragUpdated;

  /// Triggered when a connector drag ends.
  const factory ActiveLayerEvent.connectorDragEnded() = _ConnectorDragEnded;

  /// Triggered when hovering over an object with connector tool.
  const factory ActiveLayerEvent.connectorHoverChanged(int? objectId) =
      _ConnectorHoverChanged;
}
