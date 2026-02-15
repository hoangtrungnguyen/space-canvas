```dart
import 'dart:collection';

/// Enum to identify the type of node for serialization/deserialization factories.
enum NodeType {
  document,
  page,
  frame,
  rectangle,
  text,
  vector,
  group,
  connector,
  drawing,
  ellipse,
}

/// A wrapper for any property that needs to be synced across the network.
///
/// This class implements the "Last Write Wins" (LWW) conflict resolution strategy.
class SyncableProperty<T> {
  T value;
  int timestamp; // logical clock or server timestamp
  String lastAuthorId; // user who made the change

  SyncableProperty(
    this.value, {
    this.timestamp = 0,
    this.lastAuthorId = '',
  });

  /// Updates the value only if the incoming change is newer (strictly greater timestamp).
  void update(T newValue, int newTimestamp, String authorId) {
    if (newTimestamp > timestamp) {
      value = newValue;
      timestamp = newTimestamp;
      lastAuthorId = authorId;
    }
  }

  Map<String, dynamic> toJson() => {
    'val': value,
    'ts': timestamp,
    'auth': lastAuthorId,
  };
}

/// Abstract base class for all nodes in the Scene Graph.
/// Implements the Composite pattern.
abstract class Node {
  final String id;
  final NodeType type;
  
  /// Parent node ID. Storing the parent ID is safer for sync/serialization.
  String? parentId; 
  
  /// Fractional index determining sort order among siblings (e.g. "a0.5").
  SyncableProperty<String> sortOrder; 

  // — Basic transform properties available on almost all nodes —
  SyncableProperty<bool> visible;
  SyncableProperty<bool> locked;
  
  // Individual position/rotation components
  SyncableProperty<double> x;
  SyncableProperty<double> y;
  SyncableProperty<double> rotation;

  Node({required this.id, required this.type, String initialOrder = '0'})
    : sortOrder = SyncableProperty(initialOrder),
      visible = SyncableProperty(true),
      locked = SyncableProperty(false),
      x = SyncableProperty(0.0),
      y = SyncableProperty(0.0),
      rotation = SyncableProperty(0.0);

  /// Returns a map of **all** syncable properties on this node.
  Map<String, SyncableProperty> get properties => {
    'sortOrder': sortOrder,
    'visible': visible,
    'locked': locked,
    'x': x,
    'y': y,
    'rotation': rotation,
  };
}

/// A composite node that can contain child [Node]s.
class ContainerNode extends Node {
  final List<Node> _cachedChildren = [];

  ContainerNode({required super.id, required super.type});

  List<Node> get children => UnmodifiableListView(_cachedChildren);

  void addChild(Node child) {
    child.parentId = id;
    _cachedChildren.add(child);
    _cachedChildren.sort((a, b) => a.sortOrder.value.compareTo(b.sortOrder.value));
  }
}

/// A concrete [Node] for vector shapes.
class VectorNode extends Node {
  SyncableProperty<String> fillColor;
  SyncableProperty<double> strokeWidth;
  SyncableProperty<double> width;
  SyncableProperty<double> height;

  VectorNode({required super.id, NodeType type = NodeType.rectangle})
    : fillColor = SyncableProperty('#FFFFFF'),
      strokeWidth = SyncableProperty(1.0),
      width = SyncableProperty(100.0),
      height = SyncableProperty(100.0),
      super(type: type);

  @override
  Map<String, SyncableProperty> get properties {
    final props = super.properties;
    props.addAll({
      'fillColor': fillColor,
      'strokeWidth': strokeWidth,
      'width': width,
      'height': height,
    });
    return props;
  }
}

/// A concrete [Node] for text elements.
class TextNode extends Node {
  SyncableProperty<String> content;
  SyncableProperty<double> fontSize;
  SyncableProperty<double> width;
  SyncableProperty<double> height;

  TextNode({required super.id})
    : content = SyncableProperty('New Text'),
      fontSize = SyncableProperty(14.0),
      width = SyncableProperty(100.0),
      height = SyncableProperty(20.0),
      super(type: NodeType.text);

  @override
  Map<String, SyncableProperty> get properties {
    final props = super.properties;
    props.addAll({
      'content': content,
      'fontSize': fontSize,
      'width': width,
      'height': height,
    });
    return props;
  }
}
```