import 'node.dart';
import 'node_type.dart';
import 'syncable_property.dart';

/// A concrete [SyncNode] for text elements.
class TextNode extends SyncNode {
  SyncableProperty<String> content;
  SyncableProperty<double> fontSize;
  SyncableProperty<double> width;
  SyncableProperty<double> height;

  TextNode({required super.id, super.initialOrder})
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
