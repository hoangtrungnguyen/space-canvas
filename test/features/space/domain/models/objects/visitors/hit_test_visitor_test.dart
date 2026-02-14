import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/hit_test_visitor.dart';

void main() {
  group('HitTestVisitor', () {
    // =========================================================================
    // ShapeNode
    // =========================================================================
    test('should hit ShapeNode inside rect', () {
      final shape = ShapeNode(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      final visitor = HitTestVisitor(const Offset(50, 50));
      expect(shape.accept(visitor), isTrue);
    });

    test('should NOT hit ShapeNode outside rect', () {
      final shape = ShapeNode(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
        id: 1,
      );
      final visitor = HitTestVisitor(const Offset(150, 150));
      expect(shape.accept(visitor), isFalse);
    });

    // =========================================================================
    // TextNode
    // =========================================================================
    test('should hit TextNode inside rect', () {
      // Note: TextNode rect is estimated by simplified calculation in current impl
      // Rect.fromLTWH(pos.x, pos.y, text.length * fontSize * 0.6, fontSize)

      final text = TextNode(
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

    // =========================================================================
    // ListOfPointNode (Drawing)
    // =========================================================================
    test('should hit ListOfPointNode near line segment', () {
      final points = ListOfPointNode(
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

    test('should handle ListOfPointNode optimizations and edge cases', () {
      // Empty points
      final emptyPoints = ListOfPointNode(
        points: const [],
        strokeWidth: 10,
        color: 0,
        id: 4,
      );
      expect(emptyPoints.accept(HitTestVisitor(Offset.zero)), isFalse);

      // Outside bounding box
      final boxTest = ListOfPointNode(
        points: const [Offset(0, 0), Offset(100, 100)],
        strokeWidth: 10,
        color: 0,
        id: 5,
      );
      // Bounding Box is roughly (0,0) to (100,100)
      // Test point far away triggers the bounding box check first
      expect(boxTest.accept(HitTestVisitor(const Offset(200, 200))), isFalse);
    });

    test('should handle ListOfPointNode with zero-length segments', () {
      // Segment where start == end
      final zeroLen = ListOfPointNode(
        points: const [Offset(50, 50), Offset(50, 50)],
        strokeWidth: 10,
        color: 0,
        id: 6,
      );

      // Should hit the point itself
      expect(zeroLen.accept(HitTestVisitor(const Offset(50, 50))), isTrue);

      // Should miss far away
      expect(zeroLen.accept(HitTestVisitor(const Offset(100, 100))), isFalse);
    });

    // =========================================================================
    // ConnectorNode
    // =========================================================================
    test('should hit ConnectorNode', () {
      final connector = ConnectorNode(
        startNodeId: 1,
        endNodeId: 2,
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

    // =========================================================================
    // ImageNode
    // =========================================================================
    test('should hit ImageNode inside rect', () {
      final img = ImageNode(
        imageUrl: 'test.png',
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        id: 7,
      );

      expect(img.accept(HitTestVisitor(const Offset(50, 50))), isTrue);
      expect(img.accept(HitTestVisitor(const Offset(150, 150))), isFalse);
    });

    // =========================================================================
    // PathNode
    // =========================================================================
    test('should hit PathNode', () {
      final pathObj = PathNode(
        path: Path()..addRect(const Rect.fromLTWH(0, 0, 100, 100)),
        paint: Paint(),
        id: 8,
      );

      expect(pathObj.accept(HitTestVisitor(const Offset(50, 50))), isTrue);
      expect(pathObj.accept(HitTestVisitor(const Offset(150, 150))), isFalse);
    });

    // =========================================================================
    // GroupNode
    // =========================================================================
    test('should hit GroupNode', () {
      final group = GroupNode(
        childrenIds: [1, 2],
        rect: const Rect.fromLTWH(0, 0, 100, 100), // Bounding box of children
        id: 9,
      );

      // Hit inside bounding box
      expect(group.accept(HitTestVisitor(const Offset(50, 50))), isTrue);
      // Miss outside bounding box
      expect(group.accept(HitTestVisitor(const Offset(200, 200))), isFalse);
    });
  });
}
