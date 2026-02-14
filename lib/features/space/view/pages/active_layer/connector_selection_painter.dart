import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';

class ConnectorSelectionPainter extends CustomPainter {
  final List<ConnectorNode> connectors;
  final Matrix4 transform;
  final Color highlightColor;
  final double highlightWidth;
  final Color endpointColor;
  final double endpointRadius;

  ConnectorSelectionPainter({
    required this.connectors,
    required this.transform,
    this.highlightColor = const Color(0x802196F3), // Semi-transparent blue
    this.highlightWidth = 4.0,
    this.endpointColor = Colors.blue,
    this.endpointRadius = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Scale radius inversely to zoom so they remain constant screen size
    final double scale = transform.getMaxScaleOnAxis();
    final double radius = endpointRadius / scale;

    final highlightPaint =
        Paint()
          ..color = highlightColor
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final endpointPaint =
        Paint()
          ..color = endpointColor
          ..style = PaintingStyle.fill;

    for (final connector in connectors) {
      // 1. Draw the highlight path
      highlightPaint.strokeWidth = connector.strokeWidth + highlightWidth;
      canvas.drawLine(connector.startPoint, connector.endPoint, highlightPaint);

      // 2. Draw endpoints
      canvas.drawCircle(connector.startPoint, radius, endpointPaint);
      canvas.drawCircle(connector.endPoint, radius, endpointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant ConnectorSelectionPainter oldDelegate) {
    return oldDelegate.connectors != connectors ||
        oldDelegate.transform != transform ||
        oldDelegate.highlightColor != highlightColor ||
        oldDelegate.highlightWidth != highlightWidth ||
        oldDelegate.endpointColor != endpointColor ||
        oldDelegate.endpointRadius != endpointRadius;
  }
}
