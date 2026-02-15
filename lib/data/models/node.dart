import 'node_type.dart';
import 'syncable_property.dart';

/// Abstract base class for all nodes in the Scene Graph.
/// Implements the Composite pattern.
abstract class SyncNode {
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

  SyncNode({required this.id, required this.type, String initialOrder = '0'})
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
