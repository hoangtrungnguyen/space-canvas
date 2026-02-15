import 'dart:collection';
import 'node.dart';

/// A composite node that can contain child [SyncNode]s.
class ContainerNode extends SyncNode {
  final List<SyncNode> _cachedChildren = [];

  ContainerNode({required super.id, required super.type, super.initialOrder});

  List<SyncNode> get children => UnmodifiableListView(_cachedChildren);

  void addChild(SyncNode child) {
    child.parentId = id;
    _cachedChildren.add(child);
    _cachedChildren.sort(
      (a, b) => a.sortOrder.value.compareTo(b.sortOrder.value),
    );
  }

  void removeChild(String childId) {
    _cachedChildren.removeWhere((child) => child.id == childId);
  }
}
