import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/move_visitor.dart';
import 'package:ideascape/features/space/domain/models/objects/extensions/space_object_extensions.dart';

void main() {
  group('MoveVisitor', () {
    const delta = Offset(10, 20);

    test('should move ShapeObject correctly', () {
      final original = ShapeObject(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );

      final moved = original.move(delta) as ShapeObject;

      expect(moved.rect, const Rect.fromLTWH(10, 20, 100, 100));
      expect(moved.id, original.id);
      expect(moved.type, original.type);
    });

    test('should move TextObject correctly', () {
      final original = TextObject(
        text: 'Hello',
        position: const Offset(50, 50),
        fontSize: 16,
        color: 0xFF000000,
        id: 2,
      );

      final moved = original.move(delta) as TextObject;

      expect(moved.position, const Offset(60, 70));
      expect(moved.id, original.id);
      expect(moved.text, original.text);
    });

    test('should move PathObject correctly', () {
      final path = Path();
      path.moveTo(0, 0);
      path.lineTo(10, 10);

      final original = PathObject(path: path, paint: Paint(), id: 3);

      final moved = original.move(delta) as PathObject;
      final bounds = moved.path.getBounds();

      // Original bounds: (0,0, 10,10)
      // Moved bounds: (10,20, 20,30)
      expect(bounds.left, 10);
      expect(bounds.top, 20);
      expect(bounds.right, 20);
      expect(bounds.bottom, 30);
    });

    test('should move ListOfPointObject correctly', () {
      final original = ListOfPointObject(
        points: const [Offset(0, 0), Offset(100, 100)],
        strokeWidth: 2,
        color: 0xFF000000,
        id: 4,
      );

      final moved = original.move(delta) as ListOfPointObject;

      expect(moved.points, const [Offset(10, 20), Offset(110, 120)]);
      expect(moved.id, original.id);
    });

    test('should move ConnectorObject correctly', () {
      final original = ConnectorObject(
        startObjectId: 1,
        endObjectId: 2,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        strokeWidth: 2,
        color: 0xFF000000,
        id: 5,
      );

      final moved = original.move(delta) as ConnectorObject;

      expect(moved.startPoint, const Offset(10, 20));
      expect(moved.endPoint, const Offset(110, 120));
      expect(moved.id, original.id);
    });

    test('should move ImageObject correctly', () {
      final original = ImageObject(
        imageUrl: 'assets/test.png',
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        id: 6,
      );

      final moved = original.move(delta) as ImageObject;

      expect(moved.rect, const Rect.fromLTWH(10, 20, 100, 100));
      expect(moved.id, original.id);
    });

    test('should move GroupObject correctly', () {
      final original = GroupObject(
        childrenIds: [1, 2],
        rect: const Rect.fromLTWH(0, 0, 200, 200),
        id: 7,
      );

      final moved = original.move(delta) as GroupObject;

      expect(moved.rect, const Rect.fromLTWH(10, 20, 200, 200));
      expect(moved.id, original.id);
    });
  });
}
