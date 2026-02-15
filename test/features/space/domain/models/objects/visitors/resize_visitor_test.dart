import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/resize_visitor.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';

void main() {
  group('ResizeVisitor', () {
    final baseRect = const Rect.fromLTWH(100, 100, 100, 100);
    final baseShape = ShapeNode(
      type: ShapeType.rectangle,
      rect: baseRect,
      color: 0xFF000000,
      id: 1,
    );

    // =========================================================================
    // ShapeNode - Handle Logic
    // =========================================================================
    test('should resize Shape via topLeft', () {
      // Drag TopLeft by (-10, -10) -> Should expand to (90, 90)
      final visitor = ResizeVisitor(
        handle: ResizeHandle.topLeft,
        delta: const Offset(-10, -10),
      );
      final resized = baseShape.accept(visitor) as ShapeNode;
      expect(resized.rect, const Rect.fromLTWH(90, 90, 110, 110));
    });

    test('should resize Shape via topCenter', () {
      // Drag Top by -10 -> Height 110, Top 90, Left/Right constant
      final visitor = ResizeVisitor(
        handle: ResizeHandle.topCenter,
        delta: const Offset(0, -10),
      );
      final resized = baseShape.accept(visitor) as ShapeNode;
      expect(resized.rect, const Rect.fromLTWH(100, 90, 100, 110));
    });

    test('should resize Shape via topRight', () {
      // Drag TopRight by (10, -10) -> Top moves up, Right moves right
      final visitor = ResizeVisitor(
        handle: ResizeHandle.topRight,
        delta: const Offset(10, -10),
      );
      final resized = baseShape.accept(visitor) as ShapeNode;
      // Left: 100 (Unchanged), Top: 90, Right: 210, Bottom: 200
      expect(resized.rect, const Rect.fromLTRB(100, 90, 210, 200));
    });

    test('should resize Shape via centerRight', () {
      final visitor = ResizeVisitor(
        handle: ResizeHandle.centerRight,
        delta: const Offset(10, 0),
      );
      final resized = baseShape.accept(visitor) as ShapeNode;
      expect(resized.rect, const Rect.fromLTRB(100, 100, 210, 200));
    });

    test('should resize Shape via bottomRight', () {
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomRight,
        delta: const Offset(10, 10),
      );
      final resized = baseShape.accept(visitor) as ShapeNode;
      expect(resized.rect, const Rect.fromLTWH(100, 100, 110, 110));
    });

    test('should resize Shape via bottomCenter', () {
      // Drag Bottom down by 10 -> Height 110
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomCenter,
        delta: const Offset(0, 10),
      );
      final resized = baseShape.accept(visitor) as ShapeNode;
      expect(resized.rect, const Rect.fromLTWH(100, 100, 100, 110));
    });

    test('should resize Shape via bottomLeft', () {
      // Drag BottomLeft by (-10, 10) -> Left moves left, Bottom moves down
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomLeft,
        delta: const Offset(-10, 10),
      );
      final resized = baseShape.accept(visitor) as ShapeNode;
      // Left: 90, Top: 100, Right: 200, Bottom: 210
      expect(resized.rect, const Rect.fromLTRB(90, 100, 200, 210));
    });

    test('should resize Shape via centerLeft', () {
      // Drag Left by -10
      final visitor = ResizeVisitor(
        handle: ResizeHandle.centerLeft,
        delta: const Offset(-10, 0),
      );
      final resized = baseShape.accept(visitor) as ShapeNode;
      expect(resized.rect, const Rect.fromLTRB(90, 100, 200, 200));
    });

    // =========================================================================
    // ShapeNode - Edge Cases
    // =========================================================================
    test('should flip horizontal if dragging past edge', () {
      // Drag Right to Left past Left edge (delta = -200)
      // Original Right: 200. New Right: 0.
      // Rect.fromLTRB(100, 100, 0, 200) -> Normalized: Left 0, Width 100.
      final visitor = ResizeVisitor(
        handle: ResizeHandle.centerRight,
        delta: const Offset(-200, 0),
      );
      final resized = baseShape.accept(visitor) as ShapeNode;
      expect(resized.rect.left, 0);
      expect(resized.rect.width, 100);
      expect(resized.rect.right, 100);
    });

    test('should flip vertical if dragging past edge', () {
      // Drag Bottom to Top past Top edge (delta = -200)
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomCenter,
        delta: const Offset(0, -200),
      );
      final resized = baseShape.accept(visitor) as ShapeNode;
      expect(resized.rect.top, 0);
      expect(resized.rect.height, 100);
    });

    // =========================================================================
    // Other Object Types (No-op or TODO behavior)
    // =========================================================================

    test(
      'should return original object for TextNode (Corners - currently no-op)',
      () {
        final text = TextNode(
          id: 2,
          text: 'Test',
          position: const Offset(0, 0),
          fontSize: 14,
          color: 0xFF000000,
        );
        final visitor = ResizeVisitor(
          handle: ResizeHandle.bottomRight, // Corner
          delta: const Offset(10, 10),
        );
        final result = text.accept(visitor);
        expect(result, text);
      },
    );

    test('should return original object for TextNode (Sides - no-op)', () {
      final text = TextNode(
        id: 2,
        text: 'Test',
        position: const Offset(0, 0),
        fontSize: 14,
        color: 0xFF000000,
      );
      final visitor = ResizeVisitor(
        handle: ResizeHandle.centerRight, // Not a corner
        delta: const Offset(10, 0),
      );
      final result = text.accept(visitor);
      expect(result, text);
    });

    test('should return original object for ImageNode (no-op)', () {
      final image = ImageNode(
        id: 4,
        imageUrl: 'assets/test.png',
        rect: const Rect.fromLTWH(0, 0, 100, 100),
      );
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomRight,
        delta: const Offset(10, 10),
      );
      final result = image.accept(visitor);
      expect(result, image);
    });

    test('should return original object for ListOfPointNode (no-op)', () {
      final list = ListOfPointNode(
        id: 5,
        points: [],
        strokeWidth: 1,
        color: 0xFF000000,
      );
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomRight,
        delta: const Offset(10, 10),
      );
      final result = list.accept(visitor);
      expect(result, list);
    });

    test('should return original object for ConnectorNode (no-op)', () {
      final connector = ConnectorNode(
        id: 6,
        startNodeId: 1,
        endNodeId: 2,
        startPoint: Offset.zero,
        endPoint: const Offset(10, 10),
        strokeWidth: 1,
        color: 0xFF000000,
      );
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomRight,
        delta: const Offset(10, 10),
      );
      final result = connector.accept(visitor);
      expect(result, connector);
    });

    test('should return original object for GroupNode (no-op)', () {
      final group = GroupNode(
        id: 7,
        childrenIds: [],
        rect: const Rect.fromLTWH(0, 0, 100, 100),
      );
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomRight,
        delta: const Offset(10, 10),
      );
      final result = group.accept(visitor);
      expect(result, group);
    });
  });
}
