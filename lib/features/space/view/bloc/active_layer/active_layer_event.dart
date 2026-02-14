import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';
import 'package:ideascape/features/space/domain/models/connector_handle.dart';

part 'active_layer_event.freezed.dart';

@freezed
class ActiveLayerEvent with _$ActiveLayerEvent {
  const factory ActiveLayerEvent.started() = _Started;

  /// Triggered when a node is selected/grabbed for manipulation.
  /// This node should be removed from the ShapeLayer temporarily.
  const factory ActiveLayerEvent.nodeActivated(Node node) = _NodeActivated;

  /// Triggered when manipulation updates the node (e.g. dragging).
  const factory ActiveLayerEvent.nodeChanged(Node node) = _NodeChanged;

  /// Triggered when a new interaction starts (e.g. creating a shape).
  const factory ActiveLayerEvent.interactionStarted({
    required Node node,
    required Offset point,
  }) = _InteractionStarted;

  /// Triggered when a shape is updated during creation (dragging).
  /// Does NOT modify dragStartPoint - preserves original start point.
  const factory ActiveLayerEvent.shapeUpdated(Node node) = _ShapeUpdated;

  /// Triggered when interaction is done.
  /// The node should be committed back to ShapeLayer.
  const factory ActiveLayerEvent.nodeDeactivated(int nodeId) = _NodeDeactivated;

  /// Sets the original node state before a move operation.
  /// Used for creating MoveNodeCommand for undo/redo.
  const factory ActiveLayerEvent.originalNodeSet(Node? node) = _OriginalNodeSet;

  /// Clears all active nodes (e.g. when clicking empty space).
  const factory ActiveLayerEvent.clear() = _Clear;

  const factory ActiveLayerEvent.handleChanged(ResizeHandle? handle) =
      _HandleChanged;

  const factory ActiveLayerEvent.connectorHandleSelected(
    ConnectorHandle? handle,
  ) = _ConnectorHandleSelected;

  /// Triggered when a connector drag starts.
  const factory ActiveLayerEvent.connectorDragStarted({
    int? startNodeId,
    required Offset startPoint,
  }) = _ConnectorDragStarted;

  /// Triggered when the connector drag position updates.
  const factory ActiveLayerEvent.connectorDragUpdated(Offset position) =
      _ConnectorDragUpdated;

  /// Triggered when a connector drag ends.
  const factory ActiveLayerEvent.connectorDragEnded() = _ConnectorDragEnded;

  /// Triggered when hovering over a node with connector tool.
  const factory ActiveLayerEvent.connectorHoverChanged(int? nodeId) =
      _ConnectorHoverChanged;
}
