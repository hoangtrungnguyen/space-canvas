import 'node.dart';
import 'node_type.dart';
import 'syncable_property.dart';

/// A concrete [SyncNode] for connectors.
class ConnectorNode extends SyncNode {
  SyncableProperty<String?> startNodeId;
  SyncableProperty<String?> endNodeId;

  // Using simplified representation for demonstration.
  // In a real app, these might be complex objects or separate properties for x/y if not connected to a node.
  SyncableProperty<double> startX;
  SyncableProperty<double> startY;
  SyncableProperty<double> endX;
  SyncableProperty<double> endY;

  ConnectorNode({required super.id, super.initialOrder})
    : startNodeId = SyncableProperty(null),
      endNodeId = SyncableProperty(null),
      startX = SyncableProperty(0.0),
      startY = SyncableProperty(0.0),
      endX = SyncableProperty(0.0),
      endY = SyncableProperty(0.0),
      super(type: NodeType.connector);

  @override
  Map<String, SyncableProperty> get properties {
    final props = super.properties;
    props.addAll({
      'startNodeId': startNodeId,
      'endNodeId': endNodeId,
      'startX': startX,
      'startY': startY,
      'endX': endX,
      'endY': endY,
    });
    return props;
  }
}
