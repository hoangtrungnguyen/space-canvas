import 'node.dart';
import 'node_type.dart';
import 'syncable_property.dart';

/// A concrete [SyncNode] for vector shapes.
class VectorNode extends SyncNode {
  SyncableProperty<String> fillColor;
  SyncableProperty<double> strokeWidth;
  SyncableProperty<double> width;
  SyncableProperty<double> height;

  VectorNode({
    required super.id,
    NodeType type = NodeType.rectangle,
    super.initialOrder,
  }) : fillColor = SyncableProperty('#FFFFFF'),
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
