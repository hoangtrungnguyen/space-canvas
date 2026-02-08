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
  Map<int, SpaceObject> get activeObjects;
  Offset? get dragStartPoint;

  /// The original object state before a move operation started.
  /// Used for creating MoveObjectCommand for undo/redo.
  SpaceObject? get originalObject;
  ResizeHandle? get resizeHandle;
  ConnectorHandle? get connectorHandle;

  /// The ID of the object where a connector drag started (optional).
  int? get connectorStartObjectId;

  /// The starting point of the connector drag.
  Offset? get connectorStartPoint;

  /// The current drag position for connector preview.
  Offset? get connectorDragPosition;

  /// The ID of the object being hovered while connector tool is active.
  int? get connectorHoverObjectId;

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
              other.activeObjects,
              activeObjects,
            ) &&
            (identical(other.dragStartPoint, dragStartPoint) ||
                other.dragStartPoint == dragStartPoint) &&
            (identical(other.originalObject, originalObject) ||
                other.originalObject == originalObject) &&
            (identical(other.resizeHandle, resizeHandle) ||
                other.resizeHandle == resizeHandle) &&
            (identical(other.connectorHandle, connectorHandle) ||
                other.connectorHandle == connectorHandle) &&
            (identical(other.connectorStartObjectId, connectorStartObjectId) ||
                other.connectorStartObjectId == connectorStartObjectId) &&
            (identical(other.connectorStartPoint, connectorStartPoint) ||
                other.connectorStartPoint == connectorStartPoint) &&
            (identical(other.connectorDragPosition, connectorDragPosition) ||
                other.connectorDragPosition == connectorDragPosition) &&
            (identical(other.connectorHoverObjectId, connectorHoverObjectId) ||
                other.connectorHoverObjectId == connectorHoverObjectId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(activeObjects),
    dragStartPoint,
    originalObject,
    resizeHandle,
    connectorHandle,
    connectorStartObjectId,
    connectorStartPoint,
    connectorDragPosition,
    connectorHoverObjectId,
  );

  @override
  String toString() {
    return 'ActiveLayerState(activeObjects: $activeObjects, dragStartPoint: $dragStartPoint, originalObject: $originalObject, resizeHandle: $resizeHandle, connectorHandle: $connectorHandle, connectorStartObjectId: $connectorStartObjectId, connectorStartPoint: $connectorStartPoint, connectorDragPosition: $connectorDragPosition, connectorHoverObjectId: $connectorHoverObjectId)';
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
    Map<int, SpaceObject> activeObjects,
    Offset? dragStartPoint,
    SpaceObject? originalObject,
    ResizeHandle? resizeHandle,
    ConnectorHandle? connectorHandle,
    int? connectorStartObjectId,
    Offset? connectorStartPoint,
    Offset? connectorDragPosition,
    int? connectorHoverObjectId,
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
    Object? activeObjects = null,
    Object? dragStartPoint = freezed,
    Object? originalObject = freezed,
    Object? resizeHandle = freezed,
    Object? connectorHandle = freezed,
    Object? connectorStartObjectId = freezed,
    Object? connectorStartPoint = freezed,
    Object? connectorDragPosition = freezed,
    Object? connectorHoverObjectId = freezed,
  }) {
    return _then(
      _self.copyWith(
        activeObjects:
            null == activeObjects
                ? _self.activeObjects
                : activeObjects // ignore: cast_nullable_to_non_nullable
                    as Map<int, SpaceObject>,
        dragStartPoint:
            freezed == dragStartPoint
                ? _self.dragStartPoint
                : dragStartPoint // ignore: cast_nullable_to_non_nullable
                    as Offset?,
        originalObject:
            freezed == originalObject
                ? _self.originalObject
                : originalObject // ignore: cast_nullable_to_non_nullable
                    as SpaceObject?,
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
        connectorStartObjectId:
            freezed == connectorStartObjectId
                ? _self.connectorStartObjectId
                : connectorStartObjectId // ignore: cast_nullable_to_non_nullable
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
        connectorHoverObjectId:
            freezed == connectorHoverObjectId
                ? _self.connectorHoverObjectId
                : connectorHoverObjectId // ignore: cast_nullable_to_non_nullable
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
      Map<int, SpaceObject> activeObjects,
      Offset? dragStartPoint,
      SpaceObject? originalObject,
      ResizeHandle? resizeHandle,
      ConnectorHandle? connectorHandle,
      int? connectorStartObjectId,
      Offset? connectorStartPoint,
      Offset? connectorDragPosition,
      int? connectorHoverObjectId,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ActiveLayerState() when $default != null:
        return $default(
          _that.activeObjects,
          _that.dragStartPoint,
          _that.originalObject,
          _that.resizeHandle,
          _that.connectorHandle,
          _that.connectorStartObjectId,
          _that.connectorStartPoint,
          _that.connectorDragPosition,
          _that.connectorHoverObjectId,
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
      Map<int, SpaceObject> activeObjects,
      Offset? dragStartPoint,
      SpaceObject? originalObject,
      ResizeHandle? resizeHandle,
      ConnectorHandle? connectorHandle,
      int? connectorStartObjectId,
      Offset? connectorStartPoint,
      Offset? connectorDragPosition,
      int? connectorHoverObjectId,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActiveLayerState():
        return $default(
          _that.activeObjects,
          _that.dragStartPoint,
          _that.originalObject,
          _that.resizeHandle,
          _that.connectorHandle,
          _that.connectorStartObjectId,
          _that.connectorStartPoint,
          _that.connectorDragPosition,
          _that.connectorHoverObjectId,
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
      Map<int, SpaceObject> activeObjects,
      Offset? dragStartPoint,
      SpaceObject? originalObject,
      ResizeHandle? resizeHandle,
      ConnectorHandle? connectorHandle,
      int? connectorStartObjectId,
      Offset? connectorStartPoint,
      Offset? connectorDragPosition,
      int? connectorHoverObjectId,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActiveLayerState() when $default != null:
        return $default(
          _that.activeObjects,
          _that.dragStartPoint,
          _that.originalObject,
          _that.resizeHandle,
          _that.connectorHandle,
          _that.connectorStartObjectId,
          _that.connectorStartPoint,
          _that.connectorDragPosition,
          _that.connectorHoverObjectId,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ActiveLayerState implements ActiveLayerState {
  const _ActiveLayerState({
    final Map<int, SpaceObject> activeObjects = const {},
    this.dragStartPoint,
    this.originalObject,
    this.resizeHandle,
    this.connectorHandle,
    this.connectorStartObjectId,
    this.connectorStartPoint,
    this.connectorDragPosition,
    this.connectorHoverObjectId,
  }) : _activeObjects = activeObjects;

  final Map<int, SpaceObject> _activeObjects;
  @override
  @JsonKey()
  Map<int, SpaceObject> get activeObjects {
    if (_activeObjects is EqualUnmodifiableMapView) return _activeObjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_activeObjects);
  }

  @override
  final Offset? dragStartPoint;

  /// The original object state before a move operation started.
  /// Used for creating MoveObjectCommand for undo/redo.
  @override
  final SpaceObject? originalObject;
  @override
  final ResizeHandle? resizeHandle;
  @override
  final ConnectorHandle? connectorHandle;

  /// The ID of the object where a connector drag started (optional).
  @override
  final int? connectorStartObjectId;

  /// The starting point of the connector drag.
  @override
  final Offset? connectorStartPoint;

  /// The current drag position for connector preview.
  @override
  final Offset? connectorDragPosition;

  /// The ID of the object being hovered while connector tool is active.
  @override
  final int? connectorHoverObjectId;

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
              other._activeObjects,
              _activeObjects,
            ) &&
            (identical(other.dragStartPoint, dragStartPoint) ||
                other.dragStartPoint == dragStartPoint) &&
            (identical(other.originalObject, originalObject) ||
                other.originalObject == originalObject) &&
            (identical(other.resizeHandle, resizeHandle) ||
                other.resizeHandle == resizeHandle) &&
            (identical(other.connectorHandle, connectorHandle) ||
                other.connectorHandle == connectorHandle) &&
            (identical(other.connectorStartObjectId, connectorStartObjectId) ||
                other.connectorStartObjectId == connectorStartObjectId) &&
            (identical(other.connectorStartPoint, connectorStartPoint) ||
                other.connectorStartPoint == connectorStartPoint) &&
            (identical(other.connectorDragPosition, connectorDragPosition) ||
                other.connectorDragPosition == connectorDragPosition) &&
            (identical(other.connectorHoverObjectId, connectorHoverObjectId) ||
                other.connectorHoverObjectId == connectorHoverObjectId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_activeObjects),
    dragStartPoint,
    originalObject,
    resizeHandle,
    connectorHandle,
    connectorStartObjectId,
    connectorStartPoint,
    connectorDragPosition,
    connectorHoverObjectId,
  );

  @override
  String toString() {
    return 'ActiveLayerState(activeObjects: $activeObjects, dragStartPoint: $dragStartPoint, originalObject: $originalObject, resizeHandle: $resizeHandle, connectorHandle: $connectorHandle, connectorStartObjectId: $connectorStartObjectId, connectorStartPoint: $connectorStartPoint, connectorDragPosition: $connectorDragPosition, connectorHoverObjectId: $connectorHoverObjectId)';
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
    Map<int, SpaceObject> activeObjects,
    Offset? dragStartPoint,
    SpaceObject? originalObject,
    ResizeHandle? resizeHandle,
    ConnectorHandle? connectorHandle,
    int? connectorStartObjectId,
    Offset? connectorStartPoint,
    Offset? connectorDragPosition,
    int? connectorHoverObjectId,
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
    Object? activeObjects = null,
    Object? dragStartPoint = freezed,
    Object? originalObject = freezed,
    Object? resizeHandle = freezed,
    Object? connectorHandle = freezed,
    Object? connectorStartObjectId = freezed,
    Object? connectorStartPoint = freezed,
    Object? connectorDragPosition = freezed,
    Object? connectorHoverObjectId = freezed,
  }) {
    return _then(
      _ActiveLayerState(
        activeObjects:
            null == activeObjects
                ? _self._activeObjects
                : activeObjects // ignore: cast_nullable_to_non_nullable
                    as Map<int, SpaceObject>,
        dragStartPoint:
            freezed == dragStartPoint
                ? _self.dragStartPoint
                : dragStartPoint // ignore: cast_nullable_to_non_nullable
                    as Offset?,
        originalObject:
            freezed == originalObject
                ? _self.originalObject
                : originalObject // ignore: cast_nullable_to_non_nullable
                    as SpaceObject?,
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
        connectorStartObjectId:
            freezed == connectorStartObjectId
                ? _self.connectorStartObjectId
                : connectorStartObjectId // ignore: cast_nullable_to_non_nullable
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
        connectorHoverObjectId:
            freezed == connectorHoverObjectId
                ? _self.connectorHoverObjectId
                : connectorHoverObjectId // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}
