import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// A visitor that handles the painting of [Node]s onto a [Canvas].
///
/// Uses each node's [paint], [path], and [transform] properties for rendering,
/// ensuring the domain model is the single source of truth for visual
/// representation.
class PaintVisitor implements NodeVisitor<void> {
  final Canvas canvas;

  // Shared text painter for efficiency.
  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  PaintVisitor(this.canvas);

  @override
  void visitShape(ShapeNode node) {
    canvas.save();
    canvas.transform(node.transform.storage);
    _drawShapeBody(node);
    canvas.restore();
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

    canvas.save();
    canvas.transform(node.transform.storage);
    tp.paint(canvas, node.position);
    canvas.restore();
  }

  @override
  void visitImage(ImageNode node) {
    canvas.save();
    canvas.transform(node.transform.storage);
    canvas.drawRect(node.rect, node.paint);
    final tp = TextPainter(
      text: const TextSpan(
        text: "Image",
        style: TextStyle(color: Colors.black54),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, node.rect.center - Offset(tp.width / 2, tp.height / 2));
    canvas.restore();
  }

  @override
  void visitConnector(ConnectorNode node) {
    canvas.drawLine(node.startPoint, node.endPoint, node.paint);

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

    canvas.save();
    canvas.transform(node.transform.storage);
    canvas.drawPath(node.path, node.paint);
    canvas.restore();
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  void _drawShapeBody(ShapeNode shape) {
    switch (shape.type) {
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
      case ShapeType.database:
        canvas.drawPath(shape.path, shape.paint);
        // Draw the top oval highlight
        final topRect = Rect.fromLTWH(
          shape.rect.left,
          shape.rect.top,
          shape.rect.width,
          shape.rect.height * 0.2,
        );
        canvas.drawOval(
          topRect,
          Paint()
            ..color = Color(shape.color).withValues(alpha: 0.5)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        );
        break;
      default:
        canvas.drawPath(shape.path, shape.paint);
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
