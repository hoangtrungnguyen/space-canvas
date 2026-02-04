import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/resize_visitor.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';

void main() {
  group('ResizeVisitor', () {
    test('should resize Shape via topLeft', () {
      final shape = ShapeObject(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 100, 100),
        paint: Paint(),
        id: 1,
      );
      // Drag TopLeft by (-10, -10) -> Should expand to (90, 90)
      final visitor = ResizeVisitor(
        handle: ResizeHandle.topLeft,
        delta: const Offset(-10, -10),
      );

      final resized = shape.accept(visitor) as ShapeObject;
      expect(resized.rect, const Rect.fromLTWH(90, 90, 110, 110));
    });

    test('should resize Shape via bottomRight', () {
      final shape = ShapeObject(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 100, 100),
        paint: Paint(),
        id: 1,
      );
      // Drag BottomRight by (10, 10) -> Should expand to 110x110
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomRight,
        delta: const Offset(10, 10),
      );

      final resized = shape.accept(visitor) as ShapeObject;
      expect(resized.rect, const Rect.fromLTWH(100, 100, 110, 110));
    });

    test('should resize Shape via topCenter', () {
      final shape = ShapeObject(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 100, 100),
        paint: Paint(),
        id: 1,
      );
      // Drag Top by -10 -> Height 110, Top 90, Left/Right constant
      final visitor = ResizeVisitor(
        handle: ResizeHandle.topCenter,
        delta: const Offset(0, -10),
      );

      final resized = shape.accept(visitor) as ShapeObject;
      expect(resized.rect, const Rect.fromLTWH(100, 90, 100, 110));
    });

    test('should flip if dragging past edge', () {
      final shape = ShapeObject(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 100, 100),
        paint: Paint(),
        id: 1,
      );
      // Drag Right to Left past Left edge (delta = -200)
      // Original Right: 200. New Right: 0.
      // Rect.fromLTRB(100, 100, 0, 200) -> Normalized: Left 0, Width 100 (flipped).

      final visitor = ResizeVisitor(
        handle: ResizeHandle.centerRight,
        delta: const Offset(-200, 0),
      );

      final resized = shape.accept(visitor) as ShapeObject;
      expect(resized.rect.left, 0);
      expect(resized.rect.width, 100);
      expect(resized.rect.right, 100);
    });

    test('should return original object for TextObject (no-op)', () {
      final text = TextObject(
        id: 2,
        text: 'Test',
        position: const Offset(0, 0),
        fontSize: 14,
        color: 0xFF000000,
      );
      final visitor = ResizeVisitor(
        handle: ResizeHandle.bottomRight,
        delta: const Offset(10, 10),
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
