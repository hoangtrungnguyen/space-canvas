import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// A visitor that handles the painting of [Node]s onto a [Canvas].
class PaintVisitor implements NodeVisitor<void> {
  final Canvas canvas;

  // We can reuse a text painter for performance if needed,
  // or create local ones. Let's keep a shared one for efficiency.
  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  PaintVisitor(this.canvas);

  @override
  void visitPath(PathNode node) {
    canvas.drawPath(node.path, node.paint);
  }

  @override
  void visitShape(ShapeNode node) {
    _drawShape(node);
    _drawShapeLabel(node);
  }

  @override
  void visitText(TextNode node) {
    final textSpan = TextSpan(
      text: node.text,
      style: TextStyle(
        color: Color(node.color),
        fontSize: node.fontSize,
        fontFamily: node.fontFamily,
      ),
    );
    final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, node.position);
  }

  @override
  void visitImage(ImageNode node) {
    canvas.drawRect(
      node.rect,
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
    tp.paint(canvas, node.rect.center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  void visitConnector(ConnectorNode node) {
    final paint =
        Paint()
          ..color = Color(node.color)
          ..strokeWidth = node.strokeWidth
          ..style = PaintingStyle.stroke;

    canvas.drawLine(node.startPoint, node.endPoint, paint);

    final dx = node.endPoint.dx - node.startPoint.dx;
    final dy = node.endPoint.dy - node.startPoint.dy;
    final angle = math.atan2(dy, dx);
    final arrowLength = 10.0;
    final arrowPath = Path();
    arrowPath.moveTo(node.endPoint.dx, node.endPoint.dy);
    arrowPath.lineTo(
      node.endPoint.dx - arrowLength * math.cos(angle - math.pi / 6),
      node.endPoint.dy - arrowLength * math.sin(angle - math.pi / 6),
    );
    arrowPath.lineTo(
      node.endPoint.dx - arrowLength * math.cos(angle + math.pi / 6),
      node.endPoint.dy - arrowLength * math.sin(angle + math.pi / 6),
    );
    arrowPath.close();
    canvas.drawPath(
      arrowPath,
      Paint()
        ..color = Color(node.color)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  void visitGroup(GroupNode node) {
    // No op for now
  }

  @override
  void visitListOfPoint(ListOfPointNode node) {
    if (node.points.length < 2) return;

    final paint =
        Paint()
          ..color = Color(node.color)
          ..strokeWidth = node.strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final path = Path();
    path.moveTo(node.points.first.dx, node.points.first.dy);
    for (int i = 1; i < node.points.length; i++) {
      path.lineTo(node.points[i].dx, node.points[i].dy);
    }

    canvas.drawPath(path, paint);
  }

  void _drawShape(ShapeNode shape) {
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

  void _drawShapeLabel(ShapeNode node) {
    if (node.text.isEmpty) return;

    final textSpan = TextSpan(
      text: node.text,
      style: TextStyle(color: Colors.black, fontSize: 14),
    );
    _textPainter.text = textSpan;
    _textPainter.layout(minWidth: 0, maxWidth: node.rect.width);
    final offset = Offset(
      node.rect.left + (node.rect.width - _textPainter.width) / 2,
      node.rect.top + (node.rect.height - _textPainter.height) / 2,
    );
    _textPainter.paint(canvas, offset);
  }
}
