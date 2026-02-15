import 'dart:ui';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// A visitor that checks if a point hits a [Node].
class HitTestVisitor implements NodeVisitor<bool> {
  final Offset point;

  /// The distance within which a hit is considered valid for lines and paths.
  final double threshold;

  const HitTestVisitor(this.point, {this.threshold = 5.0});

  @override
  bool visitShape(ShapeNode node) {
    return node.rect.contains(point);
  }

  @override
  bool visitText(TextNode node) {
    return node.rect.contains(point);
  }

  @override
  bool visitImage(ImageNode node) {
    return node.rect.contains(point);
  }

  @override
  bool visitConnector(ConnectorNode node) {
    // For connectors, we can check proximity to the line segment.
    final start = node.startPoint;
    final end = node.endPoint;

    // Distance from point to line segment
    final distance = _distanceToSegment(point, start, end);
    return distance <= (node.strokeWidth / 2 + threshold);
  }

  @override
  bool visitGroup(GroupNode node) {
    return node.rect.contains(point);
  }

  @override
  bool visitListOfPoint(ListOfPointNode node) {
    if (node.points.isEmpty) return false;

    // Check bounding box first for optimization
    if (!node.rect.contains(point)) return false;

    // Check proximity to each segment
    for (int i = 0; i < node.points.length - 1; i++) {
      final start = node.points[i];
      final end = node.points[i + 1];
      final distance = _distanceToSegment(point, start, end);
      if (distance <= (node.strokeWidth / 2 + threshold)) {
        return true;
      }
    }
    return false;
  }

  double _distanceToSegment(Offset p, Offset a, Offset b) {
    final ab = b - a;
    final ap = p - a;

    // Guard against zero-length segments (a == b) to prevent division by zero.
    final abLengthSquared = ab.dx * ab.dx + ab.dy * ab.dy;
    if (abLengthSquared == 0) {
      // Segment is a point; return distance from p to a.
      return ap.distance;
    }

    double t = (ap.dx * ab.dx + ap.dy * ab.dy) / abLengthSquared;
    t = t.clamp(0.0, 1.0);

    final closestPoint = a + ab * t;
    return (p - closestPoint).distance;
  }
}
