import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// Paints anchor point indicators (small circles) on an object
/// when the connector tool is hovering over it.
class ConnectorAnchorPainter extends CustomPainter {
  final Node node;
  final Color anchorColor;
  final double anchorRadius;

  ConnectorAnchorPainter({
    required this.node,
    this.anchorColor = Colors.blue,
    this.anchorRadius = 6.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = node.rect;

    final fillPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    final strokePaint =
        Paint()
          ..color = anchorColor
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;

    // Draw anchor points at the center of each edge
    final anchorPoints = [
      rect.topCenter,
      rect.bottomCenter,
      rect.centerLeft,
      rect.centerRight,
    ];

    for (final point in anchorPoints) {
      // Draw white fill
      canvas.drawCircle(point, anchorRadius, fillPaint);
      // Draw blue border
      canvas.drawCircle(point, anchorRadius, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant ConnectorAnchorPainter oldDelegate) {
    return oldDelegate.node != node ||
        oldDelegate.anchorColor != anchorColor ||
        oldDelegate.anchorRadius != anchorRadius;
  }
}
