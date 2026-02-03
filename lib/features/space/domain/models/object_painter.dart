import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/paint_visitor.dart';

import 'objects/space_object.dart';

class ObjectPainter extends CustomPainter {
  final List<SpaceObject> objects;
  final Matrix4 transform;

  ObjectPainter({required this.objects, required this.transform});

  @override
  void paint(Canvas canvas, Size size) {
    // *** PERFORMANCE OPTIMIZATION: VIEW CULLING ***
    final visibleRect = _calculateVisibleRect(canvas, size);

    final visibleObjects = objects.where(
      (obj) => obj.rect.overlaps(visibleRect),
    );

    final visitor = PaintVisitor(canvas);
    for (final object in visibleObjects) {
      object.accept(visitor);
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
  bool shouldRepaint(covariant ObjectPainter oldDelegate) {
    return oldDelegate.objects != objects || oldDelegate.transform != transform;
  }
}
