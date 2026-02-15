import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/utils/shape_path_builder.dart';
import 'package:vector_math/vector_math_64.dart';

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
    @Default(0.0) double rotation,

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

  @override
  Paint get paint =>
      Paint()
        ..color = Color(color)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;

  @override
  Path get path => ShapePathBuilder.buildConnectorPath(startPoint, endPoint);

  @override
  Matrix4 get transform => Matrix4.identity(); // Connectors don't rotate

  @override
  Rect get bounds => rect;
}
