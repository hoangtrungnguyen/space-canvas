import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Paints a preview line while dragging to create a connector.
/// Shows a dashed line from the start object to the current cursor position.
class ConnectorPreviewPainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final Color color;
  final double strokeWidth;

  ConnectorPreviewPainter({
    required this.startPoint,
    required this.endPoint,
    this.color = Colors.blue,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withValues(alpha: 0.7)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    // Draw dashed line
    _drawDashedLine(canvas, startPoint, endPoint, paint);

    // Draw arrow at end point
    _drawArrow(canvas, startPoint, endPoint, paint);
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashLength = 8.0;
    const gapLength = 4.0;

    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = math.sqrt(dx * dx + dy * dy);
    final unitX = dx / distance;
    final unitY = dy / distance;

    var currentDistance = 0.0;
    var drawing = true;

    while (currentDistance < distance) {
      final segmentLength = drawing ? dashLength : gapLength;
      final endDistance = math.min(currentDistance + segmentLength, distance);

      if (drawing) {
        final segmentStart = Offset(
          start.dx + unitX * currentDistance,
          start.dy + unitY * currentDistance,
        );
        final segmentEnd = Offset(
          start.dx + unitX * endDistance,
          start.dy + unitY * endDistance,
        );
        canvas.drawLine(segmentStart, segmentEnd, paint);
      }

      currentDistance = endDistance;
      drawing = !drawing;
    }
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end, Paint linePaint) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final angle = math.atan2(dy, dx);
    const arrowLength = 10.0;

    final arrowPath = Path();
    arrowPath.moveTo(end.dx, end.dy);
    arrowPath.lineTo(
      end.dx - arrowLength * math.cos(angle - math.pi / 6),
      end.dy - arrowLength * math.sin(angle - math.pi / 6),
    );
    arrowPath.lineTo(
      end.dx - arrowLength * math.cos(angle + math.pi / 6),
      end.dy - arrowLength * math.sin(angle + math.pi / 6),
    );
    arrowPath.close();

    canvas.drawPath(
      arrowPath,
      Paint()
        ..color = linePaint.color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant ConnectorPreviewPainter oldDelegate) {
    return oldDelegate.startPoint != startPoint ||
        oldDelegate.endPoint != endPoint ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
