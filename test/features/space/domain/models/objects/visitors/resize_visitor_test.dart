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
  });
}
