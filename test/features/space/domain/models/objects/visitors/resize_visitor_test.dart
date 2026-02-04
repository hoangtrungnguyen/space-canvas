import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/resize_visitor.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';

void main() {
  group('ResizeVisitor', () {
    final baseRect = const Rect.fromLTWH(100, 100, 100, 100);
    final baseShape = ShapeObject(
      type: ShapeType.rectangle,
      rect: baseRect,
      paint: Paint(),
      id: 1,
    );

    // =========================================================================
    // ShapeObject - Handle Logic
    // =========================================================================
    test('should resize Shape via topLeft', () {
      // Drag TopLeft by (-10, -10) -> Should expand to (90, 90)
      final visitor = ResizeVisitor(
        handle: ResizeHandle.topLeft,
        delta: const Offset(-10, -10),
      );
      final resized = baseShape.accept(visitor) as ShapeObject;
      expect(resized.rect, const Rect.fromLTWH(90, 90, 110, 110));
    });

    test('should resize Shape via topCenter', () {
      // Drag Top by -10 -> Height 110, Top 90, Left/Right constant
      final visitor = ResizeVisitor(
        handle: ResizeHandle.topCenter,
        delta: const Offset(0, -10),
      );
      final resized = baseShape.accept(visitor) as ShapeObject;
      expect(resized.rect, const Rect.fromLTWH(100, 90, 100, 110));
    });

    test('should resize Shape via topRight', () {
      // Drag TopRight by (10, -10) -> Top moves up, Right moves right
      final visitor = ResizeVisitor(
        handle: ResizeHandle.topRight,
        delta: const Offset(10, -10),
      );
      final resized = baseShape.accept(visitor) as ShapeObject;
      // Left: 100 (Unchanged), Top: 90, Right: 210, Bottom: 200
      expect(resized.rect, const Rect.fromLTRB(100, 90, 210, 200));
    });

    test('should resize Shape via centerRight', () {
      final visitor = ResizeVisitor(
        handle: ResizeHandle.centerRight,
        delta: const Offset(10, 0),
      );
      final resized = baseShape.accept(visitor) as ShapeObject;
      expect(resized.rect, const Rect.fromLTRB(100, 100, 210, 200));
    });

    test('should resize Shape via bottomRight', () {
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomRight,
        delta: const Offset(10, 10),
      );
      final resized = baseShape.accept(visitor) as ShapeObject;
      expect(resized.rect, const Rect.fromLTWH(100, 100, 110, 110));
    });

    test('should resize Shape via bottomCenter', () {
      // Drag Bottom down by 10 -> Height 110
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomCenter,
        delta: const Offset(0, 10),
      );
      final resized = baseShape.accept(visitor) as ShapeObject;
      expect(resized.rect, const Rect.fromLTWH(100, 100, 100, 110));
    });

    test('should resize Shape via bottomLeft', () {
      // Drag BottomLeft by (-10, 10) -> Left moves left, Bottom moves down
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomLeft,
        delta: const Offset(-10, 10),
      );
      final resized = baseShape.accept(visitor) as ShapeObject;
      // Left: 90, Top: 100, Right: 200, Bottom: 210
      expect(resized.rect, const Rect.fromLTRB(90, 100, 200, 210));
    });

    test('should resize Shape via centerLeft', () {
      // Drag Left by -10
      final visitor = ResizeVisitor(
        handle: ResizeHandle.centerLeft,
        delta: const Offset(-10, 0),
      );
      final resized = baseShape.accept(visitor) as ShapeObject;
      expect(resized.rect, const Rect.fromLTRB(90, 100, 200, 200));
    });

    // =========================================================================
    // ShapeObject - Edge Cases
    // =========================================================================
    test('should flip horizontal if dragging past edge', () {
      // Drag Right to Left past Left edge (delta = -200)
      // Original Right: 200. New Right: 0.
      // Rect.fromLTRB(100, 100, 0, 200) -> Normalized: Left 0, Width 100.
      final visitor = ResizeVisitor(
        handle: ResizeHandle.centerRight,
        delta: const Offset(-200, 0),
      );
      final resized = baseShape.accept(visitor) as ShapeObject;
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
      final resized = baseShape.accept(visitor) as ShapeObject;
      expect(resized.rect.top, 0);
      expect(resized.rect.height, 100);
    });

    // =========================================================================
    // Other Object Types (No-op or TODO behavior)
    // =========================================================================

    test(
      'should return original object for TextObject (Corners - currently no-op)',
      () {
        final text = TextObject(
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

    test('should return original object for TextObject (Sides - no-op)', () {
      final text = TextObject(
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

    test('should return original object for PathObject (no-op)', () {
      final path = PathObject(id: 3, path: Path(), paint: Paint());
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomRight,
        delta: const Offset(10, 10),
      );
      final result = path.accept(visitor);
      expect(result, path);
    });

    test('should return original object for ImageObject (no-op)', () {
      final image = ImageObject(
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

    test('should return original object for ListOfPointObject (no-op)', () {
      final list = ListOfPointObject(
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

    test('should return original object for ConnectorObject (no-op)', () {
      final connector = ConnectorObject(
        id: 6,
        startObjectId: 1,
        endObjectId: 2,
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

    test('should return original object for GroupObject (no-op)', () {
      final group = GroupObject(
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
