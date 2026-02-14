// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connector_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectorNode {
  int? get startNodeId;
  int? get endNodeId;
  Offset get startPoint;
  Offset get endPoint;
  double get strokeWidth;
  int get color;
  int get id;
  int get zIndex;

  /// Which edge of the start node this connector originates from.
  ConnectorEdge? get startLocation;

  /// Which edge of the end node this connector terminates at.
  ConnectorEdge? get endLocation;

  /// Create a copy of ConnectorNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectorNodeCopyWith<ConnectorNode> get copyWith =>
      _$ConnectorNodeCopyWithImpl<ConnectorNode>(
        this as ConnectorNode,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectorNode &&
            (identical(other.startNodeId, startNodeId) ||
                other.startNodeId == startNodeId) &&
            (identical(other.endNodeId, endNodeId) ||
                other.endNodeId == endNodeId) &&
            (identical(other.startPoint, startPoint) ||
                other.startPoint == startPoint) &&
            (identical(other.endPoint, endPoint) ||
                other.endPoint == endPoint) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex) &&
            (identical(other.startLocation, startLocation) ||
                other.startLocation == startLocation) &&
            (identical(other.endLocation, endLocation) ||
                other.endLocation == endLocation));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    startNodeId,
    endNodeId,
    startPoint,
    endPoint,
    strokeWidth,
    color,
    id,
    zIndex,
    startLocation,
    endLocation,
  );

  @override
  String toString() {
    return 'ConnectorNode(startNodeId: $startNodeId, endNodeId: $endNodeId, startPoint: $startPoint, endPoint: $endPoint, strokeWidth: $strokeWidth, color: $color, id: $id, zIndex: $zIndex, startLocation: $startLocation, endLocation: $endLocation)';
  }
}

/// @nodoc
abstract mixin class $ConnectorNodeCopyWith<$Res> {
  factory $ConnectorNodeCopyWith(
    ConnectorNode value,
    $Res Function(ConnectorNode) _then,
  ) = _$ConnectorNodeCopyWithImpl;
  @useResult
  $Res call({
    int? startNodeId,
    int? endNodeId,
    Offset startPoint,
    Offset endPoint,
    double strokeWidth,
    int color,
    int id,
    int zIndex,
    ConnectorEdge? startLocation,
    ConnectorEdge? endLocation,
  });
}

/// @nodoc
class _$ConnectorNodeCopyWithImpl<$Res>
    implements $ConnectorNodeCopyWith<$Res> {
  _$ConnectorNodeCopyWithImpl(this._self, this._then);

  final ConnectorNode _self;
  final $Res Function(ConnectorNode) _then;

  /// Create a copy of ConnectorNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startNodeId = freezed,
    Object? endNodeId = freezed,
    Object? startPoint = null,
    Object? endPoint = null,
    Object? strokeWidth = null,
    Object? color = null,
    Object? id = null,
    Object? zIndex = null,
    Object? startLocation = freezed,
    Object? endLocation = freezed,
  }) {
    return _then(
      _self.copyWith(
        startNodeId:
            freezed == startNodeId
                ? _self.startNodeId
                : startNodeId // ignore: cast_nullable_to_non_nullable
                    as int?,
        endNodeId:
            freezed == endNodeId
                ? _self.endNodeId
                : endNodeId // ignore: cast_nullable_to_non_nullable
                    as int?,
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
        startLocation:
            freezed == startLocation
                ? _self.startLocation
                : startLocation // ignore: cast_nullable_to_non_nullable
                    as ConnectorEdge?,
        endLocation:
            freezed == endLocation
                ? _self.endLocation
                : endLocation // ignore: cast_nullable_to_non_nullable
                    as ConnectorEdge?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [ConnectorNode].
extension ConnectorNodePatterns on ConnectorNode {
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
    TResult Function(_ConnectorNode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConnectorNode() when $default != null:
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
    TResult Function(_ConnectorNode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectorNode():
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
    TResult? Function(_ConnectorNode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectorNode() when $default != null:
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
      int? startNodeId,
      int? endNodeId,
      Offset startPoint,
      Offset endPoint,
      double strokeWidth,
      int color,
      int id,
      int zIndex,
      ConnectorEdge? startLocation,
      ConnectorEdge? endLocation,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConnectorNode() when $default != null:
        return $default(
          _that.startNodeId,
          _that.endNodeId,
          _that.startPoint,
          _that.endPoint,
          _that.strokeWidth,
          _that.color,
          _that.id,
          _that.zIndex,
          _that.startLocation,
          _that.endLocation,
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
      int? startNodeId,
      int? endNodeId,
      Offset startPoint,
      Offset endPoint,
      double strokeWidth,
      int color,
      int id,
      int zIndex,
      ConnectorEdge? startLocation,
      ConnectorEdge? endLocation,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectorNode():
        return $default(
          _that.startNodeId,
          _that.endNodeId,
          _that.startPoint,
          _that.endPoint,
          _that.strokeWidth,
          _that.color,
          _that.id,
          _that.zIndex,
          _that.startLocation,
          _that.endLocation,
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
      int? startNodeId,
      int? endNodeId,
      Offset startPoint,
      Offset endPoint,
      double strokeWidth,
      int color,
      int id,
      int zIndex,
      ConnectorEdge? startLocation,
      ConnectorEdge? endLocation,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectorNode() when $default != null:
        return $default(
          _that.startNodeId,
          _that.endNodeId,
          _that.startPoint,
          _that.endPoint,
          _that.strokeWidth,
          _that.color,
          _that.id,
          _that.zIndex,
          _that.startLocation,
          _that.endLocation,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ConnectorNode extends ConnectorNode {
  _ConnectorNode({
    this.startNodeId,
    this.endNodeId,
    required this.startPoint,
    required this.endPoint,
    required this.strokeWidth,
    required this.color,
    required this.id,
    this.zIndex = 0,
    this.startLocation,
    this.endLocation,
  }) : super._();

  @override
  final int? startNodeId;
  @override
  final int? endNodeId;
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

  /// Which edge of the start node this connector originates from.
  @override
  final ConnectorEdge? startLocation;

  /// Which edge of the end node this connector terminates at.
  @override
  final ConnectorEdge? endLocation;

  /// Create a copy of ConnectorNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectorNodeCopyWith<_ConnectorNode> get copyWith =>
      __$ConnectorNodeCopyWithImpl<_ConnectorNode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectorNode &&
            (identical(other.startNodeId, startNodeId) ||
                other.startNodeId == startNodeId) &&
            (identical(other.endNodeId, endNodeId) ||
                other.endNodeId == endNodeId) &&
            (identical(other.startPoint, startPoint) ||
                other.startPoint == startPoint) &&
            (identical(other.endPoint, endPoint) ||
                other.endPoint == endPoint) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex) &&
            (identical(other.startLocation, startLocation) ||
                other.startLocation == startLocation) &&
            (identical(other.endLocation, endLocation) ||
                other.endLocation == endLocation));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    startNodeId,
    endNodeId,
    startPoint,
    endPoint,
    strokeWidth,
    color,
    id,
    zIndex,
    startLocation,
    endLocation,
  );

  @override
  String toString() {
    return 'ConnectorNode(startNodeId: $startNodeId, endNodeId: $endNodeId, startPoint: $startPoint, endPoint: $endPoint, strokeWidth: $strokeWidth, color: $color, id: $id, zIndex: $zIndex, startLocation: $startLocation, endLocation: $endLocation)';
  }
}

/// @nodoc
abstract mixin class _$ConnectorNodeCopyWith<$Res>
    implements $ConnectorNodeCopyWith<$Res> {
  factory _$ConnectorNodeCopyWith(
    _ConnectorNode value,
    $Res Function(_ConnectorNode) _then,
  ) = __$ConnectorNodeCopyWithImpl;
  @override
  @useResult
  $Res call({
    int? startNodeId,
    int? endNodeId,
    Offset startPoint,
    Offset endPoint,
    double strokeWidth,
    int color,
    int id,
    int zIndex,
    ConnectorEdge? startLocation,
    ConnectorEdge? endLocation,
  });
}

/// @nodoc
class __$ConnectorNodeCopyWithImpl<$Res>
    implements _$ConnectorNodeCopyWith<$Res> {
  __$ConnectorNodeCopyWithImpl(this._self, this._then);

  final _ConnectorNode _self;
  final $Res Function(_ConnectorNode) _then;

  /// Create a copy of ConnectorNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? startNodeId = freezed,
    Object? endNodeId = freezed,
    Object? startPoint = null,
    Object? endPoint = null,
    Object? strokeWidth = null,
    Object? color = null,
    Object? id = null,
    Object? zIndex = null,
    Object? startLocation = freezed,
    Object? endLocation = freezed,
  }) {
    return _then(
      _ConnectorNode(
        startNodeId:
            freezed == startNodeId
                ? _self.startNodeId
                : startNodeId // ignore: cast_nullable_to_non_nullable
                    as int?,
        endNodeId:
            freezed == endNodeId
                ? _self.endNodeId
                : endNodeId // ignore: cast_nullable_to_non_nullable
                    as int?,
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
        startLocation:
            freezed == startLocation
                ? _self.startLocation
                : startLocation // ignore: cast_nullable_to_non_nullable
                    as ConnectorEdge?,
        endLocation:
            freezed == endLocation
                ? _self.endLocation
                : endLocation // ignore: cast_nullable_to_non_nullable
                    as ConnectorEdge?,
      ),
    );
  }
}
