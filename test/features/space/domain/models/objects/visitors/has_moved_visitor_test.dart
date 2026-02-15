import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/objects/extensions/node_extensions.dart';

void main() {
  group('HasMovedVisitor', () {
    const delta = Offset(10, 20);

    test('should detect movement in ShapeNode', () {
      final original = ShapeNode(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
        id: 1,
      );
      final moved = original.move(delta) as ShapeNode;
      final same = original.copyWith();

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should detect movement in TextNode', () {
      final original = TextNode(
        text: 'Hello',
        position: const Offset(50, 50),
        fontSize: 16,
        color: 0xFF000000,
        id: 2,
      );
      final moved = original.move(delta) as TextNode;
      final same = original.copyWith();

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should detect movement in ListOfPointNode', () {
      final original = ListOfPointNode(
        points: const [Offset(0, 0), Offset(100, 100)],
        strokeWidth: 2,
        color: 0xFF000000,
        id: 4,
      );
      final moved = original.move(delta) as ListOfPointNode;
      final same = original.copyWith(
        points: List.of(original.points),
      ); // New list, same content

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should detect movement in ConnectorNode', () {
      final original = ConnectorNode(
        startNodeId: 1,
        endNodeId: 2,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        strokeWidth: 2,
        color: 0xFF000000,
        id: 5,
      );
      final moved = original.move(delta) as ConnectorNode;
      final same = original.copyWith();

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should detect movement in ImageNode', () {
      final original = ImageNode(
        imageUrl: 'assets/test.png',
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        id: 6,
      );
      final moved = original.move(delta) as ImageNode;
      final same = original.copyWith();

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should detect movement in GroupNode', () {
      final original = GroupNode(
        childrenIds: [1, 2],
        rect: const Rect.fromLTWH(0, 0, 200, 200),
        id: 7,
      );
      final moved = original.move(delta) as GroupNode;
      final same = original.copyWith();

      expect(moved.hasMovedFrom(original), isTrue);
      expect(same.hasMovedFrom(original), isFalse);
    });

    test('should return false for different types', () {
      final shape = ShapeNode(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
        id: 1,
      );
      final text = TextNode(
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
