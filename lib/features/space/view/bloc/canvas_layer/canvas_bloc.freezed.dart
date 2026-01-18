// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'canvas_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CanvasEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CanvasEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CanvasEvent()';
  }
}

/// @nodoc
class $CanvasEventCopyWith<$Res> {
  $CanvasEventCopyWith(CanvasEvent _, $Res Function(CanvasEvent) __);
}

/// Adds pattern-matching-related methods to [CanvasEvent].
extension CanvasEventPatterns on CanvasEvent {
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
    TResult Function(_Started value)? started,
    TResult Function(_TransformUpdated value)? transformUpdated,
    TResult Function(_ObjectsUpdated value)? objectsUpdated,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _TransformUpdated() when transformUpdated != null:
        return transformUpdated(_that);
      case _ObjectsUpdated() when objectsUpdated != null:
        return objectsUpdated(_that);
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
    required TResult Function(_Started value) started,
    required TResult Function(_TransformUpdated value) transformUpdated,
    required TResult Function(_ObjectsUpdated value) objectsUpdated,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started(_that);
      case _TransformUpdated():
        return transformUpdated(_that);
      case _ObjectsUpdated():
        return objectsUpdated(_that);
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
    TResult? Function(_Started value)? started,
    TResult? Function(_TransformUpdated value)? transformUpdated,
    TResult? Function(_ObjectsUpdated value)? objectsUpdated,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _TransformUpdated() when transformUpdated != null:
        return transformUpdated(_that);
      case _ObjectsUpdated() when objectsUpdated != null:
        return objectsUpdated(_that);
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
    TResult Function()? started,
    TResult Function(Offset offset, double scale)? transformUpdated,
    TResult Function(Map<int, SpaceObject> objects)? objectsUpdated,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _TransformUpdated() when transformUpdated != null:
        return transformUpdated(_that.offset, _that.scale);
      case _ObjectsUpdated() when objectsUpdated != null:
        return objectsUpdated(_that.objects);
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
    required TResult Function() started,
    required TResult Function(Offset offset, double scale) transformUpdated,
    required TResult Function(Map<int, SpaceObject> objects) objectsUpdated,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started();
      case _TransformUpdated():
        return transformUpdated(_that.offset, _that.scale);
      case _ObjectsUpdated():
        return objectsUpdated(_that.objects);
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
    TResult? Function()? started,
    TResult? Function(Offset offset, double scale)? transformUpdated,
    TResult? Function(Map<int, SpaceObject> objects)? objectsUpdated,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _TransformUpdated() when transformUpdated != null:
        return transformUpdated(_that.offset, _that.scale);
      case _ObjectsUpdated() when objectsUpdated != null:
        return objectsUpdated(_that.objects);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Started implements CanvasEvent {
  const _Started();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CanvasEvent.started()';
  }
}

/// @nodoc
class _$StartedCopyWith<$Res> implements $CanvasEventCopyWith<$Res> {
  _$StartedCopyWith(_Started _, $Res Function(_Started) __);
}

/// @nodoc
class __$StartedCopyWithImpl<$Res> implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;
}

/// @nodoc

class _TransformUpdated implements CanvasEvent {
  const _TransformUpdated({required this.offset, required this.scale});

  final Offset offset;
  final double scale;

  /// Create a copy of CanvasEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransformUpdatedCopyWith<_TransformUpdated> get copyWith =>
      __$TransformUpdatedCopyWithImpl<_TransformUpdated>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransformUpdated &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.scale, scale) || other.scale == scale));
  }

  @override
  int get hashCode => Object.hash(runtimeType, offset, scale);

  @override
  String toString() {
    return 'CanvasEvent.transformUpdated(offset: $offset, scale: $scale)';
  }
}

/// @nodoc
abstract mixin class _$TransformUpdatedCopyWith<$Res>
    implements $CanvasEventCopyWith<$Res> {
  factory _$TransformUpdatedCopyWith(
    _TransformUpdated value,
    $Res Function(_TransformUpdated) _then,
  ) = __$TransformUpdatedCopyWithImpl;
  @useResult
  $Res call({Offset offset, double scale});
}

/// @nodoc
class __$TransformUpdatedCopyWithImpl<$Res>
    implements _$TransformUpdatedCopyWith<$Res> {
  __$TransformUpdatedCopyWithImpl(this._self, this._then);

  final _TransformUpdated _self;
  final $Res Function(_TransformUpdated) _then;

  /// Create a copy of CanvasEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? offset = null, Object? scale = null}) {
    return _then(
      _TransformUpdated(
        offset:
            null == offset
                ? _self.offset
                : offset // ignore: cast_nullable_to_non_nullable
                    as Offset,
        scale:
            null == scale
                ? _self.scale
                : scale // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc

class _ObjectsUpdated implements CanvasEvent {
  const _ObjectsUpdated(final Map<int, SpaceObject> objects)
    : _objects = objects;

  final Map<int, SpaceObject> _objects;
  Map<int, SpaceObject> get objects {
    if (_objects is EqualUnmodifiableMapView) return _objects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_objects);
  }

  /// Create a copy of CanvasEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ObjectsUpdatedCopyWith<_ObjectsUpdated> get copyWith =>
      __$ObjectsUpdatedCopyWithImpl<_ObjectsUpdated>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ObjectsUpdated &&
            const DeepCollectionEquality().equals(other._objects, _objects));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_objects));

  @override
  String toString() {
    return 'CanvasEvent.objectsUpdated(objects: $objects)';
  }
}

/// @nodoc
abstract mixin class _$ObjectsUpdatedCopyWith<$Res>
    implements $CanvasEventCopyWith<$Res> {
  factory _$ObjectsUpdatedCopyWith(
    _ObjectsUpdated value,
    $Res Function(_ObjectsUpdated) _then,
  ) = __$ObjectsUpdatedCopyWithImpl;
  @useResult
  $Res call({Map<int, SpaceObject> objects});
}

/// @nodoc
class __$ObjectsUpdatedCopyWithImpl<$Res>
    implements _$ObjectsUpdatedCopyWith<$Res> {
  __$ObjectsUpdatedCopyWithImpl(this._self, this._then);

  final _ObjectsUpdated _self;
  final $Res Function(_ObjectsUpdated) _then;

  /// Create a copy of CanvasEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? objects = null}) {
    return _then(
      _ObjectsUpdated(
        null == objects
            ? _self._objects
            : objects // ignore: cast_nullable_to_non_nullable
                as Map<int, SpaceObject>,
      ),
    );
  }
}

/// @nodoc
mixin _$CanvasState {
  Map<int, SpaceObject> get objects;
  Offset get offset;
  double get scale;

  /// Create a copy of CanvasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CanvasStateCopyWith<CanvasState> get copyWith =>
      _$CanvasStateCopyWithImpl<CanvasState>(this as CanvasState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CanvasState &&
            const DeepCollectionEquality().equals(other.objects, objects) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.scale, scale) || other.scale == scale));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(objects),
    offset,
    scale,
  );

  @override
  String toString() {
    return 'CanvasState(objects: $objects, offset: $offset, scale: $scale)';
  }
}

/// @nodoc
abstract mixin class $CanvasStateCopyWith<$Res> {
  factory $CanvasStateCopyWith(
    CanvasState value,
    $Res Function(CanvasState) _then,
  ) = _$CanvasStateCopyWithImpl;
  @useResult
  $Res call({Map<int, SpaceObject> objects, Offset offset, double scale});
}

/// @nodoc
class _$CanvasStateCopyWithImpl<$Res> implements $CanvasStateCopyWith<$Res> {
  _$CanvasStateCopyWithImpl(this._self, this._then);

  final CanvasState _self;
  final $Res Function(CanvasState) _then;

  /// Create a copy of CanvasState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objects = null,
    Object? offset = null,
    Object? scale = null,
  }) {
    return _then(
      _self.copyWith(
        objects:
            null == objects
                ? _self.objects
                : objects // ignore: cast_nullable_to_non_nullable
                    as Map<int, SpaceObject>,
        offset:
            null == offset
                ? _self.offset
                : offset // ignore: cast_nullable_to_non_nullable
                    as Offset,
        scale:
            null == scale
                ? _self.scale
                : scale // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [CanvasState].
extension CanvasStatePatterns on CanvasState {
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
    TResult Function(_CanvasState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CanvasState() when $default != null:
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
    TResult Function(_CanvasState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CanvasState():
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
    TResult? Function(_CanvasState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CanvasState() when $default != null:
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
      Map<int, SpaceObject> objects,
      Offset offset,
      double scale,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CanvasState() when $default != null:
        return $default(_that.objects, _that.offset, _that.scale);
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
    TResult Function(Map<int, SpaceObject> objects, Offset offset, double scale)
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CanvasState():
        return $default(_that.objects, _that.offset, _that.scale);
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
      Map<int, SpaceObject> objects,
      Offset offset,
      double scale,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CanvasState() when $default != null:
        return $default(_that.objects, _that.offset, _that.scale);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CanvasState implements CanvasState {
  const _CanvasState({
    final Map<int, SpaceObject> objects = const {},
    this.offset = Offset.zero,
    this.scale = 1.0,
  }) : _objects = objects;

  final Map<int, SpaceObject> _objects;
  @override
  @JsonKey()
  Map<int, SpaceObject> get objects {
    if (_objects is EqualUnmodifiableMapView) return _objects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_objects);
  }

  @override
  @JsonKey()
  final Offset offset;
  @override
  @JsonKey()
  final double scale;

  /// Create a copy of CanvasState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CanvasStateCopyWith<_CanvasState> get copyWith =>
      __$CanvasStateCopyWithImpl<_CanvasState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CanvasState &&
            const DeepCollectionEquality().equals(other._objects, _objects) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.scale, scale) || other.scale == scale));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_objects),
    offset,
    scale,
  );

  @override
  String toString() {
    return 'CanvasState(objects: $objects, offset: $offset, scale: $scale)';
  }
}

/// @nodoc
abstract mixin class _$CanvasStateCopyWith<$Res>
    implements $CanvasStateCopyWith<$Res> {
  factory _$CanvasStateCopyWith(
    _CanvasState value,
    $Res Function(_CanvasState) _then,
  ) = __$CanvasStateCopyWithImpl;
  @override
  @useResult
  $Res call({Map<int, SpaceObject> objects, Offset offset, double scale});
}

/// @nodoc
class __$CanvasStateCopyWithImpl<$Res> implements _$CanvasStateCopyWith<$Res> {
  __$CanvasStateCopyWithImpl(this._self, this._then);

  final _CanvasState _self;
  final $Res Function(_CanvasState) _then;

  /// Create a copy of CanvasState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? objects = null,
    Object? offset = null,
    Object? scale = null,
  }) {
    return _then(
      _CanvasState(
        objects:
            null == objects
                ? _self._objects
                : objects // ignore: cast_nullable_to_non_nullable
                    as Map<int, SpaceObject>,
        offset:
            null == offset
                ? _self.offset
                : offset // ignore: cast_nullable_to_non_nullable
                    as Offset,
        scale:
            null == scale
                ? _self.scale
                : scale // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}
