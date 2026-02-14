import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/objects/extensions/node_extensions.dart';

void main() {
  group('MoveVisitor', () {
    const delta = Offset(10, 20);

    test('should move ShapeNode correctly', () {
      final original = ShapeNode(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );

      final moved = original.move(delta) as ShapeNode;

      expect(moved.rect, const Rect.fromLTWH(10, 20, 100, 100));
      expect(moved.id, original.id);
      expect(moved.type, original.type);
    });

    test('should move TextNode correctly', () {
      final original = TextNode(
        text: 'Hello',
        position: const Offset(50, 50),
        fontSize: 16,
        color: 0xFF000000,
        id: 2,
      );

      final moved = original.move(delta) as TextNode;

      expect(moved.position, const Offset(60, 70));
      expect(moved.id, original.id);
      expect(moved.text, original.text);
    });

    test('should move PathNode correctly', () {
      final path = Path();
      path.moveTo(0, 0);
      path.lineTo(10, 10);

      final original = PathNode(path: path, paint: Paint(), id: 3);

      final moved = original.move(delta) as PathNode;
      final bounds = moved.path.getBounds();

      // Original bounds: (0,0, 10,10)
      // Moved bounds: (10,20, 20,30)
      expect(bounds.left, 10);
      expect(bounds.top, 20);
      expect(bounds.right, 20);
      expect(bounds.bottom, 30);
    });

    test('should move ListOfPointNode correctly', () {
      final original = ListOfPointNode(
        points: const [Offset(0, 0), Offset(100, 100)],
        strokeWidth: 2,
        color: 0xFF000000,
        id: 4,
      );

      final moved = original.move(delta) as ListOfPointNode;

      expect(moved.points, const [Offset(10, 20), Offset(110, 120)]);
      expect(moved.id, original.id);
    });

    test('should move ConnectorNode correctly', () {
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

      expect(moved.startPoint, const Offset(10, 20));
      expect(moved.endPoint, const Offset(110, 120));
      expect(moved.id, original.id);
    });

    test('should move ImageNode correctly', () {
      final original = ImageNode(
        imageUrl: 'assets/test.png',
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        id: 6,
      );

      final moved = original.move(delta) as ImageNode;

      expect(moved.rect, const Rect.fromLTWH(10, 20, 100, 100));
      expect(moved.id, original.id);
    });

    test('should move GroupNode correctly', () {
      final original = GroupNode(
        childrenIds: [1, 2],
        rect: const Rect.fromLTWH(0, 0, 200, 200),
        id: 7,
      );

      final moved = original.move(delta) as GroupNode;

      expect(moved.rect, const Rect.fromLTWH(10, 20, 200, 200));
      expect(moved.id, original.id);
    });
  });
}
