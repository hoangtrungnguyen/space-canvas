import 'dart:ui';
import 'package:flutter/material.dart'; // For Colors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/paint_visitor.dart';

class MockCanvas extends Mock implements Canvas {}

void main() {
  group('PaintVisitor', () {
    late MockCanvas canvas;
    late PaintVisitor visitor;

    setUp(() {
      canvas = MockCanvas();
      visitor = PaintVisitor(canvas);
      // Register fallback values if needed for verify
      registerFallbackValue(Paint());
      registerFallbackValue(Path());
      registerFallbackValue(const Offset(0, 0));
      registerFallbackValue(const Rect.fromLTWH(0, 0, 0, 0));
    });

    // =========================================================================
    // ShapeNode - Types
    // =========================================================================
    test('should draw ShapeNode (Rectangle)', () {
      final shape = ShapeNode(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      shape.accept(visitor);
      verify(() => canvas.drawRect(shape.rect, any())).called(1);
    });

    test('should draw ShapeNode (Oval)', () {
      final shape = ShapeNode(
        type: ShapeType.oval,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      shape.accept(visitor);
      verify(() => canvas.drawOval(shape.rect, any())).called(1);
    });

    test('should draw ShapeNode (Triangle)', () {
      final shape = ShapeNode(
        type: ShapeType.triangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      shape.accept(visitor);
      verify(() => canvas.drawPath(any(), any())).called(1);
    });

    test('should draw ShapeNode (Diamond)', () {
      final shape = ShapeNode(
        type: ShapeType.diamond,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      shape.accept(visitor);
      verify(() => canvas.drawPath(any(), any())).called(1);
    });

    test('should draw ShapeNode (Parallelogram)', () {
      final shape = ShapeNode(
        type: ShapeType.parallelogram,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      shape.accept(visitor);
      // Parallelogram draws a path
      verify(() => canvas.drawPath(any(), any())).called(1);
    });

    test('should draw ShapeNode (Database)', () {
      final shape = ShapeNode(
        type: ShapeType.database,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      shape.accept(visitor);
      // Database draws: body path, top/bottom ovals
      verify(() => canvas.drawPath(any(), any())).called(1); // Body
      verify(
        () => canvas.drawOval(any(), any()),
      ).called(2); // Top fill + stroke
    });

    test('should draw ShapeNode (Server)', () {
      final shape = ShapeNode(
        type: ShapeType.server,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      shape.accept(visitor);
      // Server draws: Main rect + 2 indicator lines
      verify(() => canvas.drawRect(any(), any())).called(1);
      verify(() => canvas.drawLine(any(), any(), any())).called(2);
    });

    test('should draw ShapeNode (Cloud)', () {
      final shape = ShapeNode(
        type: ShapeType.cloud,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      shape.accept(visitor);
      verify(() => canvas.drawPath(any(), any())).called(1);
    });

    // =========================================================================
    // ShapeNode - Labels
    // =========================================================================
    test('should draw ShapeNode Label', () {
      final shape = ShapeNode(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
        text: 'Shape Label',
      );
      expect(() => shape.accept(visitor), returnsNormally);
      // Testing TextPainter painting on canvas is implicit via no-crash.
      // We can't easily mock TextPainter internal canvas calls here.
    });

    // =========================================================================
    // Other Objects
    // =========================================================================
    test('should draw PathNode', () {
      final path = Path();
      path.moveTo(0, 0);
      path.lineTo(10, 10);
      final pathObj = PathNode(path: path, paint: Paint(), id: 2);
      pathObj.accept(visitor);
      verify(() => canvas.drawPath(path, any())).called(1);
    });

    test('should draw TextNode', () {
      final text = TextNode(
        text: 'Hello',
        position: const Offset(10, 10),
        fontSize: 20,
        color: 0xFF000000,
        id: 3,
      );
      expect(() => text.accept(visitor), returnsNormally);
    });

    test('should draw ConnectorNode', () {
      final connector = ConnectorNode(
        startNodeId: 1,
        endNodeId: 2,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        strokeWidth: 2,
        color: 0xFF000000,
        id: 4,
      );
      connector.accept(visitor);
      // Line + Arrow head path
      verify(() => canvas.drawLine(any(), any(), any())).called(1);
      verify(() => canvas.drawPath(any(), any())).called(1);
    });

    test('should draw ListOfPointNode (valid)', () {
      final points = ListOfPointNode(
        points: const [Offset(0, 0), Offset(100, 100)],
        strokeWidth: 2,
        color: 0xFF000000,
        id: 5,
      );
      points.accept(visitor);
      verify(() => canvas.drawPath(any(), any())).called(1);
    });

    test('should NOT draw ListOfPointNode with too few points', () {
      final points = ListOfPointNode(
        points: const [Offset(0, 0)], // Only 1 point
        strokeWidth: 2,
        color: 0xFF000000,
        id: 6,
      );
      points.accept(visitor);
      verifyNever(() => canvas.drawPath(any(), any()));
    });

    test('should draw ImageNode (Placeholder)', () {
      final img = ImageNode(
        imageUrl: 'test.png',
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        id: 7,
      );
      expect(() => img.accept(visitor), returnsNormally);
      // Image draws a rect placeholder
      verify(() => canvas.drawRect(any(), any())).called(1);
    });

    test('should handle GroupNode (no-op)', () {
      final group = GroupNode(childrenIds: [], rect: Rect.zero, id: 8);
      group.accept(visitor);
      // No canvas calls expected
      verifyZeroInteractions(canvas);
    });
  });
}
