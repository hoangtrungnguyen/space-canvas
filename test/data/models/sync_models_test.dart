import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/data/models/models.dart';

void main() {
  group('SyncableProperty', () {
    test('updates value only when timestamp is newer', () {
      final prop = SyncableProperty(
        'initial',
        timestamp: 10,
        lastAuthorId: 'A',
      );

      // Older timestamp - should not update
      prop.update('old', 5, 'B');
      expect(prop.value, 'initial');
      expect(prop.timestamp, 10);
      expect(prop.lastAuthorId, 'A');

      // Same timestamp - should not update
      prop.update('same', 10, 'B');
      expect(prop.value, 'initial');

      // Newer timestamp - should update
      prop.update('new', 15, 'B');
      expect(prop.value, 'new');
      expect(prop.timestamp, 15);
      expect(prop.lastAuthorId, 'B');
    });

    test('toJson and fromJson work correctly', () {
      final prop = SyncableProperty(123, timestamp: 100, lastAuthorId: 'user1');
      final json = prop.toJson();

      expect(json['val'], 123);
      expect(json['ts'], 100);
      expect(json['auth'], 'user1');

      final restored = SyncableProperty.fromJson(json, (v) => v as int);
      expect(restored.value, 123);
      expect(restored.timestamp, 100);
      expect(restored.lastAuthorId, 'user1');
    });
  });

  group('Node Hierarchy', () {
    test('ContainerNode manages children correctly', () {
      final container = ContainerNode(id: 'c1', type: NodeType.frame);
      final child1 = VectorNode(id: 'v1', initialOrder: 'a'); // 'a' < 'b'
      final child2 = TextNode(id: 't1', initialOrder: 'b');

      container.addChild(child2);
      container.addChild(child1);

      // Should be sorted by order
      expect(container.children.length, 2);
      expect(container.children[0].id, 'v1');
      expect(container.children[1].id, 't1');
      expect(child1.parentId, 'c1');
    });

    test('VectorNode properties', () {
      final node = VectorNode(id: 'v1');
      final props = node.properties;

      expect(props.containsKey('fillColor'), true);
      expect(props.containsKey('x'), true);
      expect(props['fillColor']?.value, '#FFFFFF');
    });
  });
}
