import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

import 'package:ideascape/features/space/domain/models/resize_handle.dart';

class SelectionPainter extends CustomPainter {
  final List<Node> nodes;
  final Matrix4 transform;
  final double padding;
  final ResizeHandle? activeHandle;

  SelectionPainter({
    required this.nodes,
    required this.transform,
    this.padding = 4.0,
    this.activeHandle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (nodes.isEmpty) return;

    final paint =
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    final handlePaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    final handleBorderPaint =
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    final activeHandlePaint =
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill;

    // Scale handles inversely to zoom so they remain constant screen size
    final double scale = transform.getMaxScaleOnAxis();
    final double handleRadius = 4.0 / scale;

    for (final node in nodes) {
      final rect = node.rect.inflate(padding);
      canvas.drawRect(rect, paint);

      // Draw handles
      _drawHandle(
        canvas,
        rect.topLeft,
        ResizeHandle.topLeft,
        handleRadius,
        handlePaint,
        handleBorderPaint,
        activeHandlePaint,
      );
      _drawHandle(
        canvas,
        rect.topCenter,
        ResizeHandle.topCenter,
        handleRadius,
        handlePaint,
        handleBorderPaint,
        activeHandlePaint,
      );
      _drawHandle(
        canvas,
        rect.topRight,
        ResizeHandle.topRight,
        handleRadius,
        handlePaint,
        handleBorderPaint,
        activeHandlePaint,
      );
      _drawHandle(
        canvas,
        rect.centerRight,
        ResizeHandle.centerRight,
        handleRadius,
        handlePaint,
        handleBorderPaint,
        activeHandlePaint,
      );
      _drawHandle(
        canvas,
        rect.bottomRight,
        ResizeHandle.bottomRight,
        handleRadius,
        handlePaint,
        handleBorderPaint,
        activeHandlePaint,
      );
      _drawHandle(
        canvas,
        rect.bottomCenter,
        ResizeHandle.bottomCenter,
        handleRadius,
        handlePaint,
        handleBorderPaint,
        activeHandlePaint,
      );
      _drawHandle(
        canvas,
        rect.bottomLeft,
        ResizeHandle.bottomLeft,
        handleRadius,
        handlePaint,
        handleBorderPaint,
        activeHandlePaint,
      );
      _drawHandle(
        canvas,
        rect.centerLeft,
        ResizeHandle.centerLeft,
        handleRadius,
        handlePaint,
        handleBorderPaint,
        activeHandlePaint,
      );
    }
  }

  void _drawHandle(
    Canvas canvas,
    Offset center,
    ResizeHandle handle,
    double radius,
    Paint fillPaint,
    Paint borderPaint,
    Paint activePaint,
  ) {
    if (activeHandle == handle) {
      canvas.drawCircle(center, radius, activePaint);
    } else {
      canvas.drawCircle(center, radius, fillPaint);
      canvas.drawCircle(center, radius, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant SelectionPainter oldDelegate) {
    return oldDelegate.nodes != nodes ||
        oldDelegate.transform != transform ||
        oldDelegate.padding != padding ||
        oldDelegate.activeHandle != activeHandle;
  }
}
