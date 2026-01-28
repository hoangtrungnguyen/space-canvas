// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'space_object.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PathObject {
  Path get path;
  Paint get paint;
  int get id;
  int get zIndex;

  /// Create a copy of PathObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PathObjectCopyWith<PathObject> get copyWith =>
      _$PathObjectCopyWithImpl<PathObject>(this as PathObject, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PathObject &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.paint, paint) || other.paint == paint) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, paint, id, zIndex);

  @override
  String toString() {
    return 'PathObject(path: $path, paint: $paint, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class $PathObjectCopyWith<$Res> {
  factory $PathObjectCopyWith(
    PathObject value,
    $Res Function(PathObject) _then,
  ) = _$PathObjectCopyWithImpl;
  @useResult
  $Res call({Path path, Paint paint, int id, int zIndex});
}

/// @nodoc
class _$PathObjectCopyWithImpl<$Res> implements $PathObjectCopyWith<$Res> {
  _$PathObjectCopyWithImpl(this._self, this._then);

  final PathObject _self;
  final $Res Function(PathObject) _then;

  /// Create a copy of PathObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? paint = null,
    Object? id = null,
    Object? zIndex = null,
  }) {
    return _then(
      _self.copyWith(
        path:
            null == path
                ? _self.path
                : path // ignore: cast_nullable_to_non_nullable
                    as Path,
        paint:
            null == paint
                ? _self.paint
                : paint // ignore: cast_nullable_to_non_nullable
                    as Paint,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [PathObject].
extension PathObjectPatterns on PathObject {
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
    TResult Function(_PathObject value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PathObject() when $default != null:
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
    TResult Function(_PathObject value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PathObject():
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
    TResult? Function(_PathObject value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PathObject() when $default != null:
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
    TResult Function(Path path, Paint paint, int id, int zIndex)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PathObject() when $default != null:
        return $default(_that.path, _that.paint, _that.id, _that.zIndex);
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
    TResult Function(Path path, Paint paint, int id, int zIndex) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PathObject():
        return $default(_that.path, _that.paint, _that.id, _that.zIndex);
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
    TResult? Function(Path path, Paint paint, int id, int zIndex)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PathObject() when $default != null:
        return $default(_that.path, _that.paint, _that.id, _that.zIndex);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PathObject extends PathObject {
  _PathObject({
    required this.path,
    required this.paint,
    required this.id,
    this.zIndex = 0,
  }) : super._();

  @override
  final Path path;
  @override
  final Paint paint;
  @override
  final int id;
  @override
  @JsonKey()
  final int zIndex;

  /// Create a copy of PathObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PathObjectCopyWith<_PathObject> get copyWith =>
      __$PathObjectCopyWithImpl<_PathObject>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PathObject &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.paint, paint) || other.paint == paint) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, paint, id, zIndex);

  @override
  String toString() {
    return 'PathObject(path: $path, paint: $paint, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class _$PathObjectCopyWith<$Res>
    implements $PathObjectCopyWith<$Res> {
  factory _$PathObjectCopyWith(
    _PathObject value,
    $Res Function(_PathObject) _then,
  ) = __$PathObjectCopyWithImpl;
  @override
  @useResult
  $Res call({Path path, Paint paint, int id, int zIndex});
}

/// @nodoc
class __$PathObjectCopyWithImpl<$Res> implements _$PathObjectCopyWith<$Res> {
  __$PathObjectCopyWithImpl(this._self, this._then);

  final _PathObject _self;
  final $Res Function(_PathObject) _then;

  /// Create a copy of PathObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? path = null,
    Object? paint = null,
    Object? id = null,
    Object? zIndex = null,
  }) {
    return _then(
      _PathObject(
        path:
            null == path
                ? _self.path
                : path // ignore: cast_nullable_to_non_nullable
                    as Path,
        paint:
            null == paint
                ? _self.paint
                : paint // ignore: cast_nullable_to_non_nullable
                    as Paint,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
mixin _$ShapeObject {
  ShapeType get type;
  Rect get rect;
  Paint get paint;
  int get id;
  String get text;
  int get zIndex;

  /// Create a copy of ShapeObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShapeObjectCopyWith<ShapeObject> get copyWith =>
      _$ShapeObjectCopyWithImpl<ShapeObject>(this as ShapeObject, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShapeObject &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.rect, rect) || other.rect == rect) &&
            (identical(other.paint, paint) || other.paint == paint) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, type, rect, paint, id, text, zIndex);

  @override
  String toString() {
    return 'ShapeObject(type: $type, rect: $rect, paint: $paint, id: $id, text: $text, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class $ShapeObjectCopyWith<$Res> {
  factory $ShapeObjectCopyWith(
    ShapeObject value,
    $Res Function(ShapeObject) _then,
  ) = _$ShapeObjectCopyWithImpl;
  @useResult
  $Res call({
    ShapeType type,
    Rect rect,
    Paint paint,
    int id,
    String text,
    int zIndex,
  });
}

/// @nodoc
class _$ShapeObjectCopyWithImpl<$Res> implements $ShapeObjectCopyWith<$Res> {
  _$ShapeObjectCopyWithImpl(this._self, this._then);

  final ShapeObject _self;
  final $Res Function(ShapeObject) _then;

  /// Create a copy of ShapeObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? rect = null,
    Object? paint = null,
    Object? id = null,
    Object? text = null,
    Object? zIndex = null,
  }) {
    return _then(
      _self.copyWith(
        type:
            null == type
                ? _self.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ShapeType,
        rect:
            null == rect
                ? _self.rect
                : rect // ignore: cast_nullable_to_non_nullable
                    as Rect,
        paint:
            null == paint
                ? _self.paint
                : paint // ignore: cast_nullable_to_non_nullable
                    as Paint,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        text:
            null == text
                ? _self.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [ShapeObject].
extension ShapeObjectPatterns on ShapeObject {
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
    TResult Function(_ShapeObject value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShapeObject() when $default != null:
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
    TResult Function(_ShapeObject value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShapeObject():
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
    TResult? Function(_ShapeObject value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShapeObject() when $default != null:
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
      ShapeType type,
      Rect rect,
      Paint paint,
      int id,
      String text,
      int zIndex,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShapeObject() when $default != null:
        return $default(
          _that.type,
          _that.rect,
          _that.paint,
          _that.id,
          _that.text,
          _that.zIndex,
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
      ShapeType type,
      Rect rect,
      Paint paint,
      int id,
      String text,
      int zIndex,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShapeObject():
        return $default(
          _that.type,
          _that.rect,
          _that.paint,
          _that.id,
          _that.text,
          _that.zIndex,
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
      ShapeType type,
      Rect rect,
      Paint paint,
      int id,
      String text,
      int zIndex,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShapeObject() when $default != null:
        return $default(
          _that.type,
          _that.rect,
          _that.paint,
          _that.id,
          _that.text,
          _that.zIndex,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ShapeObject extends ShapeObject {
  _ShapeObject({
    required this.type,
    required this.rect,
    required this.paint,
    required this.id,
    this.text = '',
    this.zIndex = 0,
  }) : super._();

  @override
  final ShapeType type;
  @override
  final Rect rect;
  @override
  final Paint paint;
  @override
  final int id;
  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey()
  final int zIndex;

  /// Create a copy of ShapeObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShapeObjectCopyWith<_ShapeObject> get copyWith =>
      __$ShapeObjectCopyWithImpl<_ShapeObject>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShapeObject &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.rect, rect) || other.rect == rect) &&
            (identical(other.paint, paint) || other.paint == paint) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, type, rect, paint, id, text, zIndex);

  @override
  String toString() {
    return 'ShapeObject(type: $type, rect: $rect, paint: $paint, id: $id, text: $text, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class _$ShapeObjectCopyWith<$Res>
    implements $ShapeObjectCopyWith<$Res> {
  factory _$ShapeObjectCopyWith(
    _ShapeObject value,
    $Res Function(_ShapeObject) _then,
  ) = __$ShapeObjectCopyWithImpl;
  @override
  @useResult
  $Res call({
    ShapeType type,
    Rect rect,
    Paint paint,
    int id,
    String text,
    int zIndex,
  });
}

/// @nodoc
class __$ShapeObjectCopyWithImpl<$Res> implements _$ShapeObjectCopyWith<$Res> {
  __$ShapeObjectCopyWithImpl(this._self, this._then);

  final _ShapeObject _self;
  final $Res Function(_ShapeObject) _then;

  /// Create a copy of ShapeObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? rect = null,
    Object? paint = null,
    Object? id = null,
    Object? text = null,
    Object? zIndex = null,
  }) {
    return _then(
      _ShapeObject(
        type:
            null == type
                ? _self.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ShapeType,
        rect:
            null == rect
                ? _self.rect
                : rect // ignore: cast_nullable_to_non_nullable
                    as Rect,
        paint:
            null == paint
                ? _self.paint
                : paint // ignore: cast_nullable_to_non_nullable
                    as Paint,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        text:
            null == text
                ? _self.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
mixin _$TextObject {
  String get text;
  Offset get position;
  double get fontSize;
  int get color; // ARGB
  int get id;
  int get zIndex;
  String? get fontFamily;

  /// Create a copy of TextObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextObjectCopyWith<TextObject> get copyWith =>
      _$TextObjectCopyWithImpl<TextObject>(this as TextObject, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextObject &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    text,
    position,
    fontSize,
    color,
    id,
    zIndex,
    fontFamily,
  );

  @override
  String toString() {
    return 'TextObject(text: $text, position: $position, fontSize: $fontSize, color: $color, id: $id, zIndex: $zIndex, fontFamily: $fontFamily)';
  }
}

/// @nodoc
abstract mixin class $TextObjectCopyWith<$Res> {
  factory $TextObjectCopyWith(
    TextObject value,
    $Res Function(TextObject) _then,
  ) = _$TextObjectCopyWithImpl;
  @useResult
  $Res call({
    String text,
    Offset position,
    double fontSize,
    int color,
    int id,
    int zIndex,
    String? fontFamily,
  });
}

/// @nodoc
class _$TextObjectCopyWithImpl<$Res> implements $TextObjectCopyWith<$Res> {
  _$TextObjectCopyWithImpl(this._self, this._then);

  final TextObject _self;
  final $Res Function(TextObject) _then;

  /// Create a copy of TextObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? position = null,
    Object? fontSize = null,
    Object? color = null,
    Object? id = null,
    Object? zIndex = null,
    Object? fontFamily = freezed,
  }) {
    return _then(
      _self.copyWith(
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
        fontSize:
            null == fontSize
                ? _self.fontSize
                : fontSize // ignore: cast_nullable_to_non_nullable
                    as double,
        color:
            null == color
                ? _self.color
                : color // ignore: cast_nullable_to_non_nullable
                    as int,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
        fontFamily:
            freezed == fontFamily
                ? _self.fontFamily
                : fontFamily // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [TextObject].
extension TextObjectPatterns on TextObject {
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
    TResult Function(_TextObject value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TextObject() when $default != null:
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
    TResult Function(_TextObject value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextObject():
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
    TResult? Function(_TextObject value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextObject() when $default != null:
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
      String text,
      Offset position,
      double fontSize,
      int color,
      int id,
      int zIndex,
      String? fontFamily,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TextObject() when $default != null:
        return $default(
          _that.text,
          _that.position,
          _that.fontSize,
          _that.color,
          _that.id,
          _that.zIndex,
          _that.fontFamily,
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
      String text,
      Offset position,
      double fontSize,
      int color,
      int id,
      int zIndex,
      String? fontFamily,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextObject():
        return $default(
          _that.text,
          _that.position,
          _that.fontSize,
          _that.color,
          _that.id,
          _that.zIndex,
          _that.fontFamily,
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
      String text,
      Offset position,
      double fontSize,
      int color,
      int id,
      int zIndex,
      String? fontFamily,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextObject() when $default != null:
        return $default(
          _that.text,
          _that.position,
          _that.fontSize,
          _that.color,
          _that.id,
          _that.zIndex,
          _that.fontFamily,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TextObject extends TextObject {
  _TextObject({
    required this.text,
    required this.position,
    required this.fontSize,
    required this.color,
    required this.id,
    this.zIndex = 0,
    this.fontFamily,
  }) : super._();

  @override
  final String text;
  @override
  final Offset position;
  @override
  final double fontSize;
  @override
  final int color;
  // ARGB
  @override
  final int id;
  @override
  @JsonKey()
  final int zIndex;
  @override
  final String? fontFamily;

  /// Create a copy of TextObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TextObjectCopyWith<_TextObject> get copyWith =>
      __$TextObjectCopyWithImpl<_TextObject>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TextObject &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    text,
    position,
    fontSize,
    color,
    id,
    zIndex,
    fontFamily,
  );

  @override
  String toString() {
    return 'TextObject(text: $text, position: $position, fontSize: $fontSize, color: $color, id: $id, zIndex: $zIndex, fontFamily: $fontFamily)';
  }
}

/// @nodoc
abstract mixin class _$TextObjectCopyWith<$Res>
    implements $TextObjectCopyWith<$Res> {
  factory _$TextObjectCopyWith(
    _TextObject value,
    $Res Function(_TextObject) _then,
  ) = __$TextObjectCopyWithImpl;
  @override
  @useResult
  $Res call({
    String text,
    Offset position,
    double fontSize,
    int color,
    int id,
    int zIndex,
    String? fontFamily,
  });
}

/// @nodoc
class __$TextObjectCopyWithImpl<$Res> implements _$TextObjectCopyWith<$Res> {
  __$TextObjectCopyWithImpl(this._self, this._then);

  final _TextObject _self;
  final $Res Function(_TextObject) _then;

  /// Create a copy of TextObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? position = null,
    Object? fontSize = null,
    Object? color = null,
    Object? id = null,
    Object? zIndex = null,
    Object? fontFamily = freezed,
  }) {
    return _then(
      _TextObject(
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
        fontSize:
            null == fontSize
                ? _self.fontSize
                : fontSize // ignore: cast_nullable_to_non_nullable
                    as double,
        color:
            null == color
                ? _self.color
                : color // ignore: cast_nullable_to_non_nullable
                    as int,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
        fontFamily:
            freezed == fontFamily
                ? _self.fontFamily
                : fontFamily // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
mixin _$ImageObject {
  String get imageUrl; // or local path / bytes identifier
  Rect get rect;
  int get id;
  int get zIndex;

  /// Create a copy of ImageObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImageObjectCopyWith<ImageObject> get copyWith =>
      _$ImageObjectCopyWithImpl<ImageObject>(this as ImageObject, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageObject &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.rect, rect) || other.rect == rect) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imageUrl, rect, id, zIndex);

  @override
  String toString() {
    return 'ImageObject(imageUrl: $imageUrl, rect: $rect, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class $ImageObjectCopyWith<$Res> {
  factory $ImageObjectCopyWith(
    ImageObject value,
    $Res Function(ImageObject) _then,
  ) = _$ImageObjectCopyWithImpl;
  @useResult
  $Res call({String imageUrl, Rect rect, int id, int zIndex});
}

/// @nodoc
class _$ImageObjectCopyWithImpl<$Res> implements $ImageObjectCopyWith<$Res> {
  _$ImageObjectCopyWithImpl(this._self, this._then);

  final ImageObject _self;
  final $Res Function(ImageObject) _then;

  /// Create a copy of ImageObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? rect = null,
    Object? id = null,
    Object? zIndex = null,
  }) {
    return _then(
      _self.copyWith(
        imageUrl:
            null == imageUrl
                ? _self.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String,
        rect:
            null == rect
                ? _self.rect
                : rect // ignore: cast_nullable_to_non_nullable
                    as Rect,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [ImageObject].
extension ImageObjectPatterns on ImageObject {
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
    TResult Function(_ImageObject value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImageObject() when $default != null:
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
    TResult Function(_ImageObject value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageObject():
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
    TResult? Function(_ImageObject value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageObject() when $default != null:
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
    TResult Function(String imageUrl, Rect rect, int id, int zIndex)?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImageObject() when $default != null:
        return $default(_that.imageUrl, _that.rect, _that.id, _that.zIndex);
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
    TResult Function(String imageUrl, Rect rect, int id, int zIndex) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageObject():
        return $default(_that.imageUrl, _that.rect, _that.id, _that.zIndex);
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
    TResult? Function(String imageUrl, Rect rect, int id, int zIndex)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageObject() when $default != null:
        return $default(_that.imageUrl, _that.rect, _that.id, _that.zIndex);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ImageObject extends ImageObject {
  _ImageObject({
    required this.imageUrl,
    required this.rect,
    required this.id,
    this.zIndex = 0,
  }) : super._();

  @override
  final String imageUrl;
  // or local path / bytes identifier
  @override
  final Rect rect;
  @override
  final int id;
  @override
  @JsonKey()
  final int zIndex;

  /// Create a copy of ImageObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImageObjectCopyWith<_ImageObject> get copyWith =>
      __$ImageObjectCopyWithImpl<_ImageObject>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImageObject &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.rect, rect) || other.rect == rect) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imageUrl, rect, id, zIndex);

  @override
  String toString() {
    return 'ImageObject(imageUrl: $imageUrl, rect: $rect, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class _$ImageObjectCopyWith<$Res>
    implements $ImageObjectCopyWith<$Res> {
  factory _$ImageObjectCopyWith(
    _ImageObject value,
    $Res Function(_ImageObject) _then,
  ) = __$ImageObjectCopyWithImpl;
  @override
  @useResult
  $Res call({String imageUrl, Rect rect, int id, int zIndex});
}

/// @nodoc
class __$ImageObjectCopyWithImpl<$Res> implements _$ImageObjectCopyWith<$Res> {
  __$ImageObjectCopyWithImpl(this._self, this._then);

  final _ImageObject _self;
  final $Res Function(_ImageObject) _then;

  /// Create a copy of ImageObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? imageUrl = null,
    Object? rect = null,
    Object? id = null,
    Object? zIndex = null,
  }) {
    return _then(
      _ImageObject(
        imageUrl:
            null == imageUrl
                ? _self.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String,
        rect:
            null == rect
                ? _self.rect
                : rect // ignore: cast_nullable_to_non_nullable
                    as Rect,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
mixin _$ConnectorObject {
  int get startObjectId;
  int get endObjectId;
  Offset get startPoint;
  Offset get endPoint;
  double get strokeWidth;
  int get color;
  int get id;
  int get zIndex;

  /// Create a copy of ConnectorObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectorObjectCopyWith<ConnectorObject> get copyWith =>
      _$ConnectorObjectCopyWithImpl<ConnectorObject>(
        this as ConnectorObject,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectorObject &&
            (identical(other.startObjectId, startObjectId) ||
                other.startObjectId == startObjectId) &&
            (identical(other.endObjectId, endObjectId) ||
                other.endObjectId == endObjectId) &&
            (identical(other.startPoint, startPoint) ||
                other.startPoint == startPoint) &&
            (identical(other.endPoint, endPoint) ||
                other.endPoint == endPoint) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    startObjectId,
    endObjectId,
    startPoint,
    endPoint,
    strokeWidth,
    color,
    id,
    zIndex,
  );

  @override
  String toString() {
    return 'ConnectorObject(startObjectId: $startObjectId, endObjectId: $endObjectId, startPoint: $startPoint, endPoint: $endPoint, strokeWidth: $strokeWidth, color: $color, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class $ConnectorObjectCopyWith<$Res> {
  factory $ConnectorObjectCopyWith(
    ConnectorObject value,
    $Res Function(ConnectorObject) _then,
  ) = _$ConnectorObjectCopyWithImpl;
  @useResult
  $Res call({
    int startObjectId,
    int endObjectId,
    Offset startPoint,
    Offset endPoint,
    double strokeWidth,
    int color,
    int id,
    int zIndex,
  });
}

/// @nodoc
class _$ConnectorObjectCopyWithImpl<$Res>
    implements $ConnectorObjectCopyWith<$Res> {
  _$ConnectorObjectCopyWithImpl(this._self, this._then);

  final ConnectorObject _self;
  final $Res Function(ConnectorObject) _then;

  /// Create a copy of ConnectorObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startObjectId = null,
    Object? endObjectId = null,
    Object? startPoint = null,
    Object? endPoint = null,
    Object? strokeWidth = null,
    Object? color = null,
    Object? id = null,
    Object? zIndex = null,
  }) {
    return _then(
      _self.copyWith(
        startObjectId:
            null == startObjectId
                ? _self.startObjectId
                : startObjectId // ignore: cast_nullable_to_non_nullable
                    as int,
        endObjectId:
            null == endObjectId
                ? _self.endObjectId
                : endObjectId // ignore: cast_nullable_to_non_nullable
                    as int,
        startPoint:
            null == startPoint
                ? _self.startPoint
                : startPoint // ignore: cast_nullable_to_non_nullable
                    as Offset,
        endPoint:
            null == endPoint
                ? _self.endPoint
                : endPoint // ignore: cast_nullable_to_non_nullable
                    as Offset,
        strokeWidth:
            null == strokeWidth
                ? _self.strokeWidth
                : strokeWidth // ignore: cast_nullable_to_non_nullable
                    as double,
        color:
            null == color
                ? _self.color
                : color // ignore: cast_nullable_to_non_nullable
                    as int,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [ConnectorObject].
extension ConnectorObjectPatterns on ConnectorObject {
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
    TResult Function(_ConnectorObject value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConnectorObject() when $default != null:
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
    TResult Function(_ConnectorObject value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectorObject():
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
    TResult? Function(_ConnectorObject value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectorObject() when $default != null:
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
      int startObjectId,
      int endObjectId,
      Offset startPoint,
      Offset endPoint,
      double strokeWidth,
      int color,
      int id,
      int zIndex,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConnectorObject() when $default != null:
        return $default(
          _that.startObjectId,
          _that.endObjectId,
          _that.startPoint,
          _that.endPoint,
          _that.strokeWidth,
          _that.color,
          _that.id,
          _that.zIndex,
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
      int startObjectId,
      int endObjectId,
      Offset startPoint,
      Offset endPoint,
      double strokeWidth,
      int color,
      int id,
      int zIndex,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectorObject():
        return $default(
          _that.startObjectId,
          _that.endObjectId,
          _that.startPoint,
          _that.endPoint,
          _that.strokeWidth,
          _that.color,
          _that.id,
          _that.zIndex,
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
      int startObjectId,
      int endObjectId,
      Offset startPoint,
      Offset endPoint,
      double strokeWidth,
      int color,
      int id,
      int zIndex,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectorObject() when $default != null:
        return $default(
          _that.startObjectId,
          _that.endObjectId,
          _that.startPoint,
          _that.endPoint,
          _that.strokeWidth,
          _that.color,
          _that.id,
          _that.zIndex,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ConnectorObject extends ConnectorObject {
  _ConnectorObject({
    required this.startObjectId,
    required this.endObjectId,
    required this.startPoint,
    required this.endPoint,
    required this.strokeWidth,
    required this.color,
    required this.id,
    this.zIndex = 0,
  }) : super._();

  @override
  final int startObjectId;
  @override
  final int endObjectId;
  @override
  final Offset startPoint;
  @override
  final Offset endPoint;
  @override
  final double strokeWidth;
  @override
  final int color;
  @override
  final int id;
  @override
  @JsonKey()
  final int zIndex;

  /// Create a copy of ConnectorObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectorObjectCopyWith<_ConnectorObject> get copyWith =>
      __$ConnectorObjectCopyWithImpl<_ConnectorObject>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectorObject &&
            (identical(other.startObjectId, startObjectId) ||
                other.startObjectId == startObjectId) &&
            (identical(other.endObjectId, endObjectId) ||
                other.endObjectId == endObjectId) &&
            (identical(other.startPoint, startPoint) ||
                other.startPoint == startPoint) &&
            (identical(other.endPoint, endPoint) ||
                other.endPoint == endPoint) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    startObjectId,
    endObjectId,
    startPoint,
    endPoint,
    strokeWidth,
    color,
    id,
    zIndex,
  );

  @override
  String toString() {
    return 'ConnectorObject(startObjectId: $startObjectId, endObjectId: $endObjectId, startPoint: $startPoint, endPoint: $endPoint, strokeWidth: $strokeWidth, color: $color, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class _$ConnectorObjectCopyWith<$Res>
    implements $ConnectorObjectCopyWith<$Res> {
  factory _$ConnectorObjectCopyWith(
    _ConnectorObject value,
    $Res Function(_ConnectorObject) _then,
  ) = __$ConnectorObjectCopyWithImpl;
  @override
  @useResult
  $Res call({
    int startObjectId,
    int endObjectId,
    Offset startPoint,
    Offset endPoint,
    double strokeWidth,
    int color,
    int id,
    int zIndex,
  });
}

/// @nodoc
class __$ConnectorObjectCopyWithImpl<$Res>
    implements _$ConnectorObjectCopyWith<$Res> {
  __$ConnectorObjectCopyWithImpl(this._self, this._then);

  final _ConnectorObject _self;
  final $Res Function(_ConnectorObject) _then;

  /// Create a copy of ConnectorObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? startObjectId = null,
    Object? endObjectId = null,
    Object? startPoint = null,
    Object? endPoint = null,
    Object? strokeWidth = null,
    Object? color = null,
    Object? id = null,
    Object? zIndex = null,
  }) {
    return _then(
      _ConnectorObject(
        startObjectId:
            null == startObjectId
                ? _self.startObjectId
                : startObjectId // ignore: cast_nullable_to_non_nullable
                    as int,
        endObjectId:
            null == endObjectId
                ? _self.endObjectId
                : endObjectId // ignore: cast_nullable_to_non_nullable
                    as int,
        startPoint:
            null == startPoint
                ? _self.startPoint
                : startPoint // ignore: cast_nullable_to_non_nullable
                    as Offset,
        endPoint:
            null == endPoint
                ? _self.endPoint
                : endPoint // ignore: cast_nullable_to_non_nullable
                    as Offset,
        strokeWidth:
            null == strokeWidth
                ? _self.strokeWidth
                : strokeWidth // ignore: cast_nullable_to_non_nullable
                    as double,
        color:
            null == color
                ? _self.color
                : color // ignore: cast_nullable_to_non_nullable
                    as int,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
mixin _$GroupObject {
  List<int> get childrenIds;
  Rect get rect;
  int get id;
  int get zIndex;

  /// Create a copy of GroupObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GroupObjectCopyWith<GroupObject> get copyWith =>
      _$GroupObjectCopyWithImpl<GroupObject>(this as GroupObject, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GroupObject &&
            const DeepCollectionEquality().equals(
              other.childrenIds,
              childrenIds,
            ) &&
            (identical(other.rect, rect) || other.rect == rect) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(childrenIds),
    rect,
    id,
    zIndex,
  );

  @override
  String toString() {
    return 'GroupObject(childrenIds: $childrenIds, rect: $rect, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class $GroupObjectCopyWith<$Res> {
  factory $GroupObjectCopyWith(
    GroupObject value,
    $Res Function(GroupObject) _then,
  ) = _$GroupObjectCopyWithImpl;
  @useResult
  $Res call({List<int> childrenIds, Rect rect, int id, int zIndex});
}

/// @nodoc
class _$GroupObjectCopyWithImpl<$Res> implements $GroupObjectCopyWith<$Res> {
  _$GroupObjectCopyWithImpl(this._self, this._then);

  final GroupObject _self;
  final $Res Function(GroupObject) _then;

  /// Create a copy of GroupObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? childrenIds = null,
    Object? rect = null,
    Object? id = null,
    Object? zIndex = null,
  }) {
    return _then(
      _self.copyWith(
        childrenIds:
            null == childrenIds
                ? _self.childrenIds
                : childrenIds // ignore: cast_nullable_to_non_nullable
                    as List<int>,
        rect:
            null == rect
                ? _self.rect
                : rect // ignore: cast_nullable_to_non_nullable
                    as Rect,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GroupObject].
extension GroupObjectPatterns on GroupObject {
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
    TResult Function(_GroupObject value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GroupObject() when $default != null:
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
    TResult Function(_GroupObject value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupObject():
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
    TResult? Function(_GroupObject value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupObject() when $default != null:
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
    TResult Function(List<int> childrenIds, Rect rect, int id, int zIndex)?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GroupObject() when $default != null:
        return $default(_that.childrenIds, _that.rect, _that.id, _that.zIndex);
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
    TResult Function(List<int> childrenIds, Rect rect, int id, int zIndex)
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupObject():
        return $default(_that.childrenIds, _that.rect, _that.id, _that.zIndex);
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
    TResult? Function(List<int> childrenIds, Rect rect, int id, int zIndex)?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupObject() when $default != null:
        return $default(_that.childrenIds, _that.rect, _that.id, _that.zIndex);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GroupObject extends GroupObject {
  _GroupObject({
    required final List<int> childrenIds,
    required this.rect,
    required this.id,
    this.zIndex = 0,
  }) : _childrenIds = childrenIds,
       super._();

  final List<int> _childrenIds;
  @override
  List<int> get childrenIds {
    if (_childrenIds is EqualUnmodifiableListView) return _childrenIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_childrenIds);
  }

  @override
  final Rect rect;
  @override
  final int id;
  @override
  @JsonKey()
  final int zIndex;

  /// Create a copy of GroupObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GroupObjectCopyWith<_GroupObject> get copyWith =>
      __$GroupObjectCopyWithImpl<_GroupObject>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GroupObject &&
            const DeepCollectionEquality().equals(
              other._childrenIds,
              _childrenIds,
            ) &&
            (identical(other.rect, rect) || other.rect == rect) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_childrenIds),
    rect,
    id,
    zIndex,
  );

  @override
  String toString() {
    return 'GroupObject(childrenIds: $childrenIds, rect: $rect, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class _$GroupObjectCopyWith<$Res>
    implements $GroupObjectCopyWith<$Res> {
  factory _$GroupObjectCopyWith(
    _GroupObject value,
    $Res Function(_GroupObject) _then,
  ) = __$GroupObjectCopyWithImpl;
  @override
  @useResult
  $Res call({List<int> childrenIds, Rect rect, int id, int zIndex});
}

/// @nodoc
class __$GroupObjectCopyWithImpl<$Res> implements _$GroupObjectCopyWith<$Res> {
  __$GroupObjectCopyWithImpl(this._self, this._then);

  final _GroupObject _self;
  final $Res Function(_GroupObject) _then;

  /// Create a copy of GroupObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? childrenIds = null,
    Object? rect = null,
    Object? id = null,
    Object? zIndex = null,
  }) {
    return _then(
      _GroupObject(
        childrenIds:
            null == childrenIds
                ? _self._childrenIds
                : childrenIds // ignore: cast_nullable_to_non_nullable
                    as List<int>,
        rect:
            null == rect
                ? _self.rect
                : rect // ignore: cast_nullable_to_non_nullable
                    as Rect,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
mixin _$ListOfPointObject {
  List<Offset> get points;
  double get strokeWidth;
  int get color;
  int get id;
  int get zIndex;

  /// Create a copy of ListOfPointObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListOfPointObjectCopyWith<ListOfPointObject> get copyWith =>
      _$ListOfPointObjectCopyWithImpl<ListOfPointObject>(
        this as ListOfPointObject,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListOfPointObject &&
            const DeepCollectionEquality().equals(other.points, points) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(points),
    strokeWidth,
    color,
    id,
    zIndex,
  );

  @override
  String toString() {
    return 'ListOfPointObject(points: $points, strokeWidth: $strokeWidth, color: $color, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class $ListOfPointObjectCopyWith<$Res> {
  factory $ListOfPointObjectCopyWith(
    ListOfPointObject value,
    $Res Function(ListOfPointObject) _then,
  ) = _$ListOfPointObjectCopyWithImpl;
  @useResult
  $Res call({
    List<Offset> points,
    double strokeWidth,
    int color,
    int id,
    int zIndex,
  });
}

/// @nodoc
class _$ListOfPointObjectCopyWithImpl<$Res>
    implements $ListOfPointObjectCopyWith<$Res> {
  _$ListOfPointObjectCopyWithImpl(this._self, this._then);

  final ListOfPointObject _self;
  final $Res Function(ListOfPointObject) _then;

  /// Create a copy of ListOfPointObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? points = null,
    Object? strokeWidth = null,
    Object? color = null,
    Object? id = null,
    Object? zIndex = null,
  }) {
    return _then(
      _self.copyWith(
        points:
            null == points
                ? _self.points
                : points // ignore: cast_nullable_to_non_nullable
                    as List<Offset>,
        strokeWidth:
            null == strokeWidth
                ? _self.strokeWidth
                : strokeWidth // ignore: cast_nullable_to_non_nullable
                    as double,
        color:
            null == color
                ? _self.color
                : color // ignore: cast_nullable_to_non_nullable
                    as int,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [ListOfPointObject].
extension ListOfPointObjectPatterns on ListOfPointObject {
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
    TResult Function(_ListOfPointObject value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ListOfPointObject() when $default != null:
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
    TResult Function(_ListOfPointObject value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListOfPointObject():
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
    TResult? Function(_ListOfPointObject value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListOfPointObject() when $default != null:
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
      List<Offset> points,
      double strokeWidth,
      int color,
      int id,
      int zIndex,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ListOfPointObject() when $default != null:
        return $default(
          _that.points,
          _that.strokeWidth,
          _that.color,
          _that.id,
          _that.zIndex,
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
      List<Offset> points,
      double strokeWidth,
      int color,
      int id,
      int zIndex,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListOfPointObject():
        return $default(
          _that.points,
          _that.strokeWidth,
          _that.color,
          _that.id,
          _that.zIndex,
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
      List<Offset> points,
      double strokeWidth,
      int color,
      int id,
      int zIndex,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListOfPointObject() when $default != null:
        return $default(
          _that.points,
          _that.strokeWidth,
          _that.color,
          _that.id,
          _that.zIndex,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ListOfPointObject extends ListOfPointObject {
  _ListOfPointObject({
    required final List<Offset> points,
    required this.strokeWidth,
    required this.color,
    required this.id,
    this.zIndex = 0,
  }) : _points = points,
       super._();

  final List<Offset> _points;
  @override
  List<Offset> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  final double strokeWidth;
  @override
  final int color;
  @override
  final int id;
  @override
  @JsonKey()
  final int zIndex;

  /// Create a copy of ListOfPointObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ListOfPointObjectCopyWith<_ListOfPointObject> get copyWith =>
      __$ListOfPointObjectCopyWithImpl<_ListOfPointObject>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListOfPointObject &&
            const DeepCollectionEquality().equals(other._points, _points) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_points),
    strokeWidth,
    color,
    id,
    zIndex,
  );

  @override
  String toString() {
    return 'ListOfPointObject(points: $points, strokeWidth: $strokeWidth, color: $color, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class _$ListOfPointObjectCopyWith<$Res>
    implements $ListOfPointObjectCopyWith<$Res> {
  factory _$ListOfPointObjectCopyWith(
    _ListOfPointObject value,
    $Res Function(_ListOfPointObject) _then,
  ) = __$ListOfPointObjectCopyWithImpl;
  @override
  @useResult
  $Res call({
    List<Offset> points,
    double strokeWidth,
    int color,
    int id,
    int zIndex,
  });
}

/// @nodoc
class __$ListOfPointObjectCopyWithImpl<$Res>
    implements _$ListOfPointObjectCopyWith<$Res> {
  __$ListOfPointObjectCopyWithImpl(this._self, this._then);

  final _ListOfPointObject _self;
  final $Res Function(_ListOfPointObject) _then;

  /// Create a copy of ListOfPointObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? points = null,
    Object? strokeWidth = null,
    Object? color = null,
    Object? id = null,
    Object? zIndex = null,
  }) {
    return _then(
      _ListOfPointObject(
        points:
            null == points
                ? _self._points
                : points // ignore: cast_nullable_to_non_nullable
                    as List<Offset>,
        strokeWidth:
            null == strokeWidth
                ? _self.strokeWidth
                : strokeWidth // ignore: cast_nullable_to_non_nullable
                    as double,
        color:
            null == color
                ? _self.color
                : color // ignore: cast_nullable_to_non_nullable
                    as int,
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        zIndex:
            null == zIndex
                ? _self.zIndex
                : zIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}
