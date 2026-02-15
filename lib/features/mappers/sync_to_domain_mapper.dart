import 'dart:ui';

import 'package:ideascape/data/models/connector_node.dart' as sync_connector;
import 'package:ideascape/data/models/container_node.dart' as sync_container;
import 'package:ideascape/data/models/drawing_node.dart' as sync_drawing;
import 'package:ideascape/data/models/node.dart' as sync_node;
import 'package:ideascape/data/models/node_type.dart';
import 'package:ideascape/data/models/text_node.dart' as sync_text;
import 'package:ideascape/data/models/vector_node.dart' as sync_vector;
import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// Maps sync-layer [sync_node.SyncNode] objects into domain-layer [Node] objects.
///
/// Unwraps [SyncableProperty] values, converts types (hex → ARGB,
/// String ID → int, x/y/w/h → Rect), and produces immutable Freezed models.
class SyncToDomainMapper {
  const SyncToDomainMapper();

  /// Dispatches to the appropriate mapping method based on runtime type.
  Node mapNode(sync_node.SyncNode node) {
    return switch (node) {
      sync_vector.VectorNode n => _mapVector(n),
      sync_text.TextNode n => _mapText(n),
      sync_drawing.DrawingNode n => _mapDrawing(n),
      sync_connector.ConnectorNode n => _mapConnector(n),
      sync_container.ContainerNode n => _mapContainer(n),
      _ =>
        throw UnimplementedError('No mapping for SyncNode type: ${node.type}'),
    };
  }

  ShapeNode _mapVector(sync_vector.VectorNode node) {
    return ShapeNode(
      id: _parseId(node.id),
      type: _mapShapeType(node.type),
      rect: Rect.fromLTWH(
        node.x.value,
        node.y.value,
        node.width.value,
        node.height.value,
      ),
      color: _parseColor(node.fillColor.value),
      strokeWidth: node.strokeWidth.value,
      rotation: node.rotation.value,
    );
  }

  TextNode _mapText(sync_text.TextNode node) {
    return TextNode(
      id: _parseId(node.id),
      text: node.content.value,
      position: Offset(node.x.value, node.y.value),
      fontSize: node.fontSize.value,
      color: _parseColor('#000000'), // Sync TextNode has no color property
      rotation: node.rotation.value,
    );
  }

  ListOfPointNode _mapDrawing(sync_drawing.DrawingNode node) {
    return ListOfPointNode(
      id: _parseId(node.id),
      points: _parsePoints(node.points.value),
      strokeWidth: node.strokeWidth.value,
      color: _parseColor(node.color.value),
      rotation: node.rotation.value,
    );
  }

  ConnectorNode _mapConnector(sync_connector.ConnectorNode node) {
    return ConnectorNode(
      id: _parseId(node.id),
      startNodeId:
          node.startNodeId.value != null
              ? _parseId(node.startNodeId.value!)
              : null,
      endNodeId:
          node.endNodeId.value != null ? _parseId(node.endNodeId.value!) : null,
      startPoint: Offset(node.startX.value, node.startY.value),
      endPoint: Offset(node.endX.value, node.endY.value),
      strokeWidth: 2.0,
      color: 0xFF000000,
      rotation: node.rotation.value,
    );
  }

  GroupNode _mapContainer(sync_container.ContainerNode node) {
    return GroupNode(
      id: _parseId(node.id),
      childrenIds: node.children.map((c) => _parseId(c.id)).toList(),
      rect: Rect.fromLTWH(node.x.value, node.y.value, 0, 0),
      rotation: node.rotation.value,
    );
  }

  // ---------------------------------------------------------------------------
  // Conversion helpers
  // ---------------------------------------------------------------------------

  /// Converts a String ID (UUID) to an int via hashCode.
  int _parseId(String id) => id.hashCode;

  /// Converts a hex color string (e.g. "#FF0000") to an ARGB int.
  /// Supports "#RGB", "#RRGGBB", and "#AARRGGBB" formats.
  int _parseColor(String hex) {
    var h = hex.replaceFirst('#', '');
    if (h.length == 3) {
      // #RGB → #RRGGBB
      h = h.split('').map((c) => '$c$c').join();
    }
    if (h.length == 6) {
      // #RRGGBB → add full alpha
      h = 'FF$h';
    }
    return int.parse(h, radix: 16);
  }

  /// Maps sync-layer [NodeType] to domain-layer [ShapeType].
  ShapeType _mapShapeType(NodeType type) {
    return switch (type) {
      NodeType.rectangle => ShapeType.rectangle,
      NodeType.ellipse => ShapeType.oval,
      NodeType.vector => ShapeType.rectangle,
      _ => ShapeType.rectangle,
    };
  }

  /// Converts a flat list of doubles [x1, y1, x2, y2, ...] to [List<Offset>].
  List<Offset> _parsePoints(List<double> flat) {
    final offsets = <Offset>[];
    for (var i = 0; i + 1 < flat.length; i += 2) {
      offsets.add(Offset(flat[i], flat[i + 1]));
    }
    return offsets;
  }
}
