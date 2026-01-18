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
    TResult Function(_ObjectDragged value)? objectDragged,
    TResult Function(_AddObject value)? addObject,
    TResult Function(_RemoveObject value)? removeObject,
    TResult Function(_ShapeAdded value)? shapeAdded,
    TResult Function(_ShapeSelected value)? shapeSelected,
    TResult Function(_TextAdded value)? textAdded,
    TResult Function(_ImageAdded value)? imageAdded,
    TResult Function(_ConnectorAdded value)? connectorAdded,
    TResult Function(_ObjectSelected value)? objectSelected,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialize != null:
        return initialize(_that);
      case _ObjectDragged() when objectDragged != null:
        return objectDragged(_that);
      case _AddObject() when addObject != null:
        return addObject(_that);
      case _RemoveObject() when removeObject != null:
        return removeObject(_that);
      case _ShapeAdded() when shapeAdded != null:
        return shapeAdded(_that);
      case _ShapeSelected() when shapeSelected != null:
        return shapeSelected(_that);
      case _TextAdded() when textAdded != null:
        return textAdded(_that);
      case _ImageAdded() when imageAdded != null:
        return imageAdded(_that);
      case _ConnectorAdded() when connectorAdded != null:
        return connectorAdded(_that);
      case _ObjectSelected() when objectSelected != null:
        return objectSelected(_that);
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
    required TResult Function(_ObjectDragged value) objectDragged,
    required TResult Function(_AddObject value) addObject,
    required TResult Function(_RemoveObject value) removeObject,
    required TResult Function(_ShapeAdded value) shapeAdded,
    required TResult Function(_ShapeSelected value) shapeSelected,
    required TResult Function(_TextAdded value) textAdded,
    required TResult Function(_ImageAdded value) imageAdded,
    required TResult Function(_ConnectorAdded value) connectorAdded,
    required TResult Function(_ObjectSelected value) objectSelected,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized():
        return initialize(_that);
      case _ObjectDragged():
        return objectDragged(_that);
      case _AddObject():
        return addObject(_that);
      case _RemoveObject():
        return removeObject(_that);
      case _ShapeAdded():
        return shapeAdded(_that);
      case _ShapeSelected():
        return shapeSelected(_that);
      case _TextAdded():
        return textAdded(_that);
      case _ImageAdded():
        return imageAdded(_that);
      case _ConnectorAdded():
        return connectorAdded(_that);
      case _ObjectSelected():
        return objectSelected(_that);
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
    TResult? Function(_ObjectDragged value)? objectDragged,
    TResult? Function(_AddObject value)? addObject,
    TResult? Function(_RemoveObject value)? removeObject,
    TResult? Function(_ShapeAdded value)? shapeAdded,
    TResult? Function(_ShapeSelected value)? shapeSelected,
    TResult? Function(_TextAdded value)? textAdded,
    TResult? Function(_ImageAdded value)? imageAdded,
    TResult? Function(_ConnectorAdded value)? connectorAdded,
    TResult? Function(_ObjectSelected value)? objectSelected,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialize != null:
        return initialize(_that);
      case _ObjectDragged() when objectDragged != null:
        return objectDragged(_that);
      case _AddObject() when addObject != null:
        return addObject(_that);
      case _RemoveObject() when removeObject != null:
        return removeObject(_that);
      case _ShapeAdded() when shapeAdded != null:
        return shapeAdded(_that);
      case _ShapeSelected() when shapeSelected != null:
        return shapeSelected(_that);
      case _TextAdded() when textAdded != null:
        return textAdded(_that);
      case _ImageAdded() when imageAdded != null:
        return imageAdded(_that);
      case _ConnectorAdded() when connectorAdded != null:
        return connectorAdded(_that);
      case _ObjectSelected() when objectSelected != null:
        return objectSelected(_that);
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
    TResult Function(int objectId, Offset delta)? objectDragged,
    TResult Function(SpaceObject object)? addObject,
    TResult Function(int objectId)? removeObject,
    TResult Function(ShapeType type, Offset position)? shapeAdded,
    TResult Function(int objectId)? shapeSelected,
    TResult Function(String text, Offset position)? textAdded,
    TResult Function(Offset position)? imageAdded,
    TResult Function(int startId, int endId)? connectorAdded,
    TResult Function(int? objectId)? objectSelected,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialize != null:
        return initialize();
      case _ObjectDragged() when objectDragged != null:
        return objectDragged(_that.objectId, _that.delta);
      case _AddObject() when addObject != null:
        return addObject(_that.object);
      case _RemoveObject() when removeObject != null:
        return removeObject(_that.objectId);
      case _ShapeAdded() when shapeAdded != null:
        return shapeAdded(_that.type, _that.position);
      case _ShapeSelected() when shapeSelected != null:
        return shapeSelected(_that.objectId);
      case _TextAdded() when textAdded != null:
        return textAdded(_that.text, _that.position);
      case _ImageAdded() when imageAdded != null:
        return imageAdded(_that.position);
      case _ConnectorAdded() when connectorAdded != null:
        return connectorAdded(_that.startId, _that.endId);
      case _ObjectSelected() when objectSelected != null:
        return objectSelected(_that.objectId);
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
    required TResult Function(int objectId, Offset delta) objectDragged,
    required TResult Function(SpaceObject object) addObject,
    required TResult Function(int objectId) removeObject,
    required TResult Function(ShapeType type, Offset position) shapeAdded,
    required TResult Function(int objectId) shapeSelected,
    required TResult Function(String text, Offset position) textAdded,
    required TResult Function(Offset position) imageAdded,
    required TResult Function(int startId, int endId) connectorAdded,
    required TResult Function(int? objectId) objectSelected,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized():
        return initialize();
      case _ObjectDragged():
        return objectDragged(_that.objectId, _that.delta);
      case _AddObject():
        return addObject(_that.object);
      case _RemoveObject():
        return removeObject(_that.objectId);
      case _ShapeAdded():
        return shapeAdded(_that.type, _that.position);
      case _ShapeSelected():
        return shapeSelected(_that.objectId);
      case _TextAdded():
        return textAdded(_that.text, _that.position);
      case _ImageAdded():
        return imageAdded(_that.position);
      case _ConnectorAdded():
        return connectorAdded(_that.startId, _that.endId);
      case _ObjectSelected():
        return objectSelected(_that.objectId);
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
    TResult? Function(int objectId, Offset delta)? objectDragged,
    TResult? Function(SpaceObject object)? addObject,
    TResult? Function(int objectId)? removeObject,
    TResult? Function(ShapeType type, Offset position)? shapeAdded,
    TResult? Function(int objectId)? shapeSelected,
    TResult? Function(String text, Offset position)? textAdded,
    TResult? Function(Offset position)? imageAdded,
    TResult? Function(int startId, int endId)? connectorAdded,
    TResult? Function(int? objectId)? objectSelected,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialize != null:
        return initialize();
      case _ObjectDragged() when objectDragged != null:
        return objectDragged(_that.objectId, _that.delta);
      case _AddObject() when addObject != null:
        return addObject(_that.object);
      case _RemoveObject() when removeObject != null:
        return removeObject(_that.objectId);
      case _ShapeAdded() when shapeAdded != null:
        return shapeAdded(_that.type, _that.position);
      case _ShapeSelected() when shapeSelected != null:
        return shapeSelected(_that.objectId);
      case _TextAdded() when textAdded != null:
        return textAdded(_that.text, _that.position);
      case _ImageAdded() when imageAdded != null:
        return imageAdded(_that.position);
      case _ConnectorAdded() when connectorAdded != null:
        return connectorAdded(_that.startId, _that.endId);
      case _ObjectSelected() when objectSelected != null:
        return objectSelected(_that.objectId);
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

class _ObjectDragged implements ShapeLayerEvent {
  const _ObjectDragged({required this.objectId, required this.delta});

  final int objectId;
  final Offset delta;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ObjectDraggedCopyWith<_ObjectDragged> get copyWith =>
      __$ObjectDraggedCopyWithImpl<_ObjectDragged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ObjectDragged &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId) &&
            (identical(other.delta, delta) || other.delta == delta));
  }

  @override
  int get hashCode => Object.hash(runtimeType, objectId, delta);

  @override
  String toString() {
    return 'ShapeLayerEvent.objectDragged(objectId: $objectId, delta: $delta)';
  }
}

/// @nodoc
abstract mixin class _$ObjectDraggedCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$ObjectDraggedCopyWith(
    _ObjectDragged value,
    $Res Function(_ObjectDragged) _then,
  ) = __$ObjectDraggedCopyWithImpl;
  @useResult
  $Res call({int objectId, Offset delta});
}

/// @nodoc
class __$ObjectDraggedCopyWithImpl<$Res>
    implements _$ObjectDraggedCopyWith<$Res> {
  __$ObjectDraggedCopyWithImpl(this._self, this._then);

  final _ObjectDragged _self;
  final $Res Function(_ObjectDragged) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? objectId = null, Object? delta = null}) {
    return _then(
      _ObjectDragged(
        objectId:
            null == objectId
                ? _self.objectId
                : objectId // ignore: cast_nullable_to_non_nullable
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

class _AddObject implements ShapeLayerEvent {
  const _AddObject(this.object);

  final SpaceObject object;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddObjectCopyWith<_AddObject> get copyWith =>
      __$AddObjectCopyWithImpl<_AddObject>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddObject &&
            (identical(other.object, object) || other.object == object));
  }

  @override
  int get hashCode => Object.hash(runtimeType, object);

  @override
  String toString() {
    return 'ShapeLayerEvent.addObject(object: $object)';
  }
}

/// @nodoc
abstract mixin class _$AddObjectCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$AddObjectCopyWith(
    _AddObject value,
    $Res Function(_AddObject) _then,
  ) = __$AddObjectCopyWithImpl;
  @useResult
  $Res call({SpaceObject object});
}

/// @nodoc
class __$AddObjectCopyWithImpl<$Res> implements _$AddObjectCopyWith<$Res> {
  __$AddObjectCopyWithImpl(this._self, this._then);

  final _AddObject _self;
  final $Res Function(_AddObject) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? object = null}) {
    return _then(
      _AddObject(
        null == object
            ? _self.object
            : object // ignore: cast_nullable_to_non_nullable
                as SpaceObject,
      ),
    );
  }
}

/// @nodoc

class _RemoveObject implements ShapeLayerEvent {
  const _RemoveObject(this.objectId);

  final int objectId;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RemoveObjectCopyWith<_RemoveObject> get copyWith =>
      __$RemoveObjectCopyWithImpl<_RemoveObject>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RemoveObject &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, objectId);

  @override
  String toString() {
    return 'ShapeLayerEvent.removeObject(objectId: $objectId)';
  }
}

/// @nodoc
abstract mixin class _$RemoveObjectCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$RemoveObjectCopyWith(
    _RemoveObject value,
    $Res Function(_RemoveObject) _then,
  ) = __$RemoveObjectCopyWithImpl;
  @useResult
  $Res call({int objectId});
}

/// @nodoc
class __$RemoveObjectCopyWithImpl<$Res>
    implements _$RemoveObjectCopyWith<$Res> {
  __$RemoveObjectCopyWithImpl(this._self, this._then);

  final _RemoveObject _self;
  final $Res Function(_RemoveObject) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? objectId = null}) {
    return _then(
      _RemoveObject(
        null == objectId
            ? _self.objectId
            : objectId // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _ShapeAdded implements ShapeLayerEvent {
  const _ShapeAdded({required this.type, required this.position});

  final ShapeType type;
  final Offset position;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShapeAddedCopyWith<_ShapeAdded> get copyWith =>
      __$ShapeAddedCopyWithImpl<_ShapeAdded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShapeAdded &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, position);

  @override
  String toString() {
    return 'ShapeLayerEvent.shapeAdded(type: $type, position: $position)';
  }
}

/// @nodoc
abstract mixin class _$ShapeAddedCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$ShapeAddedCopyWith(
    _ShapeAdded value,
    $Res Function(_ShapeAdded) _then,
  ) = __$ShapeAddedCopyWithImpl;
  @useResult
  $Res call({ShapeType type, Offset position});
}

/// @nodoc
class __$ShapeAddedCopyWithImpl<$Res> implements _$ShapeAddedCopyWith<$Res> {
  __$ShapeAddedCopyWithImpl(this._self, this._then);

  final _ShapeAdded _self;
  final $Res Function(_ShapeAdded) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? type = null, Object? position = null}) {
    return _then(
      _ShapeAdded(
        type:
            null == type
                ? _self.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ShapeType,
        position:
            null == position
                ? _self.position
                : position // ignore: cast_nullable_to_non_nullable
                    as Offset,
      ),
    );
  }
}

/// @nodoc

class _ShapeSelected implements ShapeLayerEvent {
  const _ShapeSelected({required this.objectId});

  final int objectId;

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
            (identical(other.objectId, objectId) ||
                other.objectId == objectId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, objectId);

  @override
  String toString() {
    return 'ShapeLayerEvent.shapeSelected(objectId: $objectId)';
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
  $Res call({int objectId});
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
  $Res call({Object? objectId = null}) {
    return _then(
      _ShapeSelected(
        objectId:
            null == objectId
                ? _self.objectId
                : objectId // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _TextAdded implements ShapeLayerEvent {
  const _TextAdded({required this.text, required this.position});

  final String text;
  final Offset position;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TextAddedCopyWith<_TextAdded> get copyWith =>
      __$TextAddedCopyWithImpl<_TextAdded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TextAdded &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, position);

  @override
  String toString() {
    return 'ShapeLayerEvent.textAdded(text: $text, position: $position)';
  }
}

/// @nodoc
abstract mixin class _$TextAddedCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$TextAddedCopyWith(
    _TextAdded value,
    $Res Function(_TextAdded) _then,
  ) = __$TextAddedCopyWithImpl;
  @useResult
  $Res call({String text, Offset position});
}

/// @nodoc
class __$TextAddedCopyWithImpl<$Res> implements _$TextAddedCopyWith<$Res> {
  __$TextAddedCopyWithImpl(this._self, this._then);

  final _TextAdded _self;
  final $Res Function(_TextAdded) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? text = null, Object? position = null}) {
    return _then(
      _TextAdded(
        text:
            null == text
                ? _self.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String,
        position:
            null == position
                ? _self.position
                : position // ignore: cast_nullable_to_non_nullable
                    as Offset,
      ),
    );
  }
}

/// @nodoc

class _ImageAdded implements ShapeLayerEvent {
  const _ImageAdded({required this.position});

  final Offset position;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImageAddedCopyWith<_ImageAdded> get copyWith =>
      __$ImageAddedCopyWithImpl<_ImageAdded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImageAdded &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, position);

  @override
  String toString() {
    return 'ShapeLayerEvent.imageAdded(position: $position)';
  }
}

/// @nodoc
abstract mixin class _$ImageAddedCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$ImageAddedCopyWith(
    _ImageAdded value,
    $Res Function(_ImageAdded) _then,
  ) = __$ImageAddedCopyWithImpl;
  @useResult
  $Res call({Offset position});
}

/// @nodoc
class __$ImageAddedCopyWithImpl<$Res> implements _$ImageAddedCopyWith<$Res> {
  __$ImageAddedCopyWithImpl(this._self, this._then);

  final _ImageAdded _self;
  final $Res Function(_ImageAdded) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? position = null}) {
    return _then(
      _ImageAdded(
        position:
            null == position
                ? _self.position
                : position // ignore: cast_nullable_to_non_nullable
                    as Offset,
      ),
    );
  }
}

/// @nodoc

class _ConnectorAdded implements ShapeLayerEvent {
  const _ConnectorAdded({required this.startId, required this.endId});

  final int startId;
  final int endId;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectorAddedCopyWith<_ConnectorAdded> get copyWith =>
      __$ConnectorAddedCopyWithImpl<_ConnectorAdded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectorAdded &&
            (identical(other.startId, startId) || other.startId == startId) &&
            (identical(other.endId, endId) || other.endId == endId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startId, endId);

  @override
  String toString() {
    return 'ShapeLayerEvent.connectorAdded(startId: $startId, endId: $endId)';
  }
}

/// @nodoc
abstract mixin class _$ConnectorAddedCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$ConnectorAddedCopyWith(
    _ConnectorAdded value,
    $Res Function(_ConnectorAdded) _then,
  ) = __$ConnectorAddedCopyWithImpl;
  @useResult
  $Res call({int startId, int endId});
}

/// @nodoc
class __$ConnectorAddedCopyWithImpl<$Res>
    implements _$ConnectorAddedCopyWith<$Res> {
  __$ConnectorAddedCopyWithImpl(this._self, this._then);

  final _ConnectorAdded _self;
  final $Res Function(_ConnectorAdded) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? startId = null, Object? endId = null}) {
    return _then(
      _ConnectorAdded(
        startId:
            null == startId
                ? _self.startId
                : startId // ignore: cast_nullable_to_non_nullable
                    as int,
        endId:
            null == endId
                ? _self.endId
                : endId // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _ObjectSelected implements ShapeLayerEvent {
  const _ObjectSelected(this.objectId);

  final int? objectId;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ObjectSelectedCopyWith<_ObjectSelected> get copyWith =>
      __$ObjectSelectedCopyWithImpl<_ObjectSelected>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ObjectSelected &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, objectId);

  @override
  String toString() {
    return 'ShapeLayerEvent.objectSelected(objectId: $objectId)';
  }
}

/// @nodoc
abstract mixin class _$ObjectSelectedCopyWith<$Res>
    implements $ShapeLayerEventCopyWith<$Res> {
  factory _$ObjectSelectedCopyWith(
    _ObjectSelected value,
    $Res Function(_ObjectSelected) _then,
  ) = __$ObjectSelectedCopyWithImpl;
  @useResult
  $Res call({int? objectId});
}

/// @nodoc
class __$ObjectSelectedCopyWithImpl<$Res>
    implements _$ObjectSelectedCopyWith<$Res> {
  __$ObjectSelectedCopyWithImpl(this._self, this._then);

  final _ObjectSelected _self;
  final $Res Function(_ObjectSelected) _then;

  /// Create a copy of ShapeLayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? objectId = freezed}) {
    return _then(
      _ObjectSelected(
        freezed == objectId
            ? _self.objectId
            : objectId // ignore: cast_nullable_to_non_nullable
                as int?,
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
  String get title;
  Map<int, SpaceObject> get objects;
  int? get selectedTool;
  int? get selectedObjectId;

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
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.objects, objects) &&
            (identical(other.selectedTool, selectedTool) ||
                other.selectedTool == selectedTool) &&
            (identical(other.selectedObjectId, selectedObjectId) ||
                other.selectedObjectId == selectedObjectId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    const DeepCollectionEquality().hash(objects),
    selectedTool,
    selectedObjectId,
  );

  @override
  String toString() {
    return 'ShapeLayerData(title: $title, objects: $objects, selectedTool: $selectedTool, selectedObjectId: $selectedObjectId)';
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
    String title,
    Map<int, SpaceObject> objects,
    int? selectedTool,
    int? selectedObjectId,
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
    Object? title = null,
    Object? objects = null,
    Object? selectedTool = freezed,
    Object? selectedObjectId = freezed,
  }) {
    return _then(
      _self.copyWith(
        title:
            null == title
                ? _self.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        objects:
            null == objects
                ? _self.objects
                : objects // ignore: cast_nullable_to_non_nullable
                    as Map<int, SpaceObject>,
        selectedTool:
            freezed == selectedTool
                ? _self.selectedTool
                : selectedTool // ignore: cast_nullable_to_non_nullable
                    as int?,
        selectedObjectId:
            freezed == selectedObjectId
                ? _self.selectedObjectId
                : selectedObjectId // ignore: cast_nullable_to_non_nullable
                    as int?,
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
      String title,
      Map<int, SpaceObject> objects,
      int? selectedTool,
      int? selectedObjectId,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShapeLayerData() when $default != null:
        return $default(
          _that.title,
          _that.objects,
          _that.selectedTool,
          _that.selectedObjectId,
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
      String title,
      Map<int, SpaceObject> objects,
      int? selectedTool,
      int? selectedObjectId,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShapeLayerData():
        return $default(
          _that.title,
          _that.objects,
          _that.selectedTool,
          _that.selectedObjectId,
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
      String title,
      Map<int, SpaceObject> objects,
      int? selectedTool,
      int? selectedObjectId,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShapeLayerData() when $default != null:
        return $default(
          _that.title,
          _that.objects,
          _that.selectedTool,
          _that.selectedObjectId,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ShapeLayerData implements ShapeLayerData {
  const _ShapeLayerData({
    this.title = "",
    final Map<int, SpaceObject> objects = const {},
    this.selectedTool,
    this.selectedObjectId,
  }) : _objects = objects;

  @override
  @JsonKey()
  final String title;
  final Map<int, SpaceObject> _objects;
  @override
  @JsonKey()
  Map<int, SpaceObject> get objects {
    if (_objects is EqualUnmodifiableMapView) return _objects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_objects);
  }

  @override
  final int? selectedTool;
  @override
  final int? selectedObjectId;

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
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._objects, _objects) &&
            (identical(other.selectedTool, selectedTool) ||
                other.selectedTool == selectedTool) &&
            (identical(other.selectedObjectId, selectedObjectId) ||
                other.selectedObjectId == selectedObjectId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    const DeepCollectionEquality().hash(_objects),
    selectedTool,
    selectedObjectId,
  );

  @override
  String toString() {
    return 'ShapeLayerData(title: $title, objects: $objects, selectedTool: $selectedTool, selectedObjectId: $selectedObjectId)';
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
    String title,
    Map<int, SpaceObject> objects,
    int? selectedTool,
    int? selectedObjectId,
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
    Object? title = null,
    Object? objects = null,
    Object? selectedTool = freezed,
    Object? selectedObjectId = freezed,
  }) {
    return _then(
      _ShapeLayerData(
        title:
            null == title
                ? _self.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        objects:
            null == objects
                ? _self._objects
                : objects // ignore: cast_nullable_to_non_nullable
                    as Map<int, SpaceObject>,
        selectedTool:
            freezed == selectedTool
                ? _self.selectedTool
                : selectedTool // ignore: cast_nullable_to_non_nullable
                    as int?,
        selectedObjectId:
            freezed == selectedObjectId
                ? _self.selectedObjectId
                : selectedObjectId // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}
