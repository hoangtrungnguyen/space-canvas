import 'dart:ui';
import 'dart:math' as math;
import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// Builds a [Path] for a given [ShapeType] within the given [Rect].
///
/// This is a shared utility used by [Node] subclasses (for paint properties)
/// and [PaintVisitor] (for drawing), ensuring consistent shape geometry.
class ShapePathBuilder {
  const ShapePathBuilder._();

  static Path buildPath(ShapeType type, Rect rect) {
    switch (type) {
      case ShapeType.rectangle:
        return Path()..addRect(rect);
      case ShapeType.oval:
        return Path()..addOval(rect);
      case ShapeType.triangle:
        return _buildTriangle(rect);
      case ShapeType.diamond:
        return _buildDiamond(rect);
      case ShapeType.parallelogram:
        return _buildParallelogram(rect);
      case ShapeType.database:
        return _buildDatabase(rect);
      case ShapeType.server:
        return Path()..addRect(rect);
      case ShapeType.cloud:
        return _buildCloud(rect);
    }
  }

  static Path _buildTriangle(Rect rect) {
    return Path()
      ..moveTo(rect.topCenter.dx, rect.topCenter.dy)
      ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy)
      ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..close();
  }

  static Path _buildDiamond(Rect rect) {
    return Path()
      ..moveTo(rect.topCenter.dx, rect.topCenter.dy)
      ..lineTo(rect.centerRight.dx, rect.centerRight.dy)
      ..lineTo(rect.bottomCenter.dx, rect.bottomCenter.dy)
      ..lineTo(rect.centerLeft.dx, rect.centerLeft.dy)
      ..close();
  }

  static Path _buildParallelogram(Rect rect) {
    final skew = rect.width * 0.2;
    return Path()
      ..moveTo(rect.topLeft.dx + skew, rect.topLeft.dy)
      ..lineTo(rect.topRight.dx, rect.topRight.dy)
      ..lineTo(rect.bottomRight.dx - skew, rect.bottomRight.dy)
      ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..close();
  }

  static Path _buildDatabase(Rect rect) {
    final topRect = Rect.fromLTWH(
      rect.left,
      rect.top,
      rect.width,
      rect.height * 0.2,
    );
    final bottomRect = Rect.fromLTWH(
      rect.left,
      rect.bottom - rect.height * 0.2,
      rect.width,
      rect.height * 0.2,
    );

    final path = Path();
    path.moveTo(rect.left, rect.top + rect.height * 0.1);
    path.lineTo(rect.left, rect.bottom - rect.height * 0.1);
    path.arcTo(bottomRect, math.pi, -math.pi, false);
    path.lineTo(rect.right, rect.top + rect.height * 0.1);
    path.arcTo(topRect, 0, math.pi, false);
    path.close();

    // Add the top oval for the database "lid"
    path.addOval(topRect);

    return path;
  }

  static Path _buildCloud(Rect rect) {
    final path = Path();
    path.addOval(
      Rect.fromCircle(
        center: rect.centerLeft + Offset(rect.width * 0.2, 0),
        radius: rect.height * 0.4,
      ),
    );
    path.addOval(
      Rect.fromCircle(center: rect.center, radius: rect.height * 0.5),
    );
    path.addOval(
      Rect.fromCircle(
        center: rect.centerRight - Offset(rect.width * 0.2, 0),
        radius: rect.height * 0.4,
      ),
    );
    return path;
  }

  /// Builds a Path for a [ListOfPointNode]'s points.
  static Path buildPointsPath(List<Offset> points) {
    if (points.length < 2) return Path();
    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    return path;
  }

  /// Builds a Path for a connector (line + arrowhead).
  static Path buildConnectorPath(Offset startPoint, Offset endPoint) {
    final path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.lineTo(endPoint.dx, endPoint.dy);

    // Arrowhead
    final dx = endPoint.dx - startPoint.dx;
    final dy = endPoint.dy - startPoint.dy;
    final angle = math.atan2(dy, dx);
    const arrowLength = 10.0;
    path.moveTo(endPoint.dx, endPoint.dy);
    path.lineTo(
      endPoint.dx - arrowLength * math.cos(angle - math.pi / 6),
      endPoint.dy - arrowLength * math.sin(angle - math.pi / 6),
    );
    path.moveTo(endPoint.dx, endPoint.dy);
    path.lineTo(
      endPoint.dx - arrowLength * math.cos(angle + math.pi / 6),
      endPoint.dy - arrowLength * math.sin(angle + math.pi / 6),
    );

    return path;
  }
}
