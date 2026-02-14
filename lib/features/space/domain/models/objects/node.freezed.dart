// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PathNode {
  Path get path;
  Paint get paint;
  int get id;
  int get zIndex;

  /// Create a copy of PathNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PathNodeCopyWith<PathNode> get copyWith =>
      _$PathNodeCopyWithImpl<PathNode>(this as PathNode, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PathNode &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.paint, paint) || other.paint == paint) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, paint, id, zIndex);

  @override
  String toString() {
    return 'PathNode(path: $path, paint: $paint, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class $PathNodeCopyWith<$Res> {
  factory $PathNodeCopyWith(PathNode value, $Res Function(PathNode) _then) =
      _$PathNodeCopyWithImpl;
  @useResult
  $Res call({Path path, Paint paint, int id, int zIndex});
}

/// @nodoc
class _$PathNodeCopyWithImpl<$Res> implements $PathNodeCopyWith<$Res> {
  _$PathNodeCopyWithImpl(this._self, this._then);

  final PathNode _self;
  final $Res Function(PathNode) _then;

  /// Create a copy of PathNode
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

/// Adds pattern-matching-related methods to [PathNode].
extension PathNodePatterns on PathNode {
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
    TResult Function(_PathNode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PathNode() when $default != null:
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
    TResult Function(_PathNode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PathNode():
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
    TResult? Function(_PathNode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PathNode() when $default != null:
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
      case _PathNode() when $default != null:
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
      case _PathNode():
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
      case _PathNode() when $default != null:
        return $default(_that.path, _that.paint, _that.id, _that.zIndex);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PathNode extends PathNode {
  _PathNode({
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

  /// Create a copy of PathNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PathNodeCopyWith<_PathNode> get copyWith =>
      __$PathNodeCopyWithImpl<_PathNode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PathNode &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.paint, paint) || other.paint == paint) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, paint, id, zIndex);

  @override
  String toString() {
    return 'PathNode(path: $path, paint: $paint, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class _$PathNodeCopyWith<$Res>
    implements $PathNodeCopyWith<$Res> {
  factory _$PathNodeCopyWith(_PathNode value, $Res Function(_PathNode) _then) =
      __$PathNodeCopyWithImpl;
  @override
  @useResult
  $Res call({Path path, Paint paint, int id, int zIndex});
}

/// @nodoc
class __$PathNodeCopyWithImpl<$Res> implements _$PathNodeCopyWith<$Res> {
  __$PathNodeCopyWithImpl(this._self, this._then);

  final _PathNode _self;
  final $Res Function(_PathNode) _then;

  /// Create a copy of PathNode
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
      _PathNode(
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
mixin _$ShapeNode {
  ShapeType get type;
  Rect get rect;
  Paint get paint;
  int get id;
  String get text;
  int get zIndex;

  /// Create a copy of ShapeNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShapeNodeCopyWith<ShapeNode> get copyWith =>
      _$ShapeNodeCopyWithImpl<ShapeNode>(this as ShapeNode, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShapeNode &&
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
    return 'ShapeNode(type: $type, rect: $rect, paint: $paint, id: $id, text: $text, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class $ShapeNodeCopyWith<$Res> {
  factory $ShapeNodeCopyWith(ShapeNode value, $Res Function(ShapeNode) _then) =
      _$ShapeNodeCopyWithImpl;
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
class _$ShapeNodeCopyWithImpl<$Res> implements $ShapeNodeCopyWith<$Res> {
  _$ShapeNodeCopyWithImpl(this._self, this._then);

  final ShapeNode _self;
  final $Res Function(ShapeNode) _then;

  /// Create a copy of ShapeNode
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

/// Adds pattern-matching-related methods to [ShapeNode].
extension ShapeNodePatterns on ShapeNode {
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
    TResult Function(_ShapeNode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShapeNode() when $default != null:
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
    TResult Function(_ShapeNode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShapeNode():
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
    TResult? Function(_ShapeNode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShapeNode() when $default != null:
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
      case _ShapeNode() when $default != null:
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
      case _ShapeNode():
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
      case _ShapeNode() when $default != null:
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

class _ShapeNode extends ShapeNode {
  _ShapeNode({
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

  /// Create a copy of ShapeNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShapeNodeCopyWith<_ShapeNode> get copyWith =>
      __$ShapeNodeCopyWithImpl<_ShapeNode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShapeNode &&
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
    return 'ShapeNode(type: $type, rect: $rect, paint: $paint, id: $id, text: $text, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class _$ShapeNodeCopyWith<$Res>
    implements $ShapeNodeCopyWith<$Res> {
  factory _$ShapeNodeCopyWith(
    _ShapeNode value,
    $Res Function(_ShapeNode) _then,
  ) = __$ShapeNodeCopyWithImpl;
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
class __$ShapeNodeCopyWithImpl<$Res> implements _$ShapeNodeCopyWith<$Res> {
  __$ShapeNodeCopyWithImpl(this._self, this._then);

  final _ShapeNode _self;
  final $Res Function(_ShapeNode) _then;

  /// Create a copy of ShapeNode
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
      _ShapeNode(
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
mixin _$TextNode {
  String get text;
  Offset get position;
  double get fontSize;
  int get color; // ARGB
  int get id;
  int get zIndex;
  String? get fontFamily;

  /// Create a copy of TextNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextNodeCopyWith<TextNode> get copyWith =>
      _$TextNodeCopyWithImpl<TextNode>(this as TextNode, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextNode &&
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
    return 'TextNode(text: $text, position: $position, fontSize: $fontSize, color: $color, id: $id, zIndex: $zIndex, fontFamily: $fontFamily)';
  }
}

/// @nodoc
abstract mixin class $TextNodeCopyWith<$Res> {
  factory $TextNodeCopyWith(TextNode value, $Res Function(TextNode) _then) =
      _$TextNodeCopyWithImpl;
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
class _$TextNodeCopyWithImpl<$Res> implements $TextNodeCopyWith<$Res> {
  _$TextNodeCopyWithImpl(this._self, this._then);

  final TextNode _self;
  final $Res Function(TextNode) _then;

  /// Create a copy of TextNode
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

/// Adds pattern-matching-related methods to [TextNode].
extension TextNodePatterns on TextNode {
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
    TResult Function(_TextNode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TextNode() when $default != null:
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
    TResult Function(_TextNode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextNode():
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
    TResult? Function(_TextNode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextNode() when $default != null:
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
      case _TextNode() when $default != null:
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
      case _TextNode():
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
      case _TextNode() when $default != null:
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

class _TextNode extends TextNode {
  _TextNode({
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

  /// Create a copy of TextNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TextNodeCopyWith<_TextNode> get copyWith =>
      __$TextNodeCopyWithImpl<_TextNode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TextNode &&
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
    return 'TextNode(text: $text, position: $position, fontSize: $fontSize, color: $color, id: $id, zIndex: $zIndex, fontFamily: $fontFamily)';
  }
}

/// @nodoc
abstract mixin class _$TextNodeCopyWith<$Res>
    implements $TextNodeCopyWith<$Res> {
  factory _$TextNodeCopyWith(_TextNode value, $Res Function(_TextNode) _then) =
      __$TextNodeCopyWithImpl;
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
class __$TextNodeCopyWithImpl<$Res> implements _$TextNodeCopyWith<$Res> {
  __$TextNodeCopyWithImpl(this._self, this._then);

  final _TextNode _self;
  final $Res Function(_TextNode) _then;

  /// Create a copy of TextNode
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
      _TextNode(
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
mixin _$ImageNode {
  String get imageUrl; // or local path / bytes identifier
  Rect get rect;
  int get id;
  int get zIndex;

  /// Create a copy of ImageNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImageNodeCopyWith<ImageNode> get copyWith =>
      _$ImageNodeCopyWithImpl<ImageNode>(this as ImageNode, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageNode &&
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
    return 'ImageNode(imageUrl: $imageUrl, rect: $rect, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class $ImageNodeCopyWith<$Res> {
  factory $ImageNodeCopyWith(ImageNode value, $Res Function(ImageNode) _then) =
      _$ImageNodeCopyWithImpl;
  @useResult
  $Res call({String imageUrl, Rect rect, int id, int zIndex});
}

/// @nodoc
class _$ImageNodeCopyWithImpl<$Res> implements $ImageNodeCopyWith<$Res> {
  _$ImageNodeCopyWithImpl(this._self, this._then);

  final ImageNode _self;
  final $Res Function(ImageNode) _then;

  /// Create a copy of ImageNode
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

/// Adds pattern-matching-related methods to [ImageNode].
extension ImageNodePatterns on ImageNode {
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
    TResult Function(_ImageNode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImageNode() when $default != null:
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
    TResult Function(_ImageNode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageNode():
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
    TResult? Function(_ImageNode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageNode() when $default != null:
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
      case _ImageNode() when $default != null:
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
      case _ImageNode():
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
      case _ImageNode() when $default != null:
        return $default(_that.imageUrl, _that.rect, _that.id, _that.zIndex);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ImageNode extends ImageNode {
  _ImageNode({
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

  /// Create a copy of ImageNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImageNodeCopyWith<_ImageNode> get copyWith =>
      __$ImageNodeCopyWithImpl<_ImageNode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImageNode &&
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
    return 'ImageNode(imageUrl: $imageUrl, rect: $rect, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class _$ImageNodeCopyWith<$Res>
    implements $ImageNodeCopyWith<$Res> {
  factory _$ImageNodeCopyWith(
    _ImageNode value,
    $Res Function(_ImageNode) _then,
  ) = __$ImageNodeCopyWithImpl;
  @override
  @useResult
  $Res call({String imageUrl, Rect rect, int id, int zIndex});
}

/// @nodoc
class __$ImageNodeCopyWithImpl<$Res> implements _$ImageNodeCopyWith<$Res> {
  __$ImageNodeCopyWithImpl(this._self, this._then);

  final _ImageNode _self;
  final $Res Function(_ImageNode) _then;

  /// Create a copy of ImageNode
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
      _ImageNode(
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
mixin _$GroupNode {
  List<int> get childrenIds;
  Rect get rect;
  int get id;
  int get zIndex;

  /// Create a copy of GroupNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GroupNodeCopyWith<GroupNode> get copyWith =>
      _$GroupNodeCopyWithImpl<GroupNode>(this as GroupNode, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GroupNode &&
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
    return 'GroupNode(childrenIds: $childrenIds, rect: $rect, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class $GroupNodeCopyWith<$Res> {
  factory $GroupNodeCopyWith(GroupNode value, $Res Function(GroupNode) _then) =
      _$GroupNodeCopyWithImpl;
  @useResult
  $Res call({List<int> childrenIds, Rect rect, int id, int zIndex});
}

/// @nodoc
class _$GroupNodeCopyWithImpl<$Res> implements $GroupNodeCopyWith<$Res> {
  _$GroupNodeCopyWithImpl(this._self, this._then);

  final GroupNode _self;
  final $Res Function(GroupNode) _then;

  /// Create a copy of GroupNode
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

/// Adds pattern-matching-related methods to [GroupNode].
extension GroupNodePatterns on GroupNode {
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
    TResult Function(_GroupNode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GroupNode() when $default != null:
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
    TResult Function(_GroupNode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupNode():
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
    TResult? Function(_GroupNode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupNode() when $default != null:
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
      case _GroupNode() when $default != null:
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
      case _GroupNode():
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
      case _GroupNode() when $default != null:
        return $default(_that.childrenIds, _that.rect, _that.id, _that.zIndex);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GroupNode extends GroupNode {
  _GroupNode({
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

  /// Create a copy of GroupNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GroupNodeCopyWith<_GroupNode> get copyWith =>
      __$GroupNodeCopyWithImpl<_GroupNode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GroupNode &&
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
    return 'GroupNode(childrenIds: $childrenIds, rect: $rect, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class _$GroupNodeCopyWith<$Res>
    implements $GroupNodeCopyWith<$Res> {
  factory _$GroupNodeCopyWith(
    _GroupNode value,
    $Res Function(_GroupNode) _then,
  ) = __$GroupNodeCopyWithImpl;
  @override
  @useResult
  $Res call({List<int> childrenIds, Rect rect, int id, int zIndex});
}

/// @nodoc
class __$GroupNodeCopyWithImpl<$Res> implements _$GroupNodeCopyWith<$Res> {
  __$GroupNodeCopyWithImpl(this._self, this._then);

  final _GroupNode _self;
  final $Res Function(_GroupNode) _then;

  /// Create a copy of GroupNode
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
      _GroupNode(
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
mixin _$ListOfPointNode {
  List<Offset> get points;
  double get strokeWidth;
  int get color;
  int get id;
  int get zIndex;

  /// Create a copy of ListOfPointNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListOfPointNodeCopyWith<ListOfPointNode> get copyWith =>
      _$ListOfPointNodeCopyWithImpl<ListOfPointNode>(
        this as ListOfPointNode,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListOfPointNode &&
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
    return 'ListOfPointNode(points: $points, strokeWidth: $strokeWidth, color: $color, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class $ListOfPointNodeCopyWith<$Res> {
  factory $ListOfPointNodeCopyWith(
    ListOfPointNode value,
    $Res Function(ListOfPointNode) _then,
  ) = _$ListOfPointNodeCopyWithImpl;
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
class _$ListOfPointNodeCopyWithImpl<$Res>
    implements $ListOfPointNodeCopyWith<$Res> {
  _$ListOfPointNodeCopyWithImpl(this._self, this._then);

  final ListOfPointNode _self;
  final $Res Function(ListOfPointNode) _then;

  /// Create a copy of ListOfPointNode
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

/// Adds pattern-matching-related methods to [ListOfPointNode].
extension ListOfPointNodePatterns on ListOfPointNode {
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
    TResult Function(_ListOfPointNode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ListOfPointNode() when $default != null:
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
    TResult Function(_ListOfPointNode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListOfPointNode():
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
    TResult? Function(_ListOfPointNode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListOfPointNode() when $default != null:
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
      case _ListOfPointNode() when $default != null:
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
      case _ListOfPointNode():
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
      case _ListOfPointNode() when $default != null:
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

class _ListOfPointNode extends ListOfPointNode {
  _ListOfPointNode({
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

  /// Create a copy of ListOfPointNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ListOfPointNodeCopyWith<_ListOfPointNode> get copyWith =>
      __$ListOfPointNodeCopyWithImpl<_ListOfPointNode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListOfPointNode &&
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
    return 'ListOfPointNode(points: $points, strokeWidth: $strokeWidth, color: $color, id: $id, zIndex: $zIndex)';
  }
}

/// @nodoc
abstract mixin class _$ListOfPointNodeCopyWith<$Res>
    implements $ListOfPointNodeCopyWith<$Res> {
  factory _$ListOfPointNodeCopyWith(
    _ListOfPointNode value,
    $Res Function(_ListOfPointNode) _then,
  ) = __$ListOfPointNodeCopyWithImpl;
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
class __$ListOfPointNodeCopyWithImpl<$Res>
    implements _$ListOfPointNodeCopyWith<$Res> {
  __$ListOfPointNodeCopyWithImpl(this._self, this._then);

  final _ListOfPointNode _self;
  final $Res Function(_ListOfPointNode) _then;

  /// Create a copy of ListOfPointNode
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
      _ListOfPointNode(
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
