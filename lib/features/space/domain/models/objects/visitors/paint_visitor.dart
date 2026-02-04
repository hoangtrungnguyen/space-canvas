import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

/// A visitor that handles the painting of [SpaceObject]s onto a [Canvas].
class PaintVisitor implements SpaceObjectVisitor<void> {
  final Canvas canvas;

  // We can reuse a text painter for performance if needed,
  // or create local ones. Let's keep a shared one for efficiency.
  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  PaintVisitor(this.canvas);

  @override
  void visitPath(PathObject object) {
    canvas.drawPath(object.path, object.paint);
  }

  @override
  void visitShape(ShapeObject object) {
    _drawShape(object);
    _drawShapeLabel(object);
  }

  @override
  void visitText(TextObject object) {
    final textSpan = TextSpan(
      text: object.text,
      style: TextStyle(
        color: Color(object.color),
        fontSize: object.fontSize,
        fontFamily: object.fontFamily,
      ),
    );
    final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, object.position);
  }

  @override
  void visitImage(ImageObject object) {
    canvas.drawRect(
      object.rect,
      Paint()..color = Colors.grey.withValues(alpha: 0.3),
    );
    final tp = TextPainter(
      text: const TextSpan(
        text: "Image",
        style: TextStyle(color: Colors.black54),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, object.rect.center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  void visitConnector(ConnectorObject object) {
    final paint =
        Paint()
          ..color = Color(object.color)
          ..strokeWidth = object.strokeWidth
          ..style = PaintingStyle.stroke;

    canvas.drawLine(object.startPoint, object.endPoint, paint);

    final dx = object.endPoint.dx - object.startPoint.dx;
    final dy = object.endPoint.dy - object.startPoint.dy;
    final angle = math.atan2(dy, dx);
    final arrowLength = 10.0;
    final arrowPath = Path();
    arrowPath.moveTo(object.endPoint.dx, object.endPoint.dy);
    arrowPath.lineTo(
      object.endPoint.dx - arrowLength * math.cos(angle - math.pi / 6),
      object.endPoint.dy - arrowLength * math.sin(angle - math.pi / 6),
    );
    arrowPath.lineTo(
      object.endPoint.dx - arrowLength * math.cos(angle + math.pi / 6),
      object.endPoint.dy - arrowLength * math.sin(angle + math.pi / 6),
    );
    arrowPath.close();
    canvas.drawPath(
      arrowPath,
      Paint()
        ..color = Color(object.color)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  void visitGroup(GroupObject object) {
    // No op for now
  }

  @override
  void visitListOfPoint(ListOfPointObject object) {
    if (object.points.length < 2) return;

    final paint =
        Paint()
          ..color = Color(object.color)
          ..strokeWidth = object.strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final path = Path();
    path.moveTo(object.points.first.dx, object.points.first.dy);
    for (int i = 1; i < object.points.length; i++) {
      path.lineTo(object.points[i].dx, object.points[i].dy);
    }

    canvas.drawPath(path, paint);
  }

  void _drawShape(ShapeObject shape) {
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
        // Clone the paint to avoid mutating the original object's paint.
        final fillPaint =
            Paint()
              ..color = shape.paint.color
              ..style = PaintingStyle.fill;
        canvas.drawOval(topRect, fillPaint);
        canvas.drawOval(
          topRect,
          Paint()
            ..color = shape.paint.color.withValues(alpha: 0.5)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        );
        break;
      case ShapeType.server:
        canvas.drawRect(shape.rect, shape.paint);
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

  void _drawShapeLabel(ShapeObject object) {
    if (object.text.isEmpty) return;

    final textSpan = TextSpan(
      text: object.text,
      style: TextStyle(color: Colors.black, fontSize: 14),
    );
    _textPainter.text = textSpan;
    _textPainter.layout(minWidth: 0, maxWidth: object.rect.width);
    final offset = Offset(
      object.rect.left + (object.rect.width - _textPainter.width) / 2,
      object.rect.top + (object.rect.height - _textPainter.height) / 2,
    );
    _textPainter.paint(canvas, offset);
  }
}
