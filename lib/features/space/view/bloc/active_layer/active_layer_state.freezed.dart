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
                other.dragStartPoint == dragStartPoint));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(activeObjects),
    dragStartPoint,
  );

  @override
  String toString() {
    return 'ActiveLayerState(activeObjects: $activeObjects, dragStartPoint: $dragStartPoint)';
  }
}

/// @nodoc
abstract mixin class $ActiveLayerStateCopyWith<$Res> {
  factory $ActiveLayerStateCopyWith(
    ActiveLayerState value,
    $Res Function(ActiveLayerState) _then,
  ) = _$ActiveLayerStateCopyWithImpl;
  @useResult
  $Res call({Map<int, SpaceObject> activeObjects, Offset? dragStartPoint});
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
  $Res call({Object? activeObjects = null, Object? dragStartPoint = freezed}) {
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
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ActiveLayerState() when $default != null:
        return $default(_that.activeObjects, _that.dragStartPoint);
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
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActiveLayerState():
        return $default(_that.activeObjects, _that.dragStartPoint);
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
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActiveLayerState() when $default != null:
        return $default(_that.activeObjects, _that.dragStartPoint);
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
                other.dragStartPoint == dragStartPoint));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_activeObjects),
    dragStartPoint,
  );

  @override
  String toString() {
    return 'ActiveLayerState(activeObjects: $activeObjects, dragStartPoint: $dragStartPoint)';
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
  $Res call({Map<int, SpaceObject> activeObjects, Offset? dragStartPoint});
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
  $Res call({Object? activeObjects = null, Object? dragStartPoint = freezed}) {
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
      ),
    );
  }
}
