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
    TResult Function(_ShapeUpdated value)? shapeUpdated,
    TResult Function(_ObjectDeactivated value)? objectDeactivated,
    TResult Function(_OriginalObjectSet value)? originalObjectSet,
    TResult Function(_Clear value)? clear,
    TResult Function(_HandleChanged value)? handleChanged,
    TResult Function(_ConnectorHandleSelected value)? connectorHandleSelected,
    TResult Function(_ConnectorDragStarted value)? connectorDragStarted,
    TResult Function(_ConnectorDragUpdated value)? connectorDragUpdated,
    TResult Function(_ConnectorDragEnded value)? connectorDragEnded,
    TResult Function(_ConnectorHoverChanged value)? connectorHoverChanged,
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
      case _ShapeUpdated() when shapeUpdated != null:
        return shapeUpdated(_that);
      case _ObjectDeactivated() when objectDeactivated != null:
        return objectDeactivated(_that);
      case _OriginalObjectSet() when originalObjectSet != null:
        return originalObjectSet(_that);
      case _Clear() when clear != null:
        return clear(_that);
      case _HandleChanged() when handleChanged != null:
        return handleChanged(_that);
      case _ConnectorHandleSelected() when connectorHandleSelected != null:
        return connectorHandleSelected(_that);
      case _ConnectorDragStarted() when connectorDragStarted != null:
        return connectorDragStarted(_that);
      case _ConnectorDragUpdated() when connectorDragUpdated != null:
        return connectorDragUpdated(_that);
      case _ConnectorDragEnded() when connectorDragEnded != null:
        return connectorDragEnded(_that);
      case _ConnectorHoverChanged() when connectorHoverChanged != null:
        return connectorHoverChanged(_that);
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
    required TResult Function(_ShapeUpdated value) shapeUpdated,
    required TResult Function(_ObjectDeactivated value) objectDeactivated,
    required TResult Function(_OriginalObjectSet value) originalObjectSet,
    required TResult Function(_Clear value) clear,
    required TResult Function(_HandleChanged value) handleChanged,
    required TResult Function(_ConnectorHandleSelected value)
    connectorHandleSelected,
    required TResult Function(_ConnectorDragStarted value) connectorDragStarted,
    required TResult Function(_ConnectorDragUpdated value) connectorDragUpdated,
    required TResult Function(_ConnectorDragEnded value) connectorDragEnded,
    required TResult Function(_ConnectorHoverChanged value)
    connectorHoverChanged,
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
      case _ShapeUpdated():
        return shapeUpdated(_that);
      case _ObjectDeactivated():
        return objectDeactivated(_that);
      case _OriginalObjectSet():
        return originalObjectSet(_that);
      case _Clear():
        return clear(_that);
      case _HandleChanged():
        return handleChanged(_that);
      case _ConnectorHandleSelected():
        return connectorHandleSelected(_that);
      case _ConnectorDragStarted():
        return connectorDragStarted(_that);
      case _ConnectorDragUpdated():
        return connectorDragUpdated(_that);
      case _ConnectorDragEnded():
        return connectorDragEnded(_that);
      case _ConnectorHoverChanged():
        return connectorHoverChanged(_that);
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
    TResult? Function(_ShapeUpdated value)? shapeUpdated,
    TResult? Function(_ObjectDeactivated value)? objectDeactivated,
    TResult? Function(_OriginalObjectSet value)? originalObjectSet,
    TResult? Function(_Clear value)? clear,
    TResult? Function(_HandleChanged value)? handleChanged,
    TResult? Function(_ConnectorHandleSelected value)? connectorHandleSelected,
    TResult? Function(_ConnectorDragStarted value)? connectorDragStarted,
    TResult? Function(_ConnectorDragUpdated value)? connectorDragUpdated,
    TResult? Function(_ConnectorDragEnded value)? connectorDragEnded,
    TResult? Function(_ConnectorHoverChanged value)? connectorHoverChanged,
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
      case _ShapeUpdated() when shapeUpdated != null:
        return shapeUpdated(_that);
      case _ObjectDeactivated() when objectDeactivated != null:
        return objectDeactivated(_that);
      case _OriginalObjectSet() when originalObjectSet != null:
        return originalObjectSet(_that);
      case _Clear() when clear != null:
        return clear(_that);
      case _HandleChanged() when handleChanged != null:
        return handleChanged(_that);
      case _ConnectorHandleSelected() when connectorHandleSelected != null:
        return connectorHandleSelected(_that);
      case _ConnectorDragStarted() when connectorDragStarted != null:
        return connectorDragStarted(_that);
      case _ConnectorDragUpdated() when connectorDragUpdated != null:
        return connectorDragUpdated(_that);
      case _ConnectorDragEnded() when connectorDragEnded != null:
        return connectorDragEnded(_that);
      case _ConnectorHoverChanged() when connectorHoverChanged != null:
        return connectorHoverChanged(_that);
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
    TResult Function(SpaceObject object)? shapeUpdated,
    TResult Function(int objectId)? objectDeactivated,
    TResult Function(SpaceObject? object)? originalObjectSet,
    TResult Function()? clear,
    TResult Function(ResizeHandle? handle)? handleChanged,
    TResult Function(ConnectorHandle? handle)? connectorHandleSelected,
    TResult Function(int? startObjectId, Offset startPoint)?
    connectorDragStarted,
    TResult Function(Offset position)? connectorDragUpdated,
    TResult Function()? connectorDragEnded,
    TResult Function(int? objectId)? connectorHoverChanged,
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
      case _ShapeUpdated() when shapeUpdated != null:
        return shapeUpdated(_that.object);
      case _ObjectDeactivated() when objectDeactivated != null:
        return objectDeactivated(_that.objectId);
      case _OriginalObjectSet() when originalObjectSet != null:
        return originalObjectSet(_that.object);
      case _Clear() when clear != null:
        return clear();
      case _HandleChanged() when handleChanged != null:
        return handleChanged(_that.handle);
      case _ConnectorHandleSelected() when connectorHandleSelected != null:
        return connectorHandleSelected(_that.handle);
      case _ConnectorDragStarted() when connectorDragStarted != null:
        return connectorDragStarted(_that.startObjectId, _that.startPoint);
      case _ConnectorDragUpdated() when connectorDragUpdated != null:
        return connectorDragUpdated(_that.position);
      case _ConnectorDragEnded() when connectorDragEnded != null:
        return connectorDragEnded();
      case _ConnectorHoverChanged() when connectorHoverChanged != null:
        return connectorHoverChanged(_that.objectId);
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
    required TResult Function(SpaceObject object) shapeUpdated,
    required TResult Function(int objectId) objectDeactivated,
    required TResult Function(SpaceObject? object) originalObjectSet,
    required TResult Function() clear,
    required TResult Function(ResizeHandle? handle) handleChanged,
    required TResult Function(ConnectorHandle? handle) connectorHandleSelected,
    required TResult Function(int? startObjectId, Offset startPoint)
    connectorDragStarted,
    required TResult Function(Offset position) connectorDragUpdated,
    required TResult Function() connectorDragEnded,
    required TResult Function(int? objectId) connectorHoverChanged,
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
      case _ShapeUpdated():
        return shapeUpdated(_that.object);
      case _ObjectDeactivated():
        return objectDeactivated(_that.objectId);
      case _OriginalObjectSet():
        return originalObjectSet(_that.object);
      case _Clear():
        return clear();
      case _HandleChanged():
        return handleChanged(_that.handle);
      case _ConnectorHandleSelected():
        return connectorHandleSelected(_that.handle);
      case _ConnectorDragStarted():
        return connectorDragStarted(_that.startObjectId, _that.startPoint);
      case _ConnectorDragUpdated():
        return connectorDragUpdated(_that.position);
      case _ConnectorDragEnded():
        return connectorDragEnded();
      case _ConnectorHoverChanged():
        return connectorHoverChanged(_that.objectId);
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
    TResult? Function(SpaceObject object)? shapeUpdated,
    TResult? Function(int objectId)? objectDeactivated,
    TResult? Function(SpaceObject? object)? originalObjectSet,
    TResult? Function()? clear,
    TResult? Function(ResizeHandle? handle)? handleChanged,
    TResult? Function(ConnectorHandle? handle)? connectorHandleSelected,
    TResult? Function(int? startObjectId, Offset startPoint)?
    connectorDragStarted,
    TResult? Function(Offset position)? connectorDragUpdated,
    TResult? Function()? connectorDragEnded,
    TResult? Function(int? objectId)? connectorHoverChanged,
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
      case _ShapeUpdated() when shapeUpdated != null:
        return shapeUpdated(_that.object);
      case _ObjectDeactivated() when objectDeactivated != null:
        return objectDeactivated(_that.objectId);
      case _OriginalObjectSet() when originalObjectSet != null:
        return originalObjectSet(_that.object);
      case _Clear() when clear != null:
        return clear();
      case _HandleChanged() when handleChanged != null:
        return handleChanged(_that.handle);
      case _ConnectorHandleSelected() when connectorHandleSelected != null:
        return connectorHandleSelected(_that.handle);
      case _ConnectorDragStarted() when connectorDragStarted != null:
        return connectorDragStarted(_that.startObjectId, _that.startPoint);
      case _ConnectorDragUpdated() when connectorDragUpdated != null:
        return connectorDragUpdated(_that.position);
      case _ConnectorDragEnded() when connectorDragEnded != null:
        return connectorDragEnded();
      case _ConnectorHoverChanged() when connectorHoverChanged != null:
        return connectorHoverChanged(_that.objectId);
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

class _ShapeUpdated implements ActiveLayerEvent {
  const _ShapeUpdated(this.object);

  final SpaceObject object;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShapeUpdatedCopyWith<_ShapeUpdated> get copyWith =>
      __$ShapeUpdatedCopyWithImpl<_ShapeUpdated>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShapeUpdated &&
            (identical(other.object, object) || other.object == object));
  }

  @override
  int get hashCode => Object.hash(runtimeType, object);

  @override
  String toString() {
    return 'ActiveLayerEvent.shapeUpdated(object: $object)';
  }
}

/// @nodoc
abstract mixin class _$ShapeUpdatedCopyWith<$Res>
    implements $ActiveLayerEventCopyWith<$Res> {
  factory _$ShapeUpdatedCopyWith(
    _ShapeUpdated value,
    $Res Function(_ShapeUpdated) _then,
  ) = __$ShapeUpdatedCopyWithImpl;
  @useResult
  $Res call({SpaceObject object});
}

/// @nodoc
class __$ShapeUpdatedCopyWithImpl<$Res>
    implements _$ShapeUpdatedCopyWith<$Res> {
  __$ShapeUpdatedCopyWithImpl(this._self, this._then);

  final _ShapeUpdated _self;
  final $Res Function(_ShapeUpdated) _then;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? object = null}) {
    return _then(
      _ShapeUpdated(
        null == object
            ? _self.object
            : object // ignore: cast_nullable_to_non_nullable
                as SpaceObject,
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

class _OriginalObjectSet implements ActiveLayerEvent {
  const _OriginalObjectSet(this.object);

  final SpaceObject? object;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OriginalObjectSetCopyWith<_OriginalObjectSet> get copyWith =>
      __$OriginalObjectSetCopyWithImpl<_OriginalObjectSet>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OriginalObjectSet &&
            (identical(other.object, object) || other.object == object));
  }

  @override
  int get hashCode => Object.hash(runtimeType, object);

  @override
  String toString() {
    return 'ActiveLayerEvent.originalObjectSet(object: $object)';
  }
}

/// @nodoc
abstract mixin class _$OriginalObjectSetCopyWith<$Res>
    implements $ActiveLayerEventCopyWith<$Res> {
  factory _$OriginalObjectSetCopyWith(
    _OriginalObjectSet value,
    $Res Function(_OriginalObjectSet) _then,
  ) = __$OriginalObjectSetCopyWithImpl;
  @useResult
  $Res call({SpaceObject? object});
}

/// @nodoc
class __$OriginalObjectSetCopyWithImpl<$Res>
    implements _$OriginalObjectSetCopyWith<$Res> {
  __$OriginalObjectSetCopyWithImpl(this._self, this._then);

  final _OriginalObjectSet _self;
  final $Res Function(_OriginalObjectSet) _then;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? object = freezed}) {
    return _then(
      _OriginalObjectSet(
        freezed == object
            ? _self.object
            : object // ignore: cast_nullable_to_non_nullable
                as SpaceObject?,
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

/// @nodoc

class _HandleChanged implements ActiveLayerEvent {
  const _HandleChanged(this.handle);

  final ResizeHandle? handle;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HandleChangedCopyWith<_HandleChanged> get copyWith =>
      __$HandleChangedCopyWithImpl<_HandleChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HandleChanged &&
            (identical(other.handle, handle) || other.handle == handle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handle);

  @override
  String toString() {
    return 'ActiveLayerEvent.handleChanged(handle: $handle)';
  }
}

/// @nodoc
abstract mixin class _$HandleChangedCopyWith<$Res>
    implements $ActiveLayerEventCopyWith<$Res> {
  factory _$HandleChangedCopyWith(
    _HandleChanged value,
    $Res Function(_HandleChanged) _then,
  ) = __$HandleChangedCopyWithImpl;
  @useResult
  $Res call({ResizeHandle? handle});
}

/// @nodoc
class __$HandleChangedCopyWithImpl<$Res>
    implements _$HandleChangedCopyWith<$Res> {
  __$HandleChangedCopyWithImpl(this._self, this._then);

  final _HandleChanged _self;
  final $Res Function(_HandleChanged) _then;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? handle = freezed}) {
    return _then(
      _HandleChanged(
        freezed == handle
            ? _self.handle
            : handle // ignore: cast_nullable_to_non_nullable
                as ResizeHandle?,
      ),
    );
  }
}

/// @nodoc

class _ConnectorHandleSelected implements ActiveLayerEvent {
  const _ConnectorHandleSelected(this.handle);

  final ConnectorHandle? handle;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectorHandleSelectedCopyWith<_ConnectorHandleSelected> get copyWith =>
      __$ConnectorHandleSelectedCopyWithImpl<_ConnectorHandleSelected>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectorHandleSelected &&
            (identical(other.handle, handle) || other.handle == handle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handle);

  @override
  String toString() {
    return 'ActiveLayerEvent.connectorHandleSelected(handle: $handle)';
  }
}

/// @nodoc
abstract mixin class _$ConnectorHandleSelectedCopyWith<$Res>
    implements $ActiveLayerEventCopyWith<$Res> {
  factory _$ConnectorHandleSelectedCopyWith(
    _ConnectorHandleSelected value,
    $Res Function(_ConnectorHandleSelected) _then,
  ) = __$ConnectorHandleSelectedCopyWithImpl;
  @useResult
  $Res call({ConnectorHandle? handle});
}

/// @nodoc
class __$ConnectorHandleSelectedCopyWithImpl<$Res>
    implements _$ConnectorHandleSelectedCopyWith<$Res> {
  __$ConnectorHandleSelectedCopyWithImpl(this._self, this._then);

  final _ConnectorHandleSelected _self;
  final $Res Function(_ConnectorHandleSelected) _then;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? handle = freezed}) {
    return _then(
      _ConnectorHandleSelected(
        freezed == handle
            ? _self.handle
            : handle // ignore: cast_nullable_to_non_nullable
                as ConnectorHandle?,
      ),
    );
  }
}

/// @nodoc

class _ConnectorDragStarted implements ActiveLayerEvent {
  const _ConnectorDragStarted({this.startObjectId, required this.startPoint});

  final int? startObjectId;
  final Offset startPoint;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectorDragStartedCopyWith<_ConnectorDragStarted> get copyWith =>
      __$ConnectorDragStartedCopyWithImpl<_ConnectorDragStarted>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectorDragStarted &&
            (identical(other.startObjectId, startObjectId) ||
                other.startObjectId == startObjectId) &&
            (identical(other.startPoint, startPoint) ||
                other.startPoint == startPoint));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startObjectId, startPoint);

  @override
  String toString() {
    return 'ActiveLayerEvent.connectorDragStarted(startObjectId: $startObjectId, startPoint: $startPoint)';
  }
}

/// @nodoc
abstract mixin class _$ConnectorDragStartedCopyWith<$Res>
    implements $ActiveLayerEventCopyWith<$Res> {
  factory _$ConnectorDragStartedCopyWith(
    _ConnectorDragStarted value,
    $Res Function(_ConnectorDragStarted) _then,
  ) = __$ConnectorDragStartedCopyWithImpl;
  @useResult
  $Res call({int? startObjectId, Offset startPoint});
}

/// @nodoc
class __$ConnectorDragStartedCopyWithImpl<$Res>
    implements _$ConnectorDragStartedCopyWith<$Res> {
  __$ConnectorDragStartedCopyWithImpl(this._self, this._then);

  final _ConnectorDragStarted _self;
  final $Res Function(_ConnectorDragStarted) _then;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? startObjectId = freezed, Object? startPoint = null}) {
    return _then(
      _ConnectorDragStarted(
        startObjectId:
            freezed == startObjectId
                ? _self.startObjectId
                : startObjectId // ignore: cast_nullable_to_non_nullable
                    as int?,
        startPoint:
            null == startPoint
                ? _self.startPoint
                : startPoint // ignore: cast_nullable_to_non_nullable
                    as Offset,
      ),
    );
  }
}

/// @nodoc

class _ConnectorDragUpdated implements ActiveLayerEvent {
  const _ConnectorDragUpdated(this.position);

  final Offset position;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectorDragUpdatedCopyWith<_ConnectorDragUpdated> get copyWith =>
      __$ConnectorDragUpdatedCopyWithImpl<_ConnectorDragUpdated>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectorDragUpdated &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, position);

  @override
  String toString() {
    return 'ActiveLayerEvent.connectorDragUpdated(position: $position)';
  }
}

/// @nodoc
abstract mixin class _$ConnectorDragUpdatedCopyWith<$Res>
    implements $ActiveLayerEventCopyWith<$Res> {
  factory _$ConnectorDragUpdatedCopyWith(
    _ConnectorDragUpdated value,
    $Res Function(_ConnectorDragUpdated) _then,
  ) = __$ConnectorDragUpdatedCopyWithImpl;
  @useResult
  $Res call({Offset position});
}

/// @nodoc
class __$ConnectorDragUpdatedCopyWithImpl<$Res>
    implements _$ConnectorDragUpdatedCopyWith<$Res> {
  __$ConnectorDragUpdatedCopyWithImpl(this._self, this._then);

  final _ConnectorDragUpdated _self;
  final $Res Function(_ConnectorDragUpdated) _then;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? position = null}) {
    return _then(
      _ConnectorDragUpdated(
        null == position
            ? _self.position
            : position // ignore: cast_nullable_to_non_nullable
                as Offset,
      ),
    );
  }
}

/// @nodoc

class _ConnectorDragEnded implements ActiveLayerEvent {
  const _ConnectorDragEnded();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ConnectorDragEnded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ActiveLayerEvent.connectorDragEnded()';
  }
}

/// @nodoc
class _$ConnectorDragEndedCopyWith<$Res>
    implements $ActiveLayerEventCopyWith<$Res> {
  _$ConnectorDragEndedCopyWith(
    _ConnectorDragEnded _,
    $Res Function(_ConnectorDragEnded) __,
  );
}

/// @nodoc
class __$ConnectorDragEndedCopyWithImpl<$Res>
    implements _$ConnectorDragEndedCopyWith<$Res> {
  __$ConnectorDragEndedCopyWithImpl(this._self, this._then);

  final _ConnectorDragEnded _self;
  final $Res Function(_ConnectorDragEnded) _then;
}

/// @nodoc

class _ConnectorHoverChanged implements ActiveLayerEvent {
  const _ConnectorHoverChanged(this.objectId);

  final int? objectId;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectorHoverChangedCopyWith<_ConnectorHoverChanged> get copyWith =>
      __$ConnectorHoverChangedCopyWithImpl<_ConnectorHoverChanged>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectorHoverChanged &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, objectId);

  @override
  String toString() {
    return 'ActiveLayerEvent.connectorHoverChanged(objectId: $objectId)';
  }
}

/// @nodoc
abstract mixin class _$ConnectorHoverChangedCopyWith<$Res>
    implements $ActiveLayerEventCopyWith<$Res> {
  factory _$ConnectorHoverChangedCopyWith(
    _ConnectorHoverChanged value,
    $Res Function(_ConnectorHoverChanged) _then,
  ) = __$ConnectorHoverChangedCopyWithImpl;
  @useResult
  $Res call({int? objectId});
}

/// @nodoc
class __$ConnectorHoverChangedCopyWithImpl<$Res>
    implements _$ConnectorHoverChangedCopyWith<$Res> {
  __$ConnectorHoverChangedCopyWithImpl(this._self, this._then);

  final _ConnectorHoverChanged _self;
  final $Res Function(_ConnectorHoverChanged) _then;

  /// Create a copy of ActiveLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? objectId = freezed}) {
    return _then(
      _ConnectorHoverChanged(
        freezed == objectId
            ? _self.objectId
            : objectId // ignore: cast_nullable_to_non_nullable
                as int?,
      ),
    );
  }
}
