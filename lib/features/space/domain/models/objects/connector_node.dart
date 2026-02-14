import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

part 'connector_node.freezed.dart';

/// Enum indicating which edge of a node a connector attaches to.
enum ConnectorEdge { north, south, east, west }

@freezed
abstract class ConnectorNode extends Node with _$ConnectorNode {
  factory ConnectorNode({
    int? startNodeId,
    int? endNodeId,
    required Offset startPoint,
    required Offset endPoint,
    required double strokeWidth,
    required int color,
    required int id,
    @Default(0) int zIndex,

    /// Which edge of the start node this connector originates from.
    ConnectorEdge? startLocation,

    /// Which edge of the end node this connector terminates at.
    ConnectorEdge? endLocation,
  }) = _ConnectorNode;

  ConnectorNode._();

  @override
  T accept<T>(NodeVisitor<T> visitor) => visitor.visitConnector(this);

  @override
  Rect get rect => Rect.fromPoints(startPoint, endPoint).inflate(strokeWidth);
}
