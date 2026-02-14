import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

// Mock visitor for testing accept methods
class MockVisitor implements NodeVisitor<String> {
  @override
  String visitPath(PathNode object) => 'path:${object.id}';

  @override
  String visitShape(ShapeNode object) => 'shape:${object.id}';

  @override
  String visitText(TextNode object) => 'text:${object.id}';

  @override
  String visitImage(ImageNode object) => 'image:${object.id}';

  @override
  String visitConnector(ConnectorNode object) => 'connector:${object.id}';

  @override
  String visitGroup(GroupNode object) => 'group:${object.id}';

  @override
  String visitListOfPoint(ListOfPointNode object) =>
      'listOfPoint:${object.id}';
}

void main() {
  group('ShapeType enum', () {
    test('has all expected values', () {
      expect(ShapeType.values, contains(ShapeType.rectangle));
      expect(ShapeType.values, contains(ShapeType.oval));
      expect(ShapeType.values, contains(ShapeType.triangle));
      expect(ShapeType.values, contains(ShapeType.diamond));
      expect(ShapeType.values, contains(ShapeType.parallelogram));
      expect(ShapeType.values, contains(ShapeType.database));
      expect(ShapeType.values, contains(ShapeType.server));
      expect(ShapeType.values, contains(ShapeType.cloud));
      expect(ShapeType.values.length, 8);
    });
  });

  group('Node.intersects', () {
    test('returns true when shapes overlap', () {
      final shape1 = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
      );
      final shape2 = ShapeNode(
        id: 2,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(50, 50, 100, 100),
        paint: Paint(),
      );
      expect(shape1.intersects(shape2), isTrue);
    });

    test('returns false when shapes do not overlap', () {
      final shape1 = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 50, 50),
        paint: Paint(),
      );
      final shape2 = ShapeNode(
        id: 2,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 50, 50),
        paint: Paint(),
      );
      expect(shape1.intersects(shape2), isFalse);
    });

    test('works between different Node types', () {
      final shape = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
      );
      final text = TextNode(
        id: 2,
        text: 'Hello',
        position: const Offset(50, 50),
        fontSize: 16,
        color: 0xFF000000,
      );
      expect(shape.intersects(text), isTrue);
    });
  });

  group('PathNode', () {
    late Path testPath;
    late Paint testPaint;

    setUp(() {
      testPath =
          Path()
            ..moveTo(0, 0)
            ..lineTo(100, 0)
            ..lineTo(100, 100)
            ..lineTo(0, 100)
            ..close();
      testPaint = Paint()..color = const Color(0xFF0000FF);
    });

    test('can be created with required parameters', () {
      final pathObject = PathNode(path: testPath, paint: testPaint, id: 1);
      expect(pathObject.id, 1);
      expect(pathObject.zIndex, 0);
      expect(pathObject.path, testPath);
      expect(pathObject.paint, testPaint);
    });

    test('can be created with custom zIndex', () {
      final pathObject = PathNode(
        path: testPath,
        paint: testPaint,
        id: 1,
        zIndex: 5,
      );
      expect(pathObject.zIndex, 5);
    });

    test('rect returns path bounds', () {
      final pathObject = PathNode(path: testPath, paint: testPaint, id: 1);
      expect(pathObject.rect, const Rect.fromLTRB(0, 0, 100, 100));
    });

    test('accept calls visitPath', () {
      final pathObject = PathNode(path: testPath, paint: testPaint, id: 42);
      final visitor = MockVisitor();
      expect(pathObject.accept(visitor), 'path:42');
    });
  });

  group('ShapeNode', () {
    late Paint testPaint;

    setUp(() {
      testPaint = Paint()..color = const Color(0xFFFF0000);
    });

    test('can be created with required parameters', () {
      final shape = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(10, 20, 100, 200),
        paint: testPaint,
      );
      expect(shape.id, 1);
      expect(shape.type, ShapeType.rectangle);
      expect(shape.rect, const Rect.fromLTWH(10, 20, 100, 200));
      expect(shape.text, '');
      expect(shape.zIndex, 0);
    });

    test('can be created with optional text and zIndex', () {
      final shape = ShapeNode(
        id: 2,
        type: ShapeType.oval,
        rect: const Rect.fromLTWH(0, 0, 50, 50),
        paint: testPaint,
        text: 'Label',
        zIndex: 10,
      );
      expect(shape.text, 'Label');
      expect(shape.zIndex, 10);
    });

    test('copyWith works correctly', () {
      final original = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: testPaint,
      );
      final copied = original.copyWith(
        rect: const Rect.fromLTWH(50, 50, 200, 200),
        text: 'New Label',
      );
      expect(copied.id, 1);
      expect(copied.rect, const Rect.fromLTWH(50, 50, 200, 200));
      expect(copied.text, 'New Label');
      expect(copied.type, ShapeType.rectangle);
    });

    test('accept calls visitShape', () {
      final shape = ShapeNode(
        id: 99,
        type: ShapeType.triangle,
        rect: const Rect.fromLTWH(0, 0, 50, 50),
        paint: testPaint,
      );
      expect(shape.accept(MockVisitor()), 'shape:99');
    });
  });

  group('TextNode', () {
    test('can be created with required parameters', () {
      final text = TextNode(
        id: 1,
        text: 'Hello World',
        position: const Offset(100, 200),
        fontSize: 24,
        color: 0xFF000000,
      );
      expect(text.id, 1);
      expect(text.text, 'Hello World');
      expect(text.position, const Offset(100, 200));
      expect(text.fontSize, 24);
      expect(text.color, 0xFF000000);
      expect(text.zIndex, 0);
      expect(text.fontFamily, isNull);
    });

    test('can be created with optional fontFamily and zIndex', () {
      final text = TextNode(
        id: 2,
        text: 'Styled',
        position: const Offset(0, 0),
        fontSize: 16,
        color: 0xFFFFFFFF,
        fontFamily: 'Roboto',
        zIndex: 5,
      );
      expect(text.fontFamily, 'Roboto');
      expect(text.zIndex, 5);
    });

    test('rect is calculated based on text length and fontSize', () {
      final text = TextNode(
        id: 1,
        text: 'Hello', // 5 chars
        position: const Offset(10, 20),
        fontSize: 20,
        color: 0xFF000000,
      );
      // rect = Rect.fromLTWH(10, 20, 5 * 20 * 0.6, 20)
      // = Rect.fromLTWH(10, 20, 60, 20)
      expect(text.rect, const Rect.fromLTWH(10, 20, 60, 20));
    });

    test('rect handles empty text', () {
      final text = TextNode(
        id: 1,
        text: '',
        position: const Offset(0, 0),
        fontSize: 16,
        color: 0xFF000000,
      );
      expect(text.rect.width, 0);
      expect(text.rect.height, 16);
    });

    test('accept calls visitText', () {
      final text = TextNode(
        id: 77,
        text: 'Test',
        position: const Offset(0, 0),
        fontSize: 12,
        color: 0xFF000000,
      );
      expect(text.accept(MockVisitor()), 'text:77');
    });
  });

  group('ImageNode', () {
    test('can be created with required parameters', () {
      final image = ImageNode(
        id: 1,
        imageUrl: 'https://example.com/image.png',
        rect: const Rect.fromLTWH(0, 0, 200, 150),
      );
      expect(image.id, 1);
      expect(image.imageUrl, 'https://example.com/image.png');
      expect(image.rect, const Rect.fromLTWH(0, 0, 200, 150));
      expect(image.zIndex, 0);
    });

    test('can be created with custom zIndex', () {
      final image = ImageNode(
        id: 2,
        imageUrl: 'local/path.jpg',
        rect: const Rect.fromLTWH(10, 10, 100, 100),
        zIndex: 15,
      );
      expect(image.zIndex, 15);
    });

    test('accept calls visitImage', () {
      final image = ImageNode(
        id: 55,
        imageUrl: 'test.png',
        rect: const Rect.fromLTWH(0, 0, 50, 50),
      );
      expect(image.accept(MockVisitor()), 'image:55');
    });
  });

  group('ConnectorNode', () {
    test('can be created with required parameters', () {
      final connector = ConnectorNode(
        id: 1,
        startNodeId: 10,
        endNodeId: 20,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        strokeWidth: 2,
        color: 0xFF000000,
      );
      expect(connector.id, 1);
      expect(connector.startNodeId, 10);
      expect(connector.endNodeId, 20);
      expect(connector.startPoint, const Offset(0, 0));
      expect(connector.endPoint, const Offset(100, 100));
      expect(connector.strokeWidth, 2);
      expect(connector.color, 0xFF000000);
      expect(connector.zIndex, 0);
    });

    test('can be created with custom zIndex', () {
      final connector = ConnectorNode(
        id: 2,
        startNodeId: 1,
        endNodeId: 2,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(50, 50),
        strokeWidth: 1,
        color: 0xFFFF0000,
        zIndex: 3,
      );
      expect(connector.zIndex, 3);
    });

    test('rect is calculated from start/end points with stroke inflation', () {
      final connector = ConnectorNode(
        id: 1,
        startNodeId: 1,
        endNodeId: 2,
        startPoint: const Offset(10, 20),
        endPoint: const Offset(110, 120),
        strokeWidth: 4,
        color: 0xFF000000,
      );
      // Rect.fromPoints(10,20 -> 110,120) = Rect.fromLTRB(10, 20, 110, 120)
      // Inflated by strokeWidth (4) = Rect.fromLTRB(6, 16, 114, 124)
      expect(connector.rect, const Rect.fromLTRB(6, 16, 114, 124));
    });

    test('accept calls visitConnector', () {
      final connector = ConnectorNode(
        id: 88,
        startNodeId: 1,
        endNodeId: 2,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(10, 10),
        strokeWidth: 1,
        color: 0xFF000000,
      );
      expect(connector.accept(MockVisitor()), 'connector:88');
    });
  });

  group('GroupNode', () {
    test('can be created with required parameters', () {
      final group = GroupNode(
        id: 1,
        childrenIds: [2, 3, 4],
        rect: const Rect.fromLTWH(0, 0, 200, 200),
      );
      expect(group.id, 1);
      expect(group.childrenIds, [2, 3, 4]);
      expect(group.rect, const Rect.fromLTWH(0, 0, 200, 200));
      expect(group.zIndex, 0);
    });

    test('can be created with empty children', () {
      final group = GroupNode(
        id: 2,
        childrenIds: [],
        rect: const Rect.fromLTWH(10, 10, 50, 50),
        zIndex: 7,
      );
      expect(group.childrenIds, isEmpty);
      expect(group.zIndex, 7);
    });

    test('accept calls visitGroup', () {
      final group = GroupNode(
        id: 66,
        childrenIds: [1, 2],
        rect: const Rect.fromLTWH(0, 0, 100, 100),
      );
      expect(group.accept(MockVisitor()), 'group:66');
    });
  });

  group('ListOfPointNode', () {
    test('can be created with required parameters', () {
      final listOfPoint = ListOfPointNode(
        id: 1,
        points: [const Offset(0, 0), const Offset(10, 10), const Offset(20, 5)],
        strokeWidth: 3,
        color: 0xFF00FF00,
      );
      expect(listOfPoint.id, 1);
      expect(listOfPoint.points.length, 3);
      expect(listOfPoint.strokeWidth, 3);
      expect(listOfPoint.color, 0xFF00FF00);
      expect(listOfPoint.zIndex, 0);
    });

    test('can be created with custom zIndex', () {
      final listOfPoint = ListOfPointNode(
        id: 2,
        points: [const Offset(0, 0)],
        strokeWidth: 1,
        color: 0xFF000000,
        zIndex: 12,
      );
      expect(listOfPoint.zIndex, 12);
    });

    test('rect returns Rect.zero for empty points', () {
      final listOfPoint = ListOfPointNode(
        id: 1,
        points: [],
        strokeWidth: 2,
        color: 0xFF000000,
      );
      expect(listOfPoint.rect, Rect.zero);
    });

    test('rect calculates bounding box from points with stroke inflation', () {
      final listOfPoint = ListOfPointNode(
        id: 1,
        points: [
          const Offset(10, 20),
          const Offset(50, 10),
          const Offset(30, 60),
        ],
        strokeWidth: 4,
        color: 0xFF000000,
      );
      // minX=10, maxX=50, minY=10, maxY=60
      // Rect.fromLTRB(10, 10, 50, 60).inflate(4/2=2)
      // = Rect.fromLTRB(8, 8, 52, 62)
      expect(listOfPoint.rect, const Rect.fromLTRB(8, 8, 52, 62));
    });

    test('rect handles single point', () {
      final listOfPoint = ListOfPointNode(
        id: 1,
        points: [const Offset(25, 35)],
        strokeWidth: 6,
        color: 0xFF000000,
      );
      // Rect.fromLTRB(25, 35, 25, 35).inflate(3)
      // = Rect.fromLTRB(22, 32, 28, 38)
      expect(listOfPoint.rect, const Rect.fromLTRB(22, 32, 28, 38));
    });

    test('rect covers all branches in bounding calculation', () {
      // Test case where points have varying min/max in different directions
      final listOfPoint = ListOfPointNode(
        id: 1,
        points: [
          const Offset(50, 50), // Initial point
          const Offset(10, 90), // New minX, new maxY
          const Offset(90, 10), // New maxX, new minY
        ],
        strokeWidth: 0,
        color: 0xFF000000,
      );
      // After loop: minX=10, maxX=90, minY=10, maxY=90
      expect(listOfPoint.rect, const Rect.fromLTRB(10, 10, 90, 90));
    });

    test('accept calls visitListOfPoint', () {
      final listOfPoint = ListOfPointNode(
        id: 33,
        points: [const Offset(0, 0)],
        strokeWidth: 1,
        color: 0xFF000000,
      );
      expect(listOfPoint.accept(MockVisitor()), 'listOfPoint:33');
    });
  });
}
