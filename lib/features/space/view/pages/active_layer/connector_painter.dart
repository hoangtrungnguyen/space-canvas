import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/paint_visitor.dart';

class ConnectorPainter extends CustomPainter {
  final List<ConnectorNode> connectors;
  final Matrix4 transform;

  ConnectorPainter({required this.connectors, required this.transform});

  @override
  void paint(Canvas canvas, Size size) {
    // *** PERFORMANCE OPTIMIZATION: VIEW CULLING ***
    final visibleRect = _calculateVisibleRect(canvas, size);

    final visibleConnectors = connectors.where(
      (obj) => obj.rect.overlaps(visibleRect),
    );

    final visitor = PaintVisitor(canvas);
    for (final connector in visibleConnectors) {
      connector.accept(visitor);
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
  bool shouldRepaint(covariant ConnectorPainter oldDelegate) {
    return oldDelegate.connectors != connectors ||
        oldDelegate.transform != transform;
  }
}
