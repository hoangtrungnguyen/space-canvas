// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_layer_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActiveLayerEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ActiveLayerEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ActiveLayerEvent()';
  }
}

/// @nodoc
class $ActiveLayerEventCopyWith<$Res> {
  $ActiveLayerEventCopyWith(
    ActiveLayerEvent _,
    $Res Function(ActiveLayerEvent) __,
  );
}

/// Adds pattern-matching-related methods to [ActiveLayerEvent].
extension ActiveLayerEventPatterns on ActiveLayerEvent {
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
    TResult Function(_ObjectActivated value)? objectActivated,
    TResult Function(_ObjectChanged value)? objectChanged,
    TResult Function(_InteractionStarted value)? interactionStarted,
    TResult Function(_ObjectDeactivated value)? objectDeactivated,
    TResult Function(_Clear value)? clear,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _ObjectActivated() when objectActivated != null:
        return objectActivated(_that);
      case _ObjectChanged() when objectChanged != null:
        return objectChanged(_that);
      case _InteractionStarted() when interactionStarted != null:
        return interactionStarted(_that);
      case _ObjectDeactivated() when objectDeactivated != null:
        return objectDeactivated(_that);
      case _Clear() when clear != null:
        return clear(_that);
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
    required TResult Function(_ObjectActivated value) objectActivated,
    required TResult Function(_ObjectChanged value) objectChanged,
    required TResult Function(_InteractionStarted value) interactionStarted,
    required TResult Function(_ObjectDeactivated value) objectDeactivated,
    required TResult Function(_Clear value) clear,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started(_that);
      case _ObjectActivated():
        return objectActivated(_that);
      case _ObjectChanged():
        return objectChanged(_that);
      case _InteractionStarted():
        return interactionStarted(_that);
      case _ObjectDeactivated():
        return objectDeactivated(_that);
      case _Clear():
        return clear(_that);
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
    TResult? Function(_ObjectActivated value)? objectActivated,
    TResult? Function(_ObjectChanged value)? objectChanged,
    TResult? Function(_InteractionStarted value)? interactionStarted,
    TResult? Function(_ObjectDeactivated value)? objectDeactivated,
    TResult? Function(_Clear value)? clear,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _ObjectActivated() when objectActivated != null:
        return objectActivated(_that);
      case _ObjectChanged() when objectChanged != null:
        return objectChanged(_that);
      case _InteractionStarted() when interactionStarted != null:
        return interactionStarted(_that);
      case _ObjectDeactivated() when objectDeactivated != null:
        return objectDeactivated(_that);
      case _Clear() when clear != null:
        return clear(_that);
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
    TResult Function(SpaceObject object)? objectActivated,
    TResult Function(SpaceObject object)? objectChanged,
    TResult Function(SpaceObject object, Offset point)? interactionStarted,
    TResult Function(int objectId)? objectDeactivated,
    TResult Function()? clear,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _ObjectActivated() when objectActivated != null:
        return objectActivated(_that.object);
      case _ObjectChanged() when objectChanged != null:
        return objectChanged(_that.object);
      case _InteractionStarted() when interactionStarted != null:
        return interactionStarted(_that.object, _that.point);
      case _ObjectDeactivated() when objectDeactivated != null:
        return objectDeactivated(_that.objectId);
      case _Clear() when clear != null:
        return clear();
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
    required TResult Function(SpaceObject object) objectActivated,
    required TResult Function(SpaceObject object) objectChanged,
    required TResult Function(SpaceObject object, Offset point)
    interactionStarted,
    required TResult Function(int objectId) objectDeactivated,
    required TResult Function() clear,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started();
      case _ObjectActivated():
        return objectActivated(_that.object);
      case _ObjectChanged():
        return objectChanged(_that.object);
      case _InteractionStarted():
        return interactionStarted(_that.object, _that.point);
      case _ObjectDeactivated():
        return objectDeactivated(_that.objectId);
      case _Clear():
        return clear();
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
    TResult? Function(SpaceObject object)? objectActivated,
    TResult? Function(SpaceObject object)? objectChanged,
    TResult? Function(SpaceObject object, Offset point)? interactionStarted,
    TResult? Function(int objectId)? objectDeactivated,
    TResult? Function()? clear,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _ObjectActivated() when objectActivated != null:
        return objectActivated(_that.object);
      case _ObjectChanged() when objectChanged != null:
        return objectChanged(_that.object);
      case _InteractionStarted() when interactionStarted != null:
        return interactionStarted(_that.object, _that.point);
      case _ObjectDeactivated() when objectDeactivated != null:
        return objectDeactivated(_that.objectId);
      case _Clear() when clear != null:
        return clear();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Started implements ActiveLayerEvent {
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
    return 'ActiveLayerEvent.started()';
  }
}

/// @nodoc
class _$StartedCopyWith<$Res> implements $ActiveLayerEventCopyWith<$Res> {
  _$StartedCopyWith(_Started _, $Res Function(_Started) __);
}

/// @nodoc
class __$StartedCopyWithImpl<$Res> implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;
}

/// @nodoc

class _ObjectActivated implements ActiveLayerEvent {
  const _ObjectActivated(this.object);

  final SpaceObject object;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ObjectActivatedCopyWith<_ObjectActivated> get copyWith =>
      __$ObjectActivatedCopyWithImpl<_ObjectActivated>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ObjectActivated &&
            (identical(other.object, object) || other.object == object));
  }

  @override
  int get hashCode => Object.hash(runtimeType, object);

  @override
  String toString() {
    return 'ActiveLayerEvent.objectActivated(object: $object)';
  }
}

/// @nodoc
abstract mixin class _$ObjectActivatedCopyWith<$Res>
    implements $ActiveLayerEventCopyWith<$Res> {
  factory _$ObjectActivatedCopyWith(
    _ObjectActivated value,
    $Res Function(_ObjectActivated) _then,
  ) = __$ObjectActivatedCopyWithImpl;
  @useResult
  $Res call({SpaceObject object});
}

/// @nodoc
class __$ObjectActivatedCopyWithImpl<$Res>
    implements _$ObjectActivatedCopyWith<$Res> {
  __$ObjectActivatedCopyWithImpl(this._self, this._then);

  final _ObjectActivated _self;
  final $Res Function(_ObjectActivated) _then;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? object = null}) {
    return _then(
      _ObjectActivated(
        null == object
            ? _self.object
            : object // ignore: cast_nullable_to_non_nullable
                as SpaceObject,
      ),
    );
  }
}

/// @nodoc

class _ObjectChanged implements ActiveLayerEvent {
  const _ObjectChanged(this.object);

  final SpaceObject object;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ObjectChangedCopyWith<_ObjectChanged> get copyWith =>
      __$ObjectChangedCopyWithImpl<_ObjectChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ObjectChanged &&
            (identical(other.object, object) || other.object == object));
  }

  @override
  int get hashCode => Object.hash(runtimeType, object);

  @override
  String toString() {
    return 'ActiveLayerEvent.objectChanged(object: $object)';
  }
}

/// @nodoc
abstract mixin class _$ObjectChangedCopyWith<$Res>
    implements $ActiveLayerEventCopyWith<$Res> {
  factory _$ObjectChangedCopyWith(
    _ObjectChanged value,
    $Res Function(_ObjectChanged) _then,
  ) = __$ObjectChangedCopyWithImpl;
  @useResult
  $Res call({SpaceObject object});
}

/// @nodoc
class __$ObjectChangedCopyWithImpl<$Res>
    implements _$ObjectChangedCopyWith<$Res> {
  __$ObjectChangedCopyWithImpl(this._self, this._then);

  final _ObjectChanged _self;
  final $Res Function(_ObjectChanged) _then;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? object = null}) {
    return _then(
      _ObjectChanged(
        null == object
            ? _self.object
            : object // ignore: cast_nullable_to_non_nullable
                as SpaceObject,
      ),
    );
  }
}

/// @nodoc

class _InteractionStarted implements ActiveLayerEvent {
  const _InteractionStarted({required this.object, required this.point});

  final SpaceObject object;
  final Offset point;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InteractionStartedCopyWith<_InteractionStarted> get copyWith =>
      __$InteractionStartedCopyWithImpl<_InteractionStarted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InteractionStarted &&
            (identical(other.object, object) || other.object == object) &&
            (identical(other.point, point) || other.point == point));
  }

  @override
  int get hashCode => Object.hash(runtimeType, object, point);

  @override
  String toString() {
    return 'ActiveLayerEvent.interactionStarted(object: $object, point: $point)';
  }
}

/// @nodoc
abstract mixin class _$InteractionStartedCopyWith<$Res>
    implements $ActiveLayerEventCopyWith<$Res> {
  factory _$InteractionStartedCopyWith(
    _InteractionStarted value,
    $Res Function(_InteractionStarted) _then,
  ) = __$InteractionStartedCopyWithImpl;
  @useResult
  $Res call({SpaceObject object, Offset point});
}

/// @nodoc
class __$InteractionStartedCopyWithImpl<$Res>
    implements _$InteractionStartedCopyWith<$Res> {
  __$InteractionStartedCopyWithImpl(this._self, this._then);

  final _InteractionStarted _self;
  final $Res Function(_InteractionStarted) _then;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? object = null, Object? point = null}) {
    return _then(
      _InteractionStarted(
        object:
            null == object
                ? _self.object
                : object // ignore: cast_nullable_to_non_nullable
                    as SpaceObject,
        point:
            null == point
                ? _self.point
                : point // ignore: cast_nullable_to_non_nullable
                    as Offset,
      ),
    );
  }
}

/// @nodoc

class _ObjectDeactivated implements ActiveLayerEvent {
  const _ObjectDeactivated(this.objectId);

  final int objectId;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ObjectDeactivatedCopyWith<_ObjectDeactivated> get copyWith =>
      __$ObjectDeactivatedCopyWithImpl<_ObjectDeactivated>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ObjectDeactivated &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, objectId);

  @override
  String toString() {
    return 'ActiveLayerEvent.objectDeactivated(objectId: $objectId)';
  }
}

/// @nodoc
abstract mixin class _$ObjectDeactivatedCopyWith<$Res>
    implements $ActiveLayerEventCopyWith<$Res> {
  factory _$ObjectDeactivatedCopyWith(
    _ObjectDeactivated value,
    $Res Function(_ObjectDeactivated) _then,
  ) = __$ObjectDeactivatedCopyWithImpl;
  @useResult
  $Res call({int objectId});
}

/// @nodoc
class __$ObjectDeactivatedCopyWithImpl<$Res>
    implements _$ObjectDeactivatedCopyWith<$Res> {
  __$ObjectDeactivatedCopyWithImpl(this._self, this._then);

  final _ObjectDeactivated _self;
  final $Res Function(_ObjectDeactivated) _then;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? objectId = null}) {
    return _then(
      _ObjectDeactivated(
        null == objectId
            ? _self.objectId
            : objectId // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _Clear implements ActiveLayerEvent {
  const _Clear();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Clear);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ActiveLayerEvent.clear()';
  }
}

/// @nodoc
class _$ClearCopyWith<$Res> implements $ActiveLayerEventCopyWith<$Res> {
  _$ClearCopyWith(_Clear _, $Res Function(_Clear) __);
}

/// @nodoc
class __$ClearCopyWithImpl<$Res> implements _$ClearCopyWith<$Res> {
  __$ClearCopyWithImpl(this._self, this._then);

  final _Clear _self;
  final $Res Function(_Clear) _then;
}
