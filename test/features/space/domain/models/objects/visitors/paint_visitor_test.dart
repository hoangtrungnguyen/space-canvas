import 'dart:ui';
import 'package:flutter/material.dart'; // For Colors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/visitors/paint_visitor.dart';

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

    // All shapes now use canvas.save/transform/drawPath/restore pattern.
    // Specific shapes like server and database add extra draw calls.

    test('should draw ShapeNode (Rectangle)', () {
      final shape = ShapeNode(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
        id: 1,
      );
      shape.accept(visitor);
      verify(() => canvas.save()).called(1);
      verify(() => canvas.drawPath(any(), any())).called(1);
      verify(() => canvas.restore()).called(1);
    });

    test('should draw ShapeNode (Oval)', () {
      final shape = ShapeNode(
        type: ShapeType.oval,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
        id: 1,
      );
      shape.accept(visitor);
      verify(() => canvas.save()).called(1);
      verify(() => canvas.drawPath(any(), any())).called(1);
      verify(() => canvas.restore()).called(1);
    });

    test('should draw ShapeNode (Triangle)', () {
      final shape = ShapeNode(
        type: ShapeType.triangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
        id: 1,
      );
      shape.accept(visitor);
      verify(() => canvas.drawPath(any(), any())).called(1);
    });

    test('should draw ShapeNode (Diamond)', () {
      final shape = ShapeNode(
        type: ShapeType.diamond,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
        id: 1,
      );
      shape.accept(visitor);
      verify(() => canvas.drawPath(any(), any())).called(1);
    });

    test('should draw ShapeNode (Parallelogram)', () {
      final shape = ShapeNode(
        type: ShapeType.parallelogram,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
        id: 1,
      );
      shape.accept(visitor);
      verify(() => canvas.drawPath(any(), any())).called(1);
    });

    test('should draw ShapeNode (Database)', () {
      final shape = ShapeNode(
        type: ShapeType.database,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
        id: 1,
      );
      shape.accept(visitor);
      // Database draws: body path, then top oval highlight
      verify(() => canvas.drawPath(any(), any())).called(1);
      verify(() => canvas.drawOval(any(), any())).called(1);
    });

    test('should draw ShapeNode (Server)', () {
      final shape = ShapeNode(
        type: ShapeType.server,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
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
        color: 0xFF000000,
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
        color: 0xFF000000,
        id: 1,
        text: 'Shape Label',
      );
      expect(() => shape.accept(visitor), returnsNormally);
    });

    // =========================================================================
    // Other Objects
    // =========================================================================

    test('should draw TextNode', () {
      final text = TextNode(
        text: 'Hello',
        position: const Offset(10, 10),
        fontSize: 20,
        color: 0xFF000000,
        id: 3,
      );
      expect(() => text.accept(visitor), returnsNormally);
      // Verify save/restore for transform
      verify(() => canvas.save()).called(1);
      verify(() => canvas.restore()).called(1);
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
      verify(() => canvas.save()).called(1);
      verify(() => canvas.drawPath(any(), any())).called(1);
      verify(() => canvas.restore()).called(1);
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
      verify(() => canvas.save()).called(1);
      verify(() => canvas.drawRect(any(), any())).called(1);
      verify(() => canvas.restore()).called(1);
    });

    test('should handle GroupNode (no-op)', () {
      final group = GroupNode(childrenIds: [], rect: Rect.zero, id: 8);
      group.accept(visitor);
      // No canvas calls expected
      verifyZeroInteractions(canvas);
    });

    // =========================================================================
    // Node paint properties
    // =========================================================================

    test('ShapeNode has correct paint properties', () {
      final shape = ShapeNode(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(10, 20, 100, 50),
        color: 0xFFFF0000,
        id: 1,
      );
      expect(shape.paint.color, const Color(0xFFFF0000));
      expect(shape.paint.style, PaintingStyle.fill);
      expect(shape.path.getBounds(), const Rect.fromLTWH(10, 20, 100, 50));
    });

    test('ConnectorNode has correct paint properties', () {
      final connector = ConnectorNode(
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        strokeWidth: 3,
        color: 0xFF00FF00,
        id: 2,
      );
      expect(connector.paint.color, const Color(0xFF00FF00));
      expect(connector.paint.style, PaintingStyle.stroke);
      expect(connector.paint.strokeWidth, 3.0);
      expect(connector.transform, Matrix4.identity());
    });

    test('ListOfPointNode has correct paint properties', () {
      final points = ListOfPointNode(
        points: const [Offset(0, 0), Offset(50, 50)],
        strokeWidth: 2,
        color: 0xFF0000FF,
        id: 3,
      );
      expect(points.paint.color, const Color(0xFF0000FF));
      expect(points.paint.style, PaintingStyle.stroke);
      expect(points.paint.strokeCap, StrokeCap.round);
    });
  });
}
