// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_layer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActiveLayerState {
  Map<int, Node> get activeNodes;
  Offset? get dragStartPoint;

  /// The original object state before a move operation started.
  /// Used for creating MoveNodeCommand for undo/redo.
  Node? get originalNode;
  ResizeHandle? get resizeHandle;
  ConnectorHandle? get connectorHandle;

  /// The ID of the object where a connector drag started (optional).
  int? get connectorStartNodeId;

  /// The starting point of the connector drag.
  Offset? get connectorStartPoint;

  /// The current drag position for connector preview.
  Offset? get connectorDragPosition;

  /// The ID of the object being hovered while connector tool is active.
  int? get connectorHoverNodeId;

  /// Create a copy of ActiveLayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActiveLayerStateCopyWith<ActiveLayerState> get copyWith =>
      _$ActiveLayerStateCopyWithImpl<ActiveLayerState>(
        this as ActiveLayerState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActiveLayerState &&
            const DeepCollectionEquality().equals(
              other.activeNodes,
              activeNodes,
            ) &&
            (identical(other.dragStartPoint, dragStartPoint) ||
                other.dragStartPoint == dragStartPoint) &&
            (identical(other.originalNode, originalNode) ||
                other.originalNode == originalNode) &&
            (identical(other.resizeHandle, resizeHandle) ||
                other.resizeHandle == resizeHandle) &&
            (identical(other.connectorHandle, connectorHandle) ||
                other.connectorHandle == connectorHandle) &&
            (identical(other.connectorStartNodeId, connectorStartNodeId) ||
                other.connectorStartNodeId == connectorStartNodeId) &&
            (identical(other.connectorStartPoint, connectorStartPoint) ||
                other.connectorStartPoint == connectorStartPoint) &&
            (identical(other.connectorDragPosition, connectorDragPosition) ||
                other.connectorDragPosition == connectorDragPosition) &&
            (identical(other.connectorHoverNodeId, connectorHoverNodeId) ||
                other.connectorHoverNodeId == connectorHoverNodeId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(activeNodes),
    dragStartPoint,
    originalNode,
    resizeHandle,
    connectorHandle,
    connectorStartNodeId,
    connectorStartPoint,
    connectorDragPosition,
    connectorHoverNodeId,
  );

  @override
  String toString() {
    return 'ActiveLayerState(activeNodes: $activeNodes, dragStartPoint: $dragStartPoint, originalNode: $originalNode, resizeHandle: $resizeHandle, connectorHandle: $connectorHandle, connectorStartNodeId: $connectorStartNodeId, connectorStartPoint: $connectorStartPoint, connectorDragPosition: $connectorDragPosition, connectorHoverNodeId: $connectorHoverNodeId)';
  }
}

/// @nodoc
abstract mixin class $ActiveLayerStateCopyWith<$Res> {
  factory $ActiveLayerStateCopyWith(
    ActiveLayerState value,
    $Res Function(ActiveLayerState) _then,
  ) = _$ActiveLayerStateCopyWithImpl;
  @useResult
  $Res call({
    Map<int, Node> activeNodes,
    Offset? dragStartPoint,
    Node? originalNode,
    ResizeHandle? resizeHandle,
    ConnectorHandle? connectorHandle,
    int? connectorStartNodeId,
    Offset? connectorStartPoint,
    Offset? connectorDragPosition,
    int? connectorHoverNodeId,
  });
}

/// @nodoc
class _$ActiveLayerStateCopyWithImpl<$Res>
    implements $ActiveLayerStateCopyWith<$Res> {
  _$ActiveLayerStateCopyWithImpl(this._self, this._then);

  final ActiveLayerState _self;
  final $Res Function(ActiveLayerState) _then;

  /// Create a copy of ActiveLayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeNodes = null,
    Object? dragStartPoint = freezed,
    Object? originalNode = freezed,
    Object? resizeHandle = freezed,
    Object? connectorHandle = freezed,
    Object? connectorStartNodeId = freezed,
    Object? connectorStartPoint = freezed,
    Object? connectorDragPosition = freezed,
    Object? connectorHoverNodeId = freezed,
  }) {
    return _then(
      _self.copyWith(
        activeNodes:
            null == activeNodes
                ? _self.activeNodes
                : activeNodes // ignore: cast_nullable_to_non_nullable
                    as Map<int, Node>,
        dragStartPoint:
            freezed == dragStartPoint
                ? _self.dragStartPoint
                : dragStartPoint // ignore: cast_nullable_to_non_nullable
                    as Offset?,
        originalNode:
            freezed == originalNode
                ? _self.originalNode
                : originalNode // ignore: cast_nullable_to_non_nullable
                    as Node?,
        resizeHandle:
            freezed == resizeHandle
                ? _self.resizeHandle
                : resizeHandle // ignore: cast_nullable_to_non_nullable
                    as ResizeHandle?,
        connectorHandle:
            freezed == connectorHandle
                ? _self.connectorHandle
                : connectorHandle // ignore: cast_nullable_to_non_nullable
                    as ConnectorHandle?,
        connectorStartNodeId:
            freezed == connectorStartNodeId
                ? _self.connectorStartNodeId
                : connectorStartNodeId // ignore: cast_nullable_to_non_nullable
                    as int?,
        connectorStartPoint:
            freezed == connectorStartPoint
                ? _self.connectorStartPoint
                : connectorStartPoint // ignore: cast_nullable_to_non_nullable
                    as Offset?,
        connectorDragPosition:
            freezed == connectorDragPosition
                ? _self.connectorDragPosition
                : connectorDragPosition // ignore: cast_nullable_to_non_nullable
                    as Offset?,
        connectorHoverNodeId:
            freezed == connectorHoverNodeId
                ? _self.connectorHoverNodeId
                : connectorHoverNodeId // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [ActiveLayerState].
extension ActiveLayerStatePatterns on ActiveLayerState {
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
    TResult Function(_ActiveLayerState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ActiveLayerState() when $default != null:
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
    TResult Function(_ActiveLayerState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActiveLayerState():
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
    TResult? Function(_ActiveLayerState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActiveLayerState() when $default != null:
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
      Map<int, Node> activeNodes,
      Offset? dragStartPoint,
      Node? originalNode,
      ResizeHandle? resizeHandle,
      ConnectorHandle? connectorHandle,
      int? connectorStartNodeId,
      Offset? connectorStartPoint,
      Offset? connectorDragPosition,
      int? connectorHoverNodeId,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ActiveLayerState() when $default != null:
        return $default(
          _that.activeNodes,
          _that.dragStartPoint,
          _that.originalNode,
          _that.resizeHandle,
          _that.connectorHandle,
          _that.connectorStartNodeId,
          _that.connectorStartPoint,
          _that.connectorDragPosition,
          _that.connectorHoverNodeId,
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
      Map<int, Node> activeNodes,
      Offset? dragStartPoint,
      Node? originalNode,
      ResizeHandle? resizeHandle,
      ConnectorHandle? connectorHandle,
      int? connectorStartNodeId,
      Offset? connectorStartPoint,
      Offset? connectorDragPosition,
      int? connectorHoverNodeId,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActiveLayerState():
        return $default(
          _that.activeNodes,
          _that.dragStartPoint,
          _that.originalNode,
          _that.resizeHandle,
          _that.connectorHandle,
          _that.connectorStartNodeId,
          _that.connectorStartPoint,
          _that.connectorDragPosition,
          _that.connectorHoverNodeId,
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
      Map<int, Node> activeNodes,
      Offset? dragStartPoint,
      Node? originalNode,
      ResizeHandle? resizeHandle,
      ConnectorHandle? connectorHandle,
      int? connectorStartNodeId,
      Offset? connectorStartPoint,
      Offset? connectorDragPosition,
      int? connectorHoverNodeId,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActiveLayerState() when $default != null:
        return $default(
          _that.activeNodes,
          _that.dragStartPoint,
          _that.originalNode,
          _that.resizeHandle,
          _that.connectorHandle,
          _that.connectorStartNodeId,
          _that.connectorStartPoint,
          _that.connectorDragPosition,
          _that.connectorHoverNodeId,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ActiveLayerState implements ActiveLayerState {
  const _ActiveLayerState({
    final Map<int, Node> activeNodes = const {},
    this.dragStartPoint,
    this.originalNode,
    this.resizeHandle,
    this.connectorHandle,
    this.connectorStartNodeId,
    this.connectorStartPoint,
    this.connectorDragPosition,
    this.connectorHoverNodeId,
  }) : _activeNodes = activeNodes;

  final Map<int, Node> _activeNodes;
  @override
  @JsonKey()
  Map<int, Node> get activeNodes {
    if (_activeNodes is EqualUnmodifiableMapView) return _activeNodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_activeNodes);
  }

  @override
  final Offset? dragStartPoint;

  /// The original object state before a move operation started.
  /// Used for creating MoveNodeCommand for undo/redo.
  @override
  final Node? originalNode;
  @override
  final ResizeHandle? resizeHandle;
  @override
  final ConnectorHandle? connectorHandle;

  /// The ID of the object where a connector drag started (optional).
  @override
  final int? connectorStartNodeId;

  /// The starting point of the connector drag.
  @override
  final Offset? connectorStartPoint;

  /// The current drag position for connector preview.
  @override
  final Offset? connectorDragPosition;

  /// The ID of the object being hovered while connector tool is active.
  @override
  final int? connectorHoverNodeId;

  /// Create a copy of ActiveLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActiveLayerStateCopyWith<_ActiveLayerState> get copyWith =>
      __$ActiveLayerStateCopyWithImpl<_ActiveLayerState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ActiveLayerState &&
            const DeepCollectionEquality().equals(
              other._activeNodes,
              _activeNodes,
            ) &&
            (identical(other.dragStartPoint, dragStartPoint) ||
                other.dragStartPoint == dragStartPoint) &&
            (identical(other.originalNode, originalNode) ||
                other.originalNode == originalNode) &&
            (identical(other.resizeHandle, resizeHandle) ||
                other.resizeHandle == resizeHandle) &&
            (identical(other.connectorHandle, connectorHandle) ||
                other.connectorHandle == connectorHandle) &&
            (identical(other.connectorStartNodeId, connectorStartNodeId) ||
                other.connectorStartNodeId == connectorStartNodeId) &&
            (identical(other.connectorStartPoint, connectorStartPoint) ||
                other.connectorStartPoint == connectorStartPoint) &&
            (identical(other.connectorDragPosition, connectorDragPosition) ||
                other.connectorDragPosition == connectorDragPosition) &&
            (identical(other.connectorHoverNodeId, connectorHoverNodeId) ||
                other.connectorHoverNodeId == connectorHoverNodeId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_activeNodes),
    dragStartPoint,
    originalNode,
    resizeHandle,
    connectorHandle,
    connectorStartNodeId,
    connectorStartPoint,
    connectorDragPosition,
    connectorHoverNodeId,
  );

  @override
  String toString() {
    return 'ActiveLayerState(activeNodes: $activeNodes, dragStartPoint: $dragStartPoint, originalNode: $originalNode, resizeHandle: $resizeHandle, connectorHandle: $connectorHandle, connectorStartNodeId: $connectorStartNodeId, connectorStartPoint: $connectorStartPoint, connectorDragPosition: $connectorDragPosition, connectorHoverNodeId: $connectorHoverNodeId)';
  }
}

/// @nodoc
abstract mixin class _$ActiveLayerStateCopyWith<$Res>
    implements $ActiveLayerStateCopyWith<$Res> {
  factory _$ActiveLayerStateCopyWith(
    _ActiveLayerState value,
    $Res Function(_ActiveLayerState) _then,
  ) = __$ActiveLayerStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    Map<int, Node> activeNodes,
    Offset? dragStartPoint,
    Node? originalNode,
    ResizeHandle? resizeHandle,
    ConnectorHandle? connectorHandle,
    int? connectorStartNodeId,
    Offset? connectorStartPoint,
    Offset? connectorDragPosition,
    int? connectorHoverNodeId,
  });
}

/// @nodoc
class __$ActiveLayerStateCopyWithImpl<$Res>
    implements _$ActiveLayerStateCopyWith<$Res> {
  __$ActiveLayerStateCopyWithImpl(this._self, this._then);

  final _ActiveLayerState _self;
  final $Res Function(_ActiveLayerState) _then;

  /// Create a copy of ActiveLayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? activeNodes = null,
    Object? dragStartPoint = freezed,
    Object? originalNode = freezed,
    Object? resizeHandle = freezed,
    Object? connectorHandle = freezed,
    Object? connectorStartNodeId = freezed,
    Object? connectorStartPoint = freezed,
    Object? connectorDragPosition = freezed,
    Object? connectorHoverNodeId = freezed,
  }) {
    return _then(
      _ActiveLayerState(
        activeNodes:
            null == activeNodes
                ? _self._activeNodes
                : activeNodes // ignore: cast_nullable_to_non_nullable
                    as Map<int, Node>,
        dragStartPoint:
            freezed == dragStartPoint
                ? _self.dragStartPoint
                : dragStartPoint // ignore: cast_nullable_to_non_nullable
                    as Offset?,
        originalNode:
            freezed == originalNode
                ? _self.originalNode
                : originalNode // ignore: cast_nullable_to_non_nullable
                    as Node?,
        resizeHandle:
            freezed == resizeHandle
                ? _self.resizeHandle
                : resizeHandle // ignore: cast_nullable_to_non_nullable
                    as ResizeHandle?,
        connectorHandle:
            freezed == connectorHandle
                ? _self.connectorHandle
                : connectorHandle // ignore: cast_nullable_to_non_nullable
                    as ConnectorHandle?,
        connectorStartNodeId:
            freezed == connectorStartNodeId
                ? _self.connectorStartNodeId
                : connectorStartNodeId // ignore: cast_nullable_to_non_nullable
                    as int?,
        connectorStartPoint:
            freezed == connectorStartPoint
                ? _self.connectorStartPoint
                : connectorStartPoint // ignore: cast_nullable_to_non_nullable
                    as Offset?,
        connectorDragPosition:
            freezed == connectorDragPosition
                ? _self.connectorDragPosition
                : connectorDragPosition // ignore: cast_nullable_to_non_nullable
                    as Offset?,
        connectorHoverNodeId:
            freezed == connectorHoverNodeId
                ? _self.connectorHoverNodeId
                : connectorHoverNodeId // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}
