// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shape_layer_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShapeLayerEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ShapeLayerEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ShapeLayerEvent()';
  }
}

/// @nodoc
class $ShapeLayerEventCopyWith<$Res> {
  $ShapeLayerEventCopyWith(
    ShapeLayerEvent _,
    $Res Function(ShapeLayerEvent) __,
  );
}

/// Adds pattern-matching-related methods to [ShapeLayerEvent].
extension ShapeLayerEventPatterns on ShapeLayerEvent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialized value)? initialize,
    TResult Function(_NodeDragged value)? nodeDragged,
    TResult Function(_AddNode value)? addNode,
    TResult Function(_RemoveNode value)? removeNode,
    TResult Function(_ShapeSelected value)? shapeSelected,
    TResult Function(_NodeSelected value)? nodeSelected,
    TResult Function(_SelectAtPoint value)? selectAtPoint,
    TResult Function(_UpdateNodes value)? updateNodes,
    TResult Function(_HiddenNodes value)? hiddenNodes,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialize != null:
        return initialize(_that);
      case _NodeDragged() when nodeDragged != null:
        return nodeDragged(_that);
      case _AddNode() when addNode != null:
        return addNode(_that);
      case _RemoveNode() when removeNode != null:
        return removeNode(_that);
      case _ShapeSelected() when shapeSelected != null:
        return shapeSelected(_that);
      case _NodeSelected() when nodeSelected != null:
        return nodeSelected(_that);
      case _SelectAtPoint() when selectAtPoint != null:
        return selectAtPoint(_that);
      case _UpdateNodes() when updateNodes != null:
        return updateNodes(_that);
      case _HiddenNodes() when hiddenNodes != null:
        return hiddenNodes(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialized value) initialize,
    required TResult Function(_NodeDragged value) nodeDragged,
    required TResult Function(_AddNode value) addNode,
    required TResult Function(_RemoveNode value) removeNode,
    required TResult Function(_ShapeSelected value) shapeSelected,
    required TResult Function(_NodeSelected value) nodeSelected,
    required TResult Function(_SelectAtPoint value) selectAtPoint,
    required TResult Function(_UpdateNodes value) updateNodes,
    required TResult Function(_HiddenNodes value) hiddenNodes,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized():
        return initialize(_that);
      case _NodeDragged():
        return nodeDragged(_that);
      case _AddNode():
        return addNode(_that);
      case _RemoveNode():
        return removeNode(_that);
      case _ShapeSelected():
        return shapeSelected(_that);
      case _NodeSelected():
        return nodeSelected(_that);
      case _SelectAtPoint():
        return selectAtPoint(_that);
      case _UpdateNodes():
        return updateNodes(_that);
      case _HiddenNodes():
        return hiddenNodes(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialized value)? initialize,
    TResult? Function(_NodeDragged value)? nodeDragged,
    TResult? Function(_AddNode value)? addNode,
    TResult? Function(_RemoveNode value)? removeNode,
    TResult? Function(_ShapeSelected value)? shapeSelected,
    TResult? Function(_NodeSelected value)? nodeSelected,
    TResult? Function(_SelectAtPoint value)? selectAtPoint,
    TResult? Function(_UpdateNodes value)? updateNodes,
    TResult? Function(_HiddenNodes value)? hiddenNodes,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialize != null:
        return initialize(_that);
      case _NodeDragged() when nodeDragged != null:
        return nodeDragged(_that);
      case _AddNode() when addNode != null:
        return addNode(_that);
      case _RemoveNode() when removeNode != null:
        return removeNode(_that);
      case _ShapeSelected() when shapeSelected != null:
        return shapeSelected(_that);
      case _NodeSelected() when nodeSelected != null:
        return nodeSelected(_that);
      case _SelectAtPoint() when selectAtPoint != null:
        return selectAtPoint(_that);
      case _UpdateNodes() when updateNodes != null:
        return updateNodes(_that);
      case _HiddenNodes() when hiddenNodes != null:
        return hiddenNodes(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(int nodeId, Offset delta)? nodeDragged,
    TResult Function(Node node)? addNode,
    TResult Function(int nodeId)? removeNode,
    TResult Function(int nodeId)? shapeSelected,
    TResult Function(int? nodeId)? nodeSelected,
    TResult Function(Offset point)? selectAtPoint,
    TResult Function(List<Node> nodes)? updateNodes,
    TResult Function(Set<int> nodeIds)? hiddenNodes,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialize != null:
        return initialize();
      case _NodeDragged() when nodeDragged != null:
        return nodeDragged(_that.nodeId, _that.delta);
      case _AddNode() when addNode != null:
        return addNode(_that.node);
      case _RemoveNode() when removeNode != null:
        return removeNode(_that.nodeId);
      case _ShapeSelected() when shapeSelected != null:
        return shapeSelected(_that.nodeId);
      case _NodeSelected() when nodeSelected != null:
        return nodeSelected(_that.nodeId);
      case _SelectAtPoint() when selectAtPoint != null:
        return selectAtPoint(_that.point);
      case _UpdateNodes() when updateNodes != null:
        return updateNodes(_that.nodes);
      case _HiddenNodes() when hiddenNodes != null:
        return hiddenNodes(_that.nodeIds);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(int nodeId, Offset delta) nodeDragged,
    required TResult Function(Node node) addNode,
    required TResult Function(int nodeId) removeNode,
    required TResult Function(int nodeId) shapeSelected,
    required TResult Function(int? nodeId) nodeSelected,
    required TResult Function(Offset point) selectAtPoint,
    required TResult Function(List<Node> nodes) updateNodes,
    required TResult Function(Set<int> nodeIds) hiddenNodes,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized():
        return initialize();
      case _NodeDragged():
        return nodeDragged(_that.nodeId, _that.delta);
      case _AddNode():
        return addNode(_that.node);
      case _RemoveNode():
        return removeNode(_that.nodeId);
      case _ShapeSelected():
        return shapeSelected(_that.nodeId);
      case _NodeSelected():
        return nodeSelected(_that.nodeId);
      case _SelectAtPoint():
        return selectAtPoint(_that.point);
      case _UpdateNodes():
        return updateNodes(_that.nodes);
      case _HiddenNodes():
        return hiddenNodes(_that.nodeIds);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function(int nodeId, Offset delta)? nodeDragged,
    TResult? Function(Node node)? addNode,
    TResult? Function(int nodeId)? removeNode,
    TResult? Function(int nodeId)? shapeSelected,
    TResult? Function(int? nodeId)? nodeSelected,
    TResult? Function(Offset point)? selectAtPoint,
    TResult? Function(List<Node> nodes)? updateNodes,
    TResult? Function(Set<int> nodeIds)? hiddenNodes,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialize != null:
        return initialize();
      case _NodeDragged() when nodeDragged != null:
        return nodeDragged(_that.nodeId, _that.delta);
      case _AddNode() when addNode != null:
        return addNode(_that.node);
      case _RemoveNode() when removeNode != null:
        return removeNode(_that.nodeId);
      case _ShapeSelected() when shapeSelected != null:
        return shapeSelected(_that.nodeId);
      case _NodeSelected() when nodeSelected != null:
        return nodeSelected(_that.nodeId);
      case _SelectAtPoint() when selectAtPoint != null:
        return selectAtPoint(_that.point);
      case _UpdateNodes() when updateNodes != null:
        return updateNodes(_that.nodes);
      case _HiddenNodes() when hiddenNodes != null:
        return hiddenNodes(_that.nodeIds);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initialized implements ShapeLayerEvent {
  const _Initialized();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initialized);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ShapeLayerEvent.initialize()';
  }
}

/// @nodoc
class _$InitializedCopyWith<$Res> implements $ShapeLayerEventCopyWith<$Res> {
  _$InitializedCopyWith(_Initialized _, $Res Function(_Initialized) __);
}

/// @nodoc
class __$InitializedCopyWithImpl<$Res> implements _$InitializedCopyWith<$Res> {
  __$InitializedCopyWithImpl(this._self, this._then);

  final _Initialized _self;
  final $Res Function(_Initialized) _then;
}

/// @nodoc

class _NodeDragged implements ShapeLayerEvent {
  const _NodeDragged({required this.nodeId, required this.delta});

  final int nodeId;
  final Offset delta;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NodeDraggedCopyWith<_NodeDragged> get copyWith =>
      __$NodeDraggedCopyWithImpl<_NodeDragged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NodeDragged &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.delta, delta) || other.delta == delta));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nodeId, delta);

  @override
  String toString() {
    return 'ShapeLayerEvent.nodeDragged(nodeId: $nodeId, delta: $delta)';
  }
}

/// @nodoc
abstract mixin class _$NodeDraggedCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$NodeDraggedCopyWith(
    _NodeDragged value,
    $Res Function(_NodeDragged) _then,
  ) = __$NodeDraggedCopyWithImpl;
  @useResult
  $Res call({int nodeId, Offset delta});
}

/// @nodoc
class __$NodeDraggedCopyWithImpl<$Res> implements _$NodeDraggedCopyWith<$Res> {
  __$NodeDraggedCopyWithImpl(this._self, this._then);

  final _NodeDragged _self;
  final $Res Function(_NodeDragged) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? nodeId = null, Object? delta = null}) {
    return _then(
      _NodeDragged(
        nodeId:
            null == nodeId
                ? _self.nodeId
                : nodeId // ignore: cast_nullable_to_non_nullable
                    as int,
        delta:
            null == delta
                ? _self.delta
                : delta // ignore: cast_nullable_to_non_nullable
                    as Offset,
      ),
    );
  }
}

/// @nodoc

class _AddNode implements ShapeLayerEvent {
  const _AddNode(this.node);

  final Node node;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddNodeCopyWith<_AddNode> get copyWith =>
      __$AddNodeCopyWithImpl<_AddNode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddNode &&
            (identical(other.node, node) || other.node == node));
  }

  @override
  int get hashCode => Object.hash(runtimeType, node);

  @override
  String toString() {
    return 'ShapeLayerEvent.addNode(node: $node)';
  }
}

/// @nodoc
abstract mixin class _$AddNodeCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$AddNodeCopyWith(_AddNode value, $Res Function(_AddNode) _then) =
      __$AddNodeCopyWithImpl;
  @useResult
  $Res call({Node node});
}

/// @nodoc
class __$AddNodeCopyWithImpl<$Res> implements _$AddNodeCopyWith<$Res> {
  __$AddNodeCopyWithImpl(this._self, this._then);

  final _AddNode _self;
  final $Res Function(_AddNode) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? node = null}) {
    return _then(
      _AddNode(
        null == node
            ? _self.node
            : node // ignore: cast_nullable_to_non_nullable
                as Node,
      ),
    );
  }
}

/// @nodoc

class _RemoveNode implements ShapeLayerEvent {
  const _RemoveNode(this.nodeId);

  final int nodeId;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RemoveNodeCopyWith<_RemoveNode> get copyWith =>
      __$RemoveNodeCopyWithImpl<_RemoveNode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RemoveNode &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nodeId);

  @override
  String toString() {
    return 'ShapeLayerEvent.removeNode(nodeId: $nodeId)';
  }
}

/// @nodoc
abstract mixin class _$RemoveNodeCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$RemoveNodeCopyWith(
    _RemoveNode value,
    $Res Function(_RemoveNode) _then,
  ) = __$RemoveNodeCopyWithImpl;
  @useResult
  $Res call({int nodeId});
}

/// @nodoc
class __$RemoveNodeCopyWithImpl<$Res> implements _$RemoveNodeCopyWith<$Res> {
  __$RemoveNodeCopyWithImpl(this._self, this._then);

  final _RemoveNode _self;
  final $Res Function(_RemoveNode) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? nodeId = null}) {
    return _then(
      _RemoveNode(
        null == nodeId
            ? _self.nodeId
            : nodeId // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _ShapeSelected implements ShapeLayerEvent {
  const _ShapeSelected({required this.nodeId});

  final int nodeId;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShapeSelectedCopyWith<_ShapeSelected> get copyWith =>
      __$ShapeSelectedCopyWithImpl<_ShapeSelected>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShapeSelected &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nodeId);

  @override
  String toString() {
    return 'ShapeLayerEvent.shapeSelected(nodeId: $nodeId)';
  }
}

/// @nodoc
abstract mixin class _$ShapeSelectedCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$ShapeSelectedCopyWith(
    _ShapeSelected value,
    $Res Function(_ShapeSelected) _then,
  ) = __$ShapeSelectedCopyWithImpl;
  @useResult
  $Res call({int nodeId});
}

/// @nodoc
class __$ShapeSelectedCopyWithImpl<$Res>
    implements _$ShapeSelectedCopyWith<$Res> {
  __$ShapeSelectedCopyWithImpl(this._self, this._then);

  final _ShapeSelected _self;
  final $Res Function(_ShapeSelected) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? nodeId = null}) {
    return _then(
      _ShapeSelected(
        nodeId:
            null == nodeId
                ? _self.nodeId
                : nodeId // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _NodeSelected implements ShapeLayerEvent {
  const _NodeSelected(this.nodeId);

  final int? nodeId;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NodeSelectedCopyWith<_NodeSelected> get copyWith =>
      __$NodeSelectedCopyWithImpl<_NodeSelected>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NodeSelected &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nodeId);

  @override
  String toString() {
    return 'ShapeLayerEvent.nodeSelected(nodeId: $nodeId)';
  }
}

/// @nodoc
abstract mixin class _$NodeSelectedCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$NodeSelectedCopyWith(
    _NodeSelected value,
    $Res Function(_NodeSelected) _then,
  ) = __$NodeSelectedCopyWithImpl;
  @useResult
  $Res call({int? nodeId});
}

/// @nodoc
class __$NodeSelectedCopyWithImpl<$Res>
    implements _$NodeSelectedCopyWith<$Res> {
  __$NodeSelectedCopyWithImpl(this._self, this._then);

  final _NodeSelected _self;
  final $Res Function(_NodeSelected) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? nodeId = freezed}) {
    return _then(
      _NodeSelected(
        freezed == nodeId
            ? _self.nodeId
            : nodeId // ignore: cast_nullable_to_non_nullable
                as int?,
      ),
    );
  }
}

/// @nodoc

class _SelectAtPoint implements ShapeLayerEvent {
  const _SelectAtPoint(this.point);

  final Offset point;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SelectAtPointCopyWith<_SelectAtPoint> get copyWith =>
      __$SelectAtPointCopyWithImpl<_SelectAtPoint>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SelectAtPoint &&
            (identical(other.point, point) || other.point == point));
  }

  @override
  int get hashCode => Object.hash(runtimeType, point);

  @override
  String toString() {
    return 'ShapeLayerEvent.selectAtPoint(point: $point)';
  }
}

/// @nodoc
abstract mixin class _$SelectAtPointCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$SelectAtPointCopyWith(
    _SelectAtPoint value,
    $Res Function(_SelectAtPoint) _then,
  ) = __$SelectAtPointCopyWithImpl;
  @useResult
  $Res call({Offset point});
}

/// @nodoc
class __$SelectAtPointCopyWithImpl<$Res>
    implements _$SelectAtPointCopyWith<$Res> {
  __$SelectAtPointCopyWithImpl(this._self, this._then);

  final _SelectAtPoint _self;
  final $Res Function(_SelectAtPoint) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? point = null}) {
    return _then(
      _SelectAtPoint(
        null == point
            ? _self.point
            : point // ignore: cast_nullable_to_non_nullable
                as Offset,
      ),
    );
  }
}

/// @nodoc

class _UpdateNodes implements ShapeLayerEvent {
  const _UpdateNodes(final List<Node> nodes) : _nodes = nodes;

  final List<Node> _nodes;
  List<Node> get nodes {
    if (_nodes is EqualUnmodifiableListView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateNodesCopyWith<_UpdateNodes> get copyWith =>
      __$UpdateNodesCopyWithImpl<_UpdateNodes>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateNodes &&
            const DeepCollectionEquality().equals(other._nodes, _nodes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_nodes));

  @override
  String toString() {
    return 'ShapeLayerEvent.updateNodes(nodes: $nodes)';
  }
}

/// @nodoc
abstract mixin class _$UpdateNodesCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$UpdateNodesCopyWith(
    _UpdateNodes value,
    $Res Function(_UpdateNodes) _then,
  ) = __$UpdateNodesCopyWithImpl;
  @useResult
  $Res call({List<Node> nodes});
}

/// @nodoc
class __$UpdateNodesCopyWithImpl<$Res> implements _$UpdateNodesCopyWith<$Res> {
  __$UpdateNodesCopyWithImpl(this._self, this._then);

  final _UpdateNodes _self;
  final $Res Function(_UpdateNodes) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? nodes = null}) {
    return _then(
      _UpdateNodes(
        null == nodes
            ? _self._nodes
            : nodes // ignore: cast_nullable_to_non_nullable
                as List<Node>,
      ),
    );
  }
}

/// @nodoc

class _HiddenNodes implements ShapeLayerEvent {
  const _HiddenNodes(final Set<int> nodeIds) : _nodeIds = nodeIds;

  final Set<int> _nodeIds;
  Set<int> get nodeIds {
    if (_nodeIds is EqualUnmodifiableSetView) return _nodeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_nodeIds);
  }

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HiddenNodesCopyWith<_HiddenNodes> get copyWith =>
      __$HiddenNodesCopyWithImpl<_HiddenNodes>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HiddenNodes &&
            const DeepCollectionEquality().equals(other._nodeIds, _nodeIds));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_nodeIds));

  @override
  String toString() {
    return 'ShapeLayerEvent.hiddenNodes(nodeIds: $nodeIds)';
  }
}

/// @nodoc
abstract mixin class _$HiddenNodesCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$HiddenNodesCopyWith(
    _HiddenNodes value,
    $Res Function(_HiddenNodes) _then,
  ) = __$HiddenNodesCopyWithImpl;
  @useResult
  $Res call({Set<int> nodeIds});
}

/// @nodoc
class __$HiddenNodesCopyWithImpl<$Res> implements _$HiddenNodesCopyWith<$Res> {
  __$HiddenNodesCopyWithImpl(this._self, this._then);

  final _HiddenNodes _self;
  final $Res Function(_HiddenNodes) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? nodeIds = null}) {
    return _then(
      _HiddenNodes(
        null == nodeIds
            ? _self._nodeIds
            : nodeIds // ignore: cast_nullable_to_non_nullable
                as Set<int>,
      ),
    );
  }
}

/// @nodoc
mixin _$ShapeLayerState {
  ShapeLayerData get data;

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShapeLayerStateCopyWith<ShapeLayerState> get copyWith =>
      _$ShapeLayerStateCopyWithImpl<ShapeLayerState>(
        this as ShapeLayerState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShapeLayerState &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'ShapeLayerState(data: $data)';
  }
}

/// @nodoc
abstract mixin class $ShapeLayerStateCopyWith<$Res> {
  factory $ShapeLayerStateCopyWith(
    ShapeLayerState value,
    $Res Function(ShapeLayerState) _then,
  ) = _$ShapeLayerStateCopyWithImpl;
  @useResult
  $Res call({ShapeLayerData data});

  $ShapeLayerDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ShapeLayerStateCopyWithImpl<$Res>
    implements $ShapeLayerStateCopyWith<$Res> {
  _$ShapeLayerStateCopyWithImpl(this._self, this._then);

  final ShapeLayerState _self;
  final $Res Function(ShapeLayerState) _then;

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _self.copyWith(
        data:
            null == data
                ? _self.data
                : data // ignore: cast_nullable_to_non_nullable
                    as ShapeLayerData,
      ),
    );
  }

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShapeLayerDataCopyWith<$Res> get data {
    return $ShapeLayerDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ShapeLayerState].
extension ShapeLayerStatePatterns on ShapeLayerState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShapeLayerStateInitialize value)? initialize,
    TResult Function(ShapeLayerStateLoading value)? loading,
    TResult Function(ShapeLayerStateSuccess value)? success,
    TResult Function(ShapeLayerStateFailure value)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ShapeLayerStateInitialize() when initialize != null:
        return initialize(_that);
      case ShapeLayerStateLoading() when loading != null:
        return loading(_that);
      case ShapeLayerStateSuccess() when success != null:
        return success(_that);
      case ShapeLayerStateFailure() when failure != null:
        return failure(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShapeLayerStateInitialize value) initialize,
    required TResult Function(ShapeLayerStateLoading value) loading,
    required TResult Function(ShapeLayerStateSuccess value) success,
    required TResult Function(ShapeLayerStateFailure value) failure,
  }) {
    final _that = this;
    switch (_that) {
      case ShapeLayerStateInitialize():
        return initialize(_that);
      case ShapeLayerStateLoading():
        return loading(_that);
      case ShapeLayerStateSuccess():
        return success(_that);
      case ShapeLayerStateFailure():
        return failure(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShapeLayerStateInitialize value)? initialize,
    TResult? Function(ShapeLayerStateLoading value)? loading,
    TResult? Function(ShapeLayerStateSuccess value)? success,
    TResult? Function(ShapeLayerStateFailure value)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case ShapeLayerStateInitialize() when initialize != null:
        return initialize(_that);
      case ShapeLayerStateLoading() when loading != null:
        return loading(_that);
      case ShapeLayerStateSuccess() when success != null:
        return success(_that);
      case ShapeLayerStateFailure() when failure != null:
        return failure(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ShapeLayerData data)? initialize,
    TResult Function(ShapeLayerData data)? loading,
    TResult Function(ShapeLayerData data)? success,
    TResult Function(ShapeLayerData data, Exception failure)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ShapeLayerStateInitialize() when initialize != null:
        return initialize(_that.data);
      case ShapeLayerStateLoading() when loading != null:
        return loading(_that.data);
      case ShapeLayerStateSuccess() when success != null:
        return success(_that.data);
      case ShapeLayerStateFailure() when failure != null:
        return failure(_that.data, _that.failure);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ShapeLayerData data) initialize,
    required TResult Function(ShapeLayerData data) loading,
    required TResult Function(ShapeLayerData data) success,
    required TResult Function(ShapeLayerData data, Exception failure) failure,
  }) {
    final _that = this;
    switch (_that) {
      case ShapeLayerStateInitialize():
        return initialize(_that.data);
      case ShapeLayerStateLoading():
        return loading(_that.data);
      case ShapeLayerStateSuccess():
        return success(_that.data);
      case ShapeLayerStateFailure():
        return failure(_that.data, _that.failure);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ShapeLayerData data)? initialize,
    TResult? Function(ShapeLayerData data)? loading,
    TResult? Function(ShapeLayerData data)? success,
    TResult? Function(ShapeLayerData data, Exception failure)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case ShapeLayerStateInitialize() when initialize != null:
        return initialize(_that.data);
      case ShapeLayerStateLoading() when loading != null:
        return loading(_that.data);
      case ShapeLayerStateSuccess() when success != null:
        return success(_that.data);
      case ShapeLayerStateFailure() when failure != null:
        return failure(_that.data, _that.failure);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ShapeLayerStateInitialize implements ShapeLayerState {
  ShapeLayerStateInitialize({required this.data});

  @override
  final ShapeLayerData data;

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShapeLayerStateInitializeCopyWith<ShapeLayerStateInitialize> get copyWith =>
      _$ShapeLayerStateInitializeCopyWithImpl<ShapeLayerStateInitialize>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShapeLayerStateInitialize &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'ShapeLayerState.initialize(data: $data)';
  }
}

/// @nodoc
abstract mixin class $ShapeLayerStateInitializeCopyWith<$Res>
    implements $ShapeLayerStateCopyWith<$Res> {
  factory $ShapeLayerStateInitializeCopyWith(
    ShapeLayerStateInitialize value,
    $Res Function(ShapeLayerStateInitialize) _then,
  ) = _$ShapeLayerStateInitializeCopyWithImpl;
  @override
  @useResult
  $Res call({ShapeLayerData data});

  @override
  $ShapeLayerDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ShapeLayerStateInitializeCopyWithImpl<$Res>
    implements $ShapeLayerStateInitializeCopyWith<$Res> {
  _$ShapeLayerStateInitializeCopyWithImpl(this._self, this._then);

  final ShapeLayerStateInitialize _self;
  final $Res Function(ShapeLayerStateInitialize) _then;

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? data = null}) {
    return _then(
      ShapeLayerStateInitialize(
        data:
            null == data
                ? _self.data
                : data // ignore: cast_nullable_to_non_nullable
                    as ShapeLayerData,
      ),
    );
  }

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShapeLayerDataCopyWith<$Res> get data {
    return $ShapeLayerDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc

class ShapeLayerStateLoading implements ShapeLayerState {
  ShapeLayerStateLoading({required this.data});

  @override
  final ShapeLayerData data;

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShapeLayerStateLoadingCopyWith<ShapeLayerStateLoading> get copyWith =>
      _$ShapeLayerStateLoadingCopyWithImpl<ShapeLayerStateLoading>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShapeLayerStateLoading &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'ShapeLayerState.loading(data: $data)';
  }
}

/// @nodoc
abstract mixin class $ShapeLayerStateLoadingCopyWith<$Res>
    implements $ShapeLayerStateCopyWith<$Res> {
  factory $ShapeLayerStateLoadingCopyWith(
    ShapeLayerStateLoading value,
    $Res Function(ShapeLayerStateLoading) _then,
  ) = _$ShapeLayerStateLoadingCopyWithImpl;
  @override
  @useResult
  $Res call({ShapeLayerData data});

  @override
  $ShapeLayerDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ShapeLayerStateLoadingCopyWithImpl<$Res>
    implements $ShapeLayerStateLoadingCopyWith<$Res> {
  _$ShapeLayerStateLoadingCopyWithImpl(this._self, this._then);

  final ShapeLayerStateLoading _self;
  final $Res Function(ShapeLayerStateLoading) _then;

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? data = null}) {
    return _then(
      ShapeLayerStateLoading(
        data:
            null == data
                ? _self.data
                : data // ignore: cast_nullable_to_non_nullable
                    as ShapeLayerData,
      ),
    );
  }

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShapeLayerDataCopyWith<$Res> get data {
    return $ShapeLayerDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc

class ShapeLayerStateSuccess implements ShapeLayerState {
  ShapeLayerStateSuccess({required this.data});

  @override
  final ShapeLayerData data;

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShapeLayerStateSuccessCopyWith<ShapeLayerStateSuccess> get copyWith =>
      _$ShapeLayerStateSuccessCopyWithImpl<ShapeLayerStateSuccess>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShapeLayerStateSuccess &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'ShapeLayerState.success(data: $data)';
  }
}

/// @nodoc
abstract mixin class $ShapeLayerStateSuccessCopyWith<$Res>
    implements $ShapeLayerStateCopyWith<$Res> {
  factory $ShapeLayerStateSuccessCopyWith(
    ShapeLayerStateSuccess value,
    $Res Function(ShapeLayerStateSuccess) _then,
  ) = _$ShapeLayerStateSuccessCopyWithImpl;
  @override
  @useResult
  $Res call({ShapeLayerData data});

  @override
  $ShapeLayerDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ShapeLayerStateSuccessCopyWithImpl<$Res>
    implements $ShapeLayerStateSuccessCopyWith<$Res> {
  _$ShapeLayerStateSuccessCopyWithImpl(this._self, this._then);

  final ShapeLayerStateSuccess _self;
  final $Res Function(ShapeLayerStateSuccess) _then;

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? data = null}) {
    return _then(
      ShapeLayerStateSuccess(
        data:
            null == data
                ? _self.data
                : data // ignore: cast_nullable_to_non_nullable
                    as ShapeLayerData,
      ),
    );
  }

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShapeLayerDataCopyWith<$Res> get data {
    return $ShapeLayerDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc

class ShapeLayerStateFailure implements ShapeLayerState {
  ShapeLayerStateFailure({required this.data, required this.failure});

  @override
  final ShapeLayerData data;
  final Exception failure;

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShapeLayerStateFailureCopyWith<ShapeLayerStateFailure> get copyWith =>
      _$ShapeLayerStateFailureCopyWithImpl<ShapeLayerStateFailure>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShapeLayerStateFailure &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, failure);

  @override
  String toString() {
    return 'ShapeLayerState.failure(data: $data, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class $ShapeLayerStateFailureCopyWith<$Res>
    implements $ShapeLayerStateCopyWith<$Res> {
  factory $ShapeLayerStateFailureCopyWith(
    ShapeLayerStateFailure value,
    $Res Function(ShapeLayerStateFailure) _then,
  ) = _$ShapeLayerStateFailureCopyWithImpl;
  @override
  @useResult
  $Res call({ShapeLayerData data, Exception failure});

  @override
  $ShapeLayerDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ShapeLayerStateFailureCopyWithImpl<$Res>
    implements $ShapeLayerStateFailureCopyWith<$Res> {
  _$ShapeLayerStateFailureCopyWithImpl(this._self, this._then);

  final ShapeLayerStateFailure _self;
  final $Res Function(ShapeLayerStateFailure) _then;

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? data = null, Object? failure = null}) {
    return _then(
      ShapeLayerStateFailure(
        data:
            null == data
                ? _self.data
                : data // ignore: cast_nullable_to_non_nullable
                    as ShapeLayerData,
        failure:
            null == failure
                ? _self.failure
                : failure // ignore: cast_nullable_to_non_nullable
                    as Exception,
      ),
    );
  }

  /// Create a copy of ShapeLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShapeLayerDataCopyWith<$Res> get data {
    return $ShapeLayerDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc
mixin _$ShapeLayerData {
  Map<int, Node> get nodes;
  int? get selectedTool;
  int? get selectedNodeId;
  Set<int> get hiddenNodeIds;

  /// Create a copy of ShapeLayerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShapeLayerDataCopyWith<ShapeLayerData> get copyWith =>
      _$ShapeLayerDataCopyWithImpl<ShapeLayerData>(
        this as ShapeLayerData,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShapeLayerData &&
            const DeepCollectionEquality().equals(other.nodes, nodes) &&
            (identical(other.selectedTool, selectedTool) ||
                other.selectedTool == selectedTool) &&
            (identical(other.selectedNodeId, selectedNodeId) ||
                other.selectedNodeId == selectedNodeId) &&
            const DeepCollectionEquality().equals(
              other.hiddenNodeIds,
              hiddenNodeIds,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(nodes),
    selectedTool,
    selectedNodeId,
    const DeepCollectionEquality().hash(hiddenNodeIds),
  );

  @override
  String toString() {
    return 'ShapeLayerData(nodes: $nodes, selectedTool: $selectedTool, selectedNodeId: $selectedNodeId, hiddenNodeIds: $hiddenNodeIds)';
  }
}

/// @nodoc
abstract mixin class $ShapeLayerDataCopyWith<$Res> {
  factory $ShapeLayerDataCopyWith(
    ShapeLayerData value,
    $Res Function(ShapeLayerData) _then,
  ) = _$ShapeLayerDataCopyWithImpl;
  @useResult
  $Res call({
    Map<int, Node> nodes,
    int? selectedTool,
    int? selectedNodeId,
    Set<int> hiddenNodeIds,
  });
}

/// @nodoc
class _$ShapeLayerDataCopyWithImpl<$Res>
    implements $ShapeLayerDataCopyWith<$Res> {
  _$ShapeLayerDataCopyWithImpl(this._self, this._then);

  final ShapeLayerData _self;
  final $Res Function(ShapeLayerData) _then;

  /// Create a copy of ShapeLayerData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? selectedTool = freezed,
    Object? selectedNodeId = freezed,
    Object? hiddenNodeIds = null,
  }) {
    return _then(
      _self.copyWith(
        nodes:
            null == nodes
                ? _self.nodes
                : nodes // ignore: cast_nullable_to_non_nullable
                    as Map<int, Node>,
        selectedTool:
            freezed == selectedTool
                ? _self.selectedTool
                : selectedTool // ignore: cast_nullable_to_non_nullable
                    as int?,
        selectedNodeId:
            freezed == selectedNodeId
                ? _self.selectedNodeId
                : selectedNodeId // ignore: cast_nullable_to_non_nullable
                    as int?,
        hiddenNodeIds:
            null == hiddenNodeIds
                ? _self.hiddenNodeIds
                : hiddenNodeIds // ignore: cast_nullable_to_non_nullable
                    as Set<int>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [ShapeLayerData].
extension ShapeLayerDataPatterns on ShapeLayerData {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ShapeLayerData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShapeLayerData() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ShapeLayerData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShapeLayerData():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ShapeLayerData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShapeLayerData() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
      Map<int, Node> nodes,
      int? selectedTool,
      int? selectedNodeId,
      Set<int> hiddenNodeIds,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShapeLayerData() when $default != null:
        return $default(
          _that.nodes,
          _that.selectedTool,
          _that.selectedNodeId,
          _that.hiddenNodeIds,
        );
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
      Map<int, Node> nodes,
      int? selectedTool,
      int? selectedNodeId,
      Set<int> hiddenNodeIds,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShapeLayerData():
        return $default(
          _that.nodes,
          _that.selectedTool,
          _that.selectedNodeId,
          _that.hiddenNodeIds,
        );
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      Map<int, Node> nodes,
      int? selectedTool,
      int? selectedNodeId,
      Set<int> hiddenNodeIds,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShapeLayerData() when $default != null:
        return $default(
          _that.nodes,
          _that.selectedTool,
          _that.selectedNodeId,
          _that.hiddenNodeIds,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ShapeLayerData implements ShapeLayerData {
  const _ShapeLayerData({
    final Map<int, Node> nodes = const {},
    this.selectedTool,
    this.selectedNodeId,
    final Set<int> hiddenNodeIds = const {},
  }) : _nodes = nodes,
       _hiddenNodeIds = hiddenNodeIds;

  final Map<int, Node> _nodes;
  @override
  @JsonKey()
  Map<int, Node> get nodes {
    if (_nodes is EqualUnmodifiableMapView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_nodes);
  }

  @override
  final int? selectedTool;
  @override
  final int? selectedNodeId;
  final Set<int> _hiddenNodeIds;
  @override
  @JsonKey()
  Set<int> get hiddenNodeIds {
    if (_hiddenNodeIds is EqualUnmodifiableSetView) return _hiddenNodeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_hiddenNodeIds);
  }

  /// Create a copy of ShapeLayerData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShapeLayerDataCopyWith<_ShapeLayerData> get copyWith =>
      __$ShapeLayerDataCopyWithImpl<_ShapeLayerData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShapeLayerData &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            (identical(other.selectedTool, selectedTool) ||
                other.selectedTool == selectedTool) &&
            (identical(other.selectedNodeId, selectedNodeId) ||
                other.selectedNodeId == selectedNodeId) &&
            const DeepCollectionEquality().equals(
              other._hiddenNodeIds,
              _hiddenNodeIds,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_nodes),
    selectedTool,
    selectedNodeId,
    const DeepCollectionEquality().hash(_hiddenNodeIds),
  );

  @override
  String toString() {
    return 'ShapeLayerData(nodes: $nodes, selectedTool: $selectedTool, selectedNodeId: $selectedNodeId, hiddenNodeIds: $hiddenNodeIds)';
  }
}

/// @nodoc
abstract mixin class _$ShapeLayerDataCopyWith<$Res>
    implements $ShapeLayerDataCopyWith<$Res> {
  factory _$ShapeLayerDataCopyWith(
    _ShapeLayerData value,
    $Res Function(_ShapeLayerData) _then,
  ) = __$ShapeLayerDataCopyWithImpl;
  @override
  @useResult
  $Res call({
    Map<int, Node> nodes,
    int? selectedTool,
    int? selectedNodeId,
    Set<int> hiddenNodeIds,
  });
}

/// @nodoc
class __$ShapeLayerDataCopyWithImpl<$Res>
    implements _$ShapeLayerDataCopyWith<$Res> {
  __$ShapeLayerDataCopyWithImpl(this._self, this._then);

  final _ShapeLayerData _self;
  final $Res Function(_ShapeLayerData) _then;

  /// Create a copy of ShapeLayerData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nodes = null,
    Object? selectedTool = freezed,
    Object? selectedNodeId = freezed,
    Object? hiddenNodeIds = null,
  }) {
    return _then(
      _ShapeLayerData(
        nodes:
            null == nodes
                ? _self._nodes
                : nodes // ignore: cast_nullable_to_non_nullable
                    as Map<int, Node>,
        selectedTool:
            freezed == selectedTool
                ? _self.selectedTool
                : selectedTool // ignore: cast_nullable_to_non_nullable
                    as int?,
        selectedNodeId:
            freezed == selectedNodeId
                ? _self.selectedNodeId
                : selectedNodeId // ignore: cast_nullable_to_non_nullable
                    as int?,
        hiddenNodeIds:
            null == hiddenNodeIds
                ? _self._hiddenNodeIds
                : hiddenNodeIds // ignore: cast_nullable_to_non_nullable
                    as Set<int>,
      ),
    );
  }
}
