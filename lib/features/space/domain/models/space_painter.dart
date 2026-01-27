import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'objects/space_object.dart';

class SpacePainter extends CustomPainter {
  final List<SpaceObject> objects;

  SpacePainter(this.objects);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFF0F2F5),
    );

    // Sort objects by zIndex if needed, but for now assuming list order is draw order or handled by caller
    // The requirement mentions zIndex, so ideally we sort.
    final sortedObjects = List<SpaceObject>.from(objects)
      ..sort((a, b) => a.zIndex.compareTo(b.zIndex));

    for (final object in sortedObjects) {
      if (object is PathObject) {
        canvas.drawPath(object.path, object.paint);
      } else if (object is ShapeObject) {
        _drawShape(canvas, object);
      } else if (object is TextObject) {
        _drawText(canvas, object);
      } else if (object is ImageObject) {
        _drawImage(canvas, object);
      } else if (object is ConnectorObject) {
        _drawConnector(canvas, object);
      } else if (object is GroupObject) {
        _drawGroup(canvas, object);
      }
    }
  }

  void _drawShape(Canvas canvas, ShapeObject shape) {
    switch (shape.type) {
      case ShapeType.rectangle:
        canvas.drawRect(shape.rect, shape.paint);
        break;
      case ShapeType.oval:
        canvas.drawOval(shape.rect, shape.paint);
        break;
      case ShapeType.triangle:
        final path = Path();
        path.moveTo(shape.rect.topCenter.dx, shape.rect.topCenter.dy);
        path.lineTo(shape.rect.bottomRight.dx, shape.rect.bottomRight.dy);
        path.lineTo(shape.rect.bottomLeft.dx, shape.rect.bottomLeft.dy);
        path.close();
        canvas.drawPath(path, shape.paint);
        break;
      case ShapeType.diamond:
        final path = Path();
        path.moveTo(shape.rect.topCenter.dx, shape.rect.topCenter.dy);
        path.lineTo(shape.rect.centerRight.dx, shape.rect.centerRight.dy);
        path.lineTo(shape.rect.bottomCenter.dx, shape.rect.bottomCenter.dy);
        path.lineTo(shape.rect.centerLeft.dx, shape.rect.centerLeft.dy);
        path.close();
        canvas.drawPath(path, shape.paint);
        break;
      case ShapeType.parallelogram:
        final path = Path();
        final skew = shape.rect.width * 0.2;
        path.moveTo(shape.rect.topLeft.dx + skew, shape.rect.topLeft.dy);
        path.lineTo(shape.rect.topRight.dx, shape.rect.topRight.dy);
        path.lineTo(
          shape.rect.bottomRight.dx - skew,
          shape.rect.bottomRight.dy,
        );
        path.lineTo(shape.rect.bottomLeft.dx, shape.rect.bottomLeft.dy);
        path.close();
        canvas.drawPath(path, shape.paint);
        break;
      case ShapeType.database:
        // Cylinder approximation
        final topRect = Rect.fromLTWH(
          shape.rect.left,
          shape.rect.top,
          shape.rect.width,
          shape.rect.height * 0.2,
        );
        final bottomRect = Rect.fromLTWH(
          shape.rect.left,
          shape.rect.bottom - shape.rect.height * 0.2,
          shape.rect.width,
          shape.rect.height * 0.2,
        );

        final path = Path();
        path.moveTo(shape.rect.left, shape.rect.top + shape.rect.height * 0.1);
        path.lineTo(
          shape.rect.left,
          shape.rect.bottom - shape.rect.height * 0.1,
        );
        path.arcTo(bottomRect, 3.14, -3.14, false); // Bottom arc
        path.lineTo(shape.rect.right, shape.rect.top + shape.rect.height * 0.1);
        path.arcTo(
          topRect,
          0,
          -3.14,
          false,
        ); // Top arc back half (hidden if solid) - but let's draw full cylinder logic

        // Actually, simpler: Draw body then top oval
        final bodyPath = Path();
        bodyPath.moveTo(
          shape.rect.left,
          shape.rect.top + shape.rect.height * 0.1,
        );
        bodyPath.lineTo(
          shape.rect.left,
          shape.rect.bottom - shape.rect.height * 0.1,
        );
        bodyPath.arcTo(bottomRect, 3.14159, -3.14159, false);
        bodyPath.lineTo(
          shape.rect.right,
          shape.rect.top + shape.rect.height * 0.1,
        );
        bodyPath.arcTo(topRect, 0, 3.14159, false); // Top front arc
        bodyPath.close();

        canvas.drawPath(bodyPath, shape.paint);
        canvas.drawOval(topRect, shape.paint..style = PaintingStyle.fill);
        canvas.drawOval(
          topRect,
          Paint()
            ..color = shape.paint.color.withValues(alpha: 0.5)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        ); // Outline for top
        break;

      case ShapeType.server:
        // Rectangle with some lines
        canvas.drawRect(shape.rect, shape.paint);
        // Draw simplified server lights/lines
        final linePaint =
            Paint()
              ..color = Colors.black.withValues(alpha: 0.2)
              ..strokeWidth = 2;
        canvas.drawLine(
          Offset(shape.rect.left + 5, shape.rect.top + 10),
          Offset(shape.rect.right - 5, shape.rect.top + 10),
          linePaint,
        );
        canvas.drawLine(
          Offset(shape.rect.left + 5, shape.rect.top + 20),
          Offset(shape.rect.right - 5, shape.rect.top + 20),
          linePaint,
        );
        break;
      case ShapeType.cloud:
        // Simple distinct cloud shape using multiple circles
        final p = Path();
        // A few overlapping circles
        p.addOval(
          Rect.fromCircle(
            center: shape.rect.centerLeft + Offset(shape.rect.width * 0.2, 0),
            radius: shape.rect.height * 0.4,
          ),
        );
        p.addOval(
          Rect.fromCircle(
            center: shape.rect.center,
            radius: shape.rect.height * 0.5,
          ),
        );
        p.addOval(
          Rect.fromCircle(
            center: shape.rect.centerRight - Offset(shape.rect.width * 0.2, 0),
            radius: shape.rect.height * 0.4,
          ),
        );
        canvas.drawPath(p, shape.paint);
        break;
    }
  }

  void _drawText(Canvas canvas, TextObject textObject) {
    final textSpan = TextSpan(
      text: textObject.text,
      style: TextStyle(
        color: Color(textObject.color),
        fontSize: textObject.fontSize,
        fontFamily: textObject.fontFamily,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, textObject.position);
  }

  void _drawImage(Canvas canvas, ImageObject imageObject) {
    // Placeholder for now
    canvas.drawRect(
      imageObject.rect,
      Paint()..color = Colors.grey.withValues(alpha: 0.3),
    );
    final textPainter = TextPainter(
      text: const TextSpan(
        text: "Image",
        style: TextStyle(color: Colors.black54),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      imageObject.rect.center -
          Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  void _drawConnector(Canvas canvas, ConnectorObject connector) {
    // Draw line
    final paint =
        Paint()
          ..color = Color(connector.color)
          ..strokeWidth = connector.strokeWidth
          ..style = PaintingStyle.stroke;

    canvas.drawLine(connector.startPoint, connector.endPoint, paint);

    // Draw Arrowhead at endPoint
    final dx = connector.endPoint.dx - connector.startPoint.dx;
    final dy = connector.endPoint.dy - connector.startPoint.dy;
    final angle = math.atan2(dy, dx);

    final arrowLength = 10.0;
    final arrowPath = Path();
    arrowPath.moveTo(connector.endPoint.dx, connector.endPoint.dy);
    arrowPath.lineTo(
      connector.endPoint.dx - arrowLength * math.cos(angle - math.pi / 6),
      connector.endPoint.dy - arrowLength * math.sin(angle - math.pi / 6),
    );
    arrowPath.lineTo(
      connector.endPoint.dx - arrowLength * math.cos(angle + math.pi / 6),
      connector.endPoint.dy - arrowLength * math.sin(angle + math.pi / 6),
    );
    arrowPath.close();

    canvas.drawPath(
      arrowPath,
      Paint()
        ..color = Color(connector.color)
        ..style = PaintingStyle.fill,
    );
  }

  void _drawGroup(Canvas canvas, GroupObject group) {
    // Groups might render a selection box if selected, but usually they just exist to hold other objects.
    // If the logical objects are in the main list, we don't need to draw the group itself.
    // If the group contains the objects and they are NOT in the main list, we recurse.
    // Assuming flat list structure for now based on Plan (using childrenIds).

    // Draw bounding box debug
    // canvas.drawRect(group.rect, Paint()..style = PaintingStyle.stroke..color = Colors.blue.withValues(alpha: 0.2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
