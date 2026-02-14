import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';

class ConnectorUtils {
  /// Calculates the [ConnectorEdge] (closest edge) of a [Rect] from a given [point].
  static ConnectorEdge getEdgeFromPoint(Rect rect, Offset point) {
    // Find the closest edge
    final double distTop = (point.dy - rect.top).abs();
    final double distBottom = (point.dy - rect.bottom).abs();
    final double distLeft = (point.dx - rect.left).abs();
    final double distRight = (point.dx - rect.right).abs();

    double min = distTop;
    ConnectorEdge edge = ConnectorEdge.north;

    if (distBottom < min) {
      min = distBottom;
      edge = ConnectorEdge.south;
    }
    if (distLeft < min) {
      min = distLeft;
      edge = ConnectorEdge.west;
    }
    if (distRight < min) {
      min = distRight;
      edge = ConnectorEdge.east;
    }
    return edge;
  }

  /// Calculates the connection point [Offset] on a [Rect] for a given [ConnectorEdge].
  static Offset getPointOnEdge(Rect rect, ConnectorEdge edge) {
    switch (edge) {
      case ConnectorEdge.north:
        return rect.topCenter;
      case ConnectorEdge.south:
        return rect.bottomCenter;
      case ConnectorEdge.east:
        return rect.centerRight;
      case ConnectorEdge.west:
        return rect.centerLeft;
    }
  }
}
