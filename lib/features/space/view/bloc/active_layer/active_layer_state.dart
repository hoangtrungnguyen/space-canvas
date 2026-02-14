import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';
import 'package:ideascape/features/space/domain/models/connector_handle.dart';

part 'active_layer_state.freezed.dart';

@freezed
abstract class ActiveLayerState with _$ActiveLayerState {
  const factory ActiveLayerState({
    @Default({}) Map<int, Node> activeNodes,
    Offset? dragStartPoint,

    /// The original object state before a move operation started.
    /// Used for creating MoveNodeCommand for undo/redo.
    Node? originalNode,
    ResizeHandle? resizeHandle,
    ConnectorHandle? connectorHandle,

    /// The ID of the object where a connector drag started (optional).
    int? connectorStartNodeId,

    /// The starting point of the connector drag.
    Offset? connectorStartPoint,

    /// The current drag position for connector preview.
    Offset? connectorDragPosition,

    /// The ID of the object being hovered while connector tool is active.
    int? connectorHoverNodeId,
  }) = _ActiveLayerState;
}
