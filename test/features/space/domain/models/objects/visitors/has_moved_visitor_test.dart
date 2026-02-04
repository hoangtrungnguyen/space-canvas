import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/objects/extensions/space_object_extensions.dart';

void main() {
  group('HasMovedVisitor', () {
    const delta = Offset(10, 20);

    test('should detect movement in ShapeObject', () {
      final original = ShapeObject(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      final moved = original.move(delta) as ShapeObject;
      final same = original.copyWith();

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should detect movement in TextObject', () {
      final original = TextObject(
        text: 'Hello',
        position: const Offset(50, 50),
        fontSize: 16,
        color: 0xFF000000,
        id: 2,
      );
      final moved = original.move(delta) as TextObject;
      final same = original.copyWith();

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should detect movement in PathObject', () {
      final path = Path();
      path.moveTo(0, 0);
      path.lineTo(10, 10);

      final original = PathObject(path: path, paint: Paint(), id: 3);
      final moved = original.move(delta) as PathObject;
      // Re-create similar path for 'same' check, since Path equality might be identity based or platform specific.
      // However, copyWith with existing path should be equal reference.
      final same = original.copyWith();

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should detect movement in ListOfPointObject', () {
      final original = ListOfPointObject(
        points: const [Offset(0, 0), Offset(100, 100)],
        strokeWidth: 2,
        color: 0xFF000000,
        id: 4,
      );
      final moved = original.move(delta) as ListOfPointObject;
      final same = original.copyWith(
        points: List.of(original.points),
      ); // New list, same content

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should detect movement in ConnectorObject', () {
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
      final same = original.copyWith();

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should detect movement in ImageObject', () {
      final original = ImageObject(
        imageUrl: 'assets/test.png',
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        id: 6,
      );
      final moved = original.move(delta) as ImageObject;
      final same = original.copyWith();

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should detect movement in GroupObject', () {
      final original = GroupObject(
        childrenIds: [1, 2],
        rect: const Rect.fromLTWH(0, 0, 200, 200),
        id: 7,
      );
      final moved = original.move(delta) as GroupObject;
      final same = original.copyWith();

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should return false for different types', () {
      final shape = ShapeObject(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      final text = TextObject(
        text: 'Hello',
        position: const Offset(50, 50),
        fontSize: 16,
        color: 0xFF000000,
        id: 2,
      );

      // Even if logically "moved", type mismatch should return false or be handled safely
      // The current implementation returns false if types don't match.
      expect(text.hasMovedFrom(shape), isFalse);
    });
  });
}
