import 'node.dart';
import 'node_type.dart';
import 'syncable_property.dart';

/// A concrete [SyncNode] for freehand drawings.
class DrawingNode extends SyncNode {
  // Points encoded as a flat list of doubles [x1, y1, x2, y2, ...] or a specifically formatted string.
  // Using List<double> wrapped in SyncableProperty for simplicity here,
  // typically you might want a more efficient update structure for partial strokes.
  SyncableProperty<List<double>> points;
  SyncableProperty<String> color;
  SyncableProperty<double> strokeWidth;

  DrawingNode({required super.id, super.initialOrder})
    : points = SyncableProperty([]),
      color = SyncableProperty('#000000'),
      strokeWidth = SyncableProperty(2.0),
      super(type: NodeType.drawing);

  @override
  Map<String, SyncableProperty> get properties {
    final props = super.properties;
    props.addAll({
      'points': points,
      'color': color,
      'strokeWidth': strokeWidth,
    });
    return props;
  }
}
