import 'dart:ui';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

/// A visitor that checks if a point hits a [SpaceObject].
class HitTestVisitor implements SpaceObjectVisitor<bool> {
  final Offset point;

  /// The distance within which a hit is considered valid for lines and paths.
  final double threshold;

  const HitTestVisitor(this.point, {this.threshold = 5.0});

  @override
  bool visitShape(ShapeObject object) {
    return object.rect.contains(point);
  }

  @override
  bool visitPath(PathObject object) {
    // Basic implementation: check if point is within the path.
    // Ideally, for thin paths, we should check proximity.
    return object.path.contains(point);
  }

  @override
  bool visitText(TextObject object) {
    return object.rect.contains(point);
  }

  @override
  bool visitImage(ImageObject object) {
    return object.rect.contains(point);
  }

  @override
  bool visitConnector(ConnectorObject object) {
    // For connectors, we can check proximity to the line segment.
    final start = object.startPoint;
    final end = object.endPoint;

    // Distance from point to line segment
    final distance = _distanceToSegment(point, start, end);
    return distance <= (object.strokeWidth / 2 + threshold);
  }

  @override
  bool visitGroup(GroupObject object) {
    return object.rect.contains(point);
  }

  @override
  bool visitListOfPoint(ListOfPointObject object) {
    if (object.points.isEmpty) return false;

    // Check bounding box first for optimization
    if (!object.rect.contains(point)) return false;

    // Check proximity to each segment
    for (int i = 0; i < object.points.length - 1; i++) {
      final start = object.points[i];
      final end = object.points[i + 1];
      final distance = _distanceToSegment(point, start, end);
      if (distance <= (object.strokeWidth / 2 + threshold)) {
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
