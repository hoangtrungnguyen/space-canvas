import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/hit_test_visitor.dart';

void main() {
  group('HitTestVisitor', () {
    test('should hit ShapeObject inside rect', () {
      final shape = ShapeObject(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      final visitor = HitTestVisitor(const Offset(50, 50));
      expect(shape.accept(visitor), isTrue);
    });

    test('should NOT hit ShapeObject outside rect', () {
      final shape = ShapeObject(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      final visitor = HitTestVisitor(const Offset(150, 150));
      expect(shape.accept(visitor), isFalse);
    });

    test('should hit TextObject inside rect', () {
      // Note: TextObject rect is estimated by simplified calculation in current impl
      // Rect.fromLTWH(pos.x, pos.y, text.length * fontSize * 0.6, fontSize)

      final text = TextObject(
        text: 'Hello',
        position: const Offset(10, 10),
        fontSize: 20,
        color: 0,
        id: 2,
      );

      // Estimated Width = 5 * 20 * 0.6 = 60. Height = 20.
      // Rect = (10, 10, 60, 20) => Right=70, Bottom=30.

      final visitor = HitTestVisitor(const Offset(20, 20));
      expect(text.accept(visitor), isTrue);
    });

    test('should hit ListOfPointObject near line segment', () {
      final points = ListOfPointObject(
        points: const [Offset(0, 0), Offset(100, 100)],
        strokeWidth: 10,
        color: 0,
        id: 3,
      );

      // Point exactly on the line
      var visitor = HitTestVisitor(const Offset(50, 50));
      expect(points.accept(visitor), isTrue);

      // Point slightly off but within strokeWidth/2 + threshold
      // Stroke/2 = 5. Threshold default = 5. Total = 10.
      visitor = HitTestVisitor(const Offset(55, 50)); // Dist ~3.5
      expect(points.accept(visitor), isTrue);

      // Point too far
      visitor = HitTestVisitor(const Offset(80, 50));
      expect(points.accept(visitor), isFalse);
    });

    test('should hit ConnectorObject', () {
      final connector = ConnectorObject(
        startObjectId: 1,
        endObjectId: 2,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(0, 100),
        strokeWidth: 10,
        color: 0,
        id: 4,
      );

      // On the vertical line
      var visitor = HitTestVisitor(const Offset(0, 50));
      expect(connector.accept(visitor), isTrue);

      // Slightly off
      visitor = HitTestVisitor(const Offset(5, 50));
      expect(connector.accept(visitor), isTrue);

      // Too far
      visitor = HitTestVisitor(const Offset(20, 50));
      expect(connector.accept(visitor), isFalse);
    });
  });
}
