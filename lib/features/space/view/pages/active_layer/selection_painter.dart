import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

class SelectionPainter extends CustomPainter {
  final List<SpaceObject> objects;
  final Matrix4 transform;
  final double padding;

  SelectionPainter({
    required this.objects,
    required this.transform,
    this.padding = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (objects.isEmpty) return;

    final paint =
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    for (final object in objects) {
      final rect = object.rect.inflate(padding);
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SelectionPainter oldDelegate) {
    return oldDelegate.objects != objects ||
        oldDelegate.transform != transform ||
        oldDelegate.padding != padding;
  }
}
