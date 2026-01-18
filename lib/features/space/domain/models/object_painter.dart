import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'objects/space_object.dart';

class ObjectPainter extends CustomPainter {
  final List<SpaceObject> objects;
  final Matrix4 transform;

  ObjectPainter({required this.objects, required this.transform});

  final textPainter = TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    // *** PERFORMANCE OPTIMIZATION: VIEW CULLING ***
    final visibleRect = _calculateVisibleRect(canvas, size);

    // Sort logic from SpacePainter could go here but sorting should ideally happen before painting or be stable.
    // Assuming objects are already sorted by zIndex for correct layering?
    // If not, we should sort:
    // objects.sort((a, b) => a.zIndex.compareTo(b.zIndex));
    // But modifying the list here is bad if it's immutable or performance intensive.
    // Let's rely on the list order provided by Bloc.

    final visibleObjects = objects.where(
      (obj) => obj.rect.overlaps(visibleRect),
    );

    for (final object in visibleObjects) {
      if (object is PathObject) {
        canvas.drawPath(object.path, object.paint);
      } else if (object is ShapeObject) {
        _drawShape(canvas, object);
        _drawShapeLabel(canvas, object);
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

    // Optional: Draw a border around the visible area for debugging.
    // final debugPaint = Paint()
    //       ..color = Colors.red
    //       ..strokeWidth = 2.0
    //       ..style = PaintingStyle.stroke;
    // canvas.drawRect(visibleRect, debugPaint);
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
        bodyPath.arcTo(topRect, 0, 3.14159, false);
        bodyPath.close();

        canvas.drawPath(bodyPath, shape.paint);
        canvas.drawOval(topRect, shape.paint..style = PaintingStyle.fill);
        canvas.drawOval(
          topRect,
          Paint()
            ..color = shape.paint.color.withOpacity(0.5)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        );
        break;
      case ShapeType.server:
        canvas.drawRect(shape.rect, shape.paint);
        final linePaint =
            Paint()
              ..color = Colors.black.withOpacity(0.2)
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
        final p = Path();
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

  void _drawShapeLabel(Canvas canvas, ShapeObject object) {
    if (object.text.isEmpty) return;

    final textSpan = TextSpan(
      text: object.text, // + object.zIndex.toString(),
      style: TextStyle(color: Colors.black, fontSize: 14),
    );
    textPainter.text = textSpan;
    textPainter.layout(minWidth: 0, maxWidth: object.rect.width);
    final offset = Offset(
      object.rect.left + (object.rect.width - textPainter.width) / 2,
      object.rect.top + (object.rect.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, offset);
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
    // Use a local TextPainter or the shared one (careful with reuse if state bleeds, but mostly safe for paint)
    final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, textObject.position);
  }

  void _drawImage(Canvas canvas, ImageObject imageObject) {
    canvas.drawRect(
      imageObject.rect,
      Paint()..color = Colors.grey.withOpacity(0.3),
    );
    final tp = TextPainter(
      text: const TextSpan(
        text: "Image",
        style: TextStyle(color: Colors.black54),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(
      canvas,
      imageObject.rect.center - Offset(tp.width / 2, tp.height / 2),
    );
  }

  void _drawConnector(Canvas canvas, ConnectorObject connector) {
    final paint =
        Paint()
          ..color = Color(connector.color)
          ..strokeWidth = connector.strokeWidth
          ..style = PaintingStyle.stroke;

    canvas.drawLine(connector.startPoint, connector.endPoint, paint);

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
    // No op for now
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
