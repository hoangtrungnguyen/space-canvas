import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/visitors/paint_visitor.dart';

import 'objects/node.dart';

class NodePainter extends CustomPainter {
  final List<Node> nodes;
  final Matrix4 transform;

  NodePainter({required this.nodes, required this.transform});

  @override
  void paint(Canvas canvas, Size size) {
    // *** PERFORMANCE OPTIMIZATION: VIEW CULLING ***
    final visibleRect = _calculateVisibleRect(canvas, size);

    final visibleNodes = nodes.where((node) => node.rect.overlaps(visibleRect));

    final visitor = PaintVisitor(canvas);
    for (final node in visibleNodes) {
      node.accept(visitor);
    }
  }

  Rect _calculateVisibleRect(Canvas canvas, Size size) {
    final invertedMatrix = Matrix4.inverted(transform);
    final topLeft = MatrixUtils.transformPoint(invertedMatrix, Offset.zero);
    final bottomRight = MatrixUtils.transformPoint(
      invertedMatrix,
      size.bottomRight(Offset.zero),
    );
    return Rect.fromPoints(topLeft, bottomRight).inflate(200.0);
  }

  @override
  bool shouldRepaint(covariant NodePainter oldDelegate) {
    return oldDelegate.nodes != nodes || oldDelegate.transform != transform;
  }
}
