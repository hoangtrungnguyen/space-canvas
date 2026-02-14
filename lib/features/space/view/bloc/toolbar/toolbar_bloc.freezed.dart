// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toolbar_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ToolbarEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ToolbarEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ToolbarEvent()';
  }
}

/// @nodoc
class $ToolbarEventCopyWith<$Res> {
  $ToolbarEventCopyWith(ToolbarEvent _, $Res Function(ToolbarEvent) __);
}

/// Adds pattern-matching-related methods to [ToolbarEvent].
extension ToolbarEventPatterns on ToolbarEvent {
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
    TResult Function(_Selected value)? selected,
    TResult Function(_ShapeSelected value)? shapeSelected,
    TResult Function(_ToDefault value)? toDefault,
    TResult Function(_UpdateDrawingObject value)? updateDrawingObject,
    TResult Function(_StartedEditing value)? startedEditing,
    TResult Function(_EndedEditing value)? endedEditing,
    TResult Function(_ToggledSelectionTool value)? toggledSelectionTool,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Selected() when selected != null:
        return selected(_that);
      case _ShapeSelected() when shapeSelected != null:
        return shapeSelected(_that);
      case _ToDefault() when toDefault != null:
        return toDefault(_that);
      case _UpdateDrawingObject() when updateDrawingObject != null:
        return updateDrawingObject(_that);
      case _StartedEditing() when startedEditing != null:
        return startedEditing(_that);
      case _EndedEditing() when endedEditing != null:
        return endedEditing(_that);
      case _ToggledSelectionTool() when toggledSelectionTool != null:
        return toggledSelectionTool(_that);
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
    required TResult Function(_Selected value) selected,
    required TResult Function(_ShapeSelected value) shapeSelected,
    required TResult Function(_ToDefault value) toDefault,
    required TResult Function(_UpdateDrawingObject value) updateDrawingObject,
    required TResult Function(_StartedEditing value) startedEditing,
    required TResult Function(_EndedEditing value) endedEditing,
    required TResult Function(_ToggledSelectionTool value) toggledSelectionTool,
  }) {
    final _that = this;
    switch (_that) {
      case _Selected():
        return selected(_that);
      case _ShapeSelected():
        return shapeSelected(_that);
      case _ToDefault():
        return toDefault(_that);
      case _UpdateDrawingObject():
        return updateDrawingObject(_that);
      case _StartedEditing():
        return startedEditing(_that);
      case _EndedEditing():
        return endedEditing(_that);
      case _ToggledSelectionTool():
        return toggledSelectionTool(_that);
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
    TResult? Function(_Selected value)? selected,
    TResult? Function(_ShapeSelected value)? shapeSelected,
    TResult? Function(_ToDefault value)? toDefault,
    TResult? Function(_UpdateDrawingObject value)? updateDrawingObject,
    TResult? Function(_StartedEditing value)? startedEditing,
    TResult? Function(_EndedEditing value)? endedEditing,
    TResult? Function(_ToggledSelectionTool value)? toggledSelectionTool,
  }) {
    final _that = this;
    switch (_that) {
      case _Selected() when selected != null:
        return selected(_that);
      case _ShapeSelected() when shapeSelected != null:
        return shapeSelected(_that);
      case _ToDefault() when toDefault != null:
        return toDefault(_that);
      case _UpdateDrawingObject() when updateDrawingObject != null:
        return updateDrawingObject(_that);
      case _StartedEditing() when startedEditing != null:
        return startedEditing(_that);
      case _EndedEditing() when endedEditing != null:
        return endedEditing(_that);
      case _ToggledSelectionTool() when toggledSelectionTool != null:
        return toggledSelectionTool(_that);
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
    TResult Function(SpaceTool tool)? selected,
    TResult Function(ShapeType type)? shapeSelected,
    TResult Function()? toDefault,
    TResult Function(Node? object)? updateDrawingObject,
    TResult Function(TextNode object)? startedEditing,
    TResult Function()? endedEditing,
    TResult Function()? toggledSelectionTool,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Selected() when selected != null:
        return selected(_that.tool);
      case _ShapeSelected() when shapeSelected != null:
        return shapeSelected(_that.type);
      case _ToDefault() when toDefault != null:
        return toDefault();
      case _UpdateDrawingObject() when updateDrawingObject != null:
        return updateDrawingObject(_that.object);
      case _StartedEditing() when startedEditing != null:
        return startedEditing(_that.object);
      case _EndedEditing() when endedEditing != null:
        return endedEditing();
      case _ToggledSelectionTool() when toggledSelectionTool != null:
        return toggledSelectionTool();
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
    required TResult Function(SpaceTool tool) selected,
    required TResult Function(ShapeType type) shapeSelected,
    required TResult Function() toDefault,
    required TResult Function(Node? object) updateDrawingObject,
    required TResult Function(TextNode object) startedEditing,
    required TResult Function() endedEditing,
    required TResult Function() toggledSelectionTool,
  }) {
    final _that = this;
    switch (_that) {
      case _Selected():
        return selected(_that.tool);
      case _ShapeSelected():
        return shapeSelected(_that.type);
      case _ToDefault():
        return toDefault();
      case _UpdateDrawingObject():
        return updateDrawingObject(_that.object);
      case _StartedEditing():
        return startedEditing(_that.object);
      case _EndedEditing():
        return endedEditing();
      case _ToggledSelectionTool():
        return toggledSelectionTool();
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
    TResult? Function(SpaceTool tool)? selected,
    TResult? Function(ShapeType type)? shapeSelected,
    TResult? Function()? toDefault,
    TResult? Function(Node? object)? updateDrawingObject,
    TResult? Function(TextNode object)? startedEditing,
    TResult? Function()? endedEditing,
    TResult? Function()? toggledSelectionTool,
  }) {
    final _that = this;
    switch (_that) {
      case _Selected() when selected != null:
        return selected(_that.tool);
      case _ShapeSelected() when shapeSelected != null:
        return shapeSelected(_that.type);
      case _ToDefault() when toDefault != null:
        return toDefault();
      case _UpdateDrawingObject() when updateDrawingObject != null:
        return updateDrawingObject(_that.object);
      case _StartedEditing() when startedEditing != null:
        return startedEditing(_that.object);
      case _EndedEditing() when endedEditing != null:
        return endedEditing();
      case _ToggledSelectionTool() when toggledSelectionTool != null:
        return toggledSelectionTool();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Selected implements ToolbarEvent {
  const _Selected(this.tool);

  final SpaceTool tool;

  /// Create a copy of ToolbarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SelectedCopyWith<_Selected> get copyWith =>
      __$SelectedCopyWithImpl<_Selected>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Selected &&
            (identical(other.tool, tool) || other.tool == tool));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tool);

  @override
  String toString() {
    return 'ToolbarEvent.selected(tool: $tool)';
  }
}

/// @nodoc
abstract mixin class _$SelectedCopyWith<$Res>
    implements $ToolbarEventCopyWith<$Res> {
  factory _$SelectedCopyWith(_Selected value, $Res Function(_Selected) _then) =
      __$SelectedCopyWithImpl;
  @useResult
  $Res call({SpaceTool tool});
}

/// @nodoc
class __$SelectedCopyWithImpl<$Res> implements _$SelectedCopyWith<$Res> {
  __$SelectedCopyWithImpl(this._self, this._then);

  final _Selected _self;
  final $Res Function(_Selected) _then;

  /// Create a copy of ToolbarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? tool = null}) {
    return _then(
      _Selected(
        null == tool
            ? _self.tool
            : tool // ignore: cast_nullable_to_non_nullable
                as SpaceTool,
      ),
    );
  }
}

/// @nodoc

class _ShapeSelected implements ToolbarEvent {
  const _ShapeSelected(this.type);

  final ShapeType type;

  /// Create a copy of ToolbarEvent
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
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type);

  @override
  String toString() {
    return 'ToolbarEvent.shapeSelected(type: $type)';
  }
}

/// @nodoc
abstract mixin class _$ShapeSelectedCopyWith<$Res>
    implements $ToolbarEventCopyWith<$Res> {
  factory _$ShapeSelectedCopyWith(
    _ShapeSelected value,
    $Res Function(_ShapeSelected) _then,
  ) = __$ShapeSelectedCopyWithImpl;
  @useResult
  $Res call({ShapeType type});
}

/// @nodoc
class __$ShapeSelectedCopyWithImpl<$Res>
    implements _$ShapeSelectedCopyWith<$Res> {
  __$ShapeSelectedCopyWithImpl(this._self, this._then);

  final _ShapeSelected _self;
  final $Res Function(_ShapeSelected) _then;

  /// Create a copy of ToolbarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? type = null}) {
    return _then(
      _ShapeSelected(
        null == type
            ? _self.type
            : type // ignore: cast_nullable_to_non_nullable
                as ShapeType,
      ),
    );
  }
}

/// @nodoc

class _ToDefault implements ToolbarEvent {
  const _ToDefault();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ToDefault);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ToolbarEvent.toDefault()';
  }
}

/// @nodoc
class _$ToDefaultCopyWith<$Res> implements $ToolbarEventCopyWith<$Res> {
  _$ToDefaultCopyWith(_ToDefault _, $Res Function(_ToDefault) __);
}

/// @nodoc
class __$ToDefaultCopyWithImpl<$Res> implements _$ToDefaultCopyWith<$Res> {
  __$ToDefaultCopyWithImpl(this._self, this._then);

  final _ToDefault _self;
  final $Res Function(_ToDefault) _then;
}

/// @nodoc

class _UpdateDrawingObject implements ToolbarEvent {
  const _UpdateDrawingObject(this.object);

  final Node? object;

  /// Create a copy of ToolbarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateDrawingObjectCopyWith<_UpdateDrawingObject> get copyWith =>
      __$UpdateDrawingObjectCopyWithImpl<_UpdateDrawingObject>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateDrawingObject &&
            (identical(other.object, object) || other.object == object));
  }

  @override
  int get hashCode => Object.hash(runtimeType, object);

  @override
  String toString() {
    return 'ToolbarEvent.updateDrawingObject(object: $object)';
  }
}

/// @nodoc
abstract mixin class _$UpdateDrawingObjectCopyWith<$Res>
    implements $ToolbarEventCopyWith<$Res> {
  factory _$UpdateDrawingObjectCopyWith(
    _UpdateDrawingObject value,
    $Res Function(_UpdateDrawingObject) _then,
  ) = __$UpdateDrawingObjectCopyWithImpl;
  @useResult
  $Res call({Node? object});
}

/// @nodoc
class __$UpdateDrawingObjectCopyWithImpl<$Res>
    implements _$UpdateDrawingObjectCopyWith<$Res> {
  __$UpdateDrawingObjectCopyWithImpl(this._self, this._then);

  final _UpdateDrawingObject _self;
  final $Res Function(_UpdateDrawingObject) _then;

  /// Create a copy of ToolbarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? object = freezed}) {
    return _then(
      _UpdateDrawingObject(
        freezed == object
            ? _self.object
            : object // ignore: cast_nullable_to_non_nullable
                as Node?,
      ),
    );
  }
}

/// @nodoc

class _StartedEditing implements ToolbarEvent {
  const _StartedEditing(this.object);

  final TextNode object;

  /// Create a copy of ToolbarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StartedEditingCopyWith<_StartedEditing> get copyWith =>
      __$StartedEditingCopyWithImpl<_StartedEditing>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StartedEditing &&
            (identical(other.object, object) || other.object == object));
  }

  @override
  int get hashCode => Object.hash(runtimeType, object);

  @override
  String toString() {
    return 'ToolbarEvent.startedEditing(object: $object)';
  }
}

/// @nodoc
abstract mixin class _$StartedEditingCopyWith<$Res>
    implements $ToolbarEventCopyWith<$Res> {
  factory _$StartedEditingCopyWith(
    _StartedEditing value,
    $Res Function(_StartedEditing) _then,
  ) = __$StartedEditingCopyWithImpl;
  @useResult
  $Res call({TextNode object});

  $TextNodeCopyWith<$Res> get object;
}

/// @nodoc
class __$StartedEditingCopyWithImpl<$Res>
    implements _$StartedEditingCopyWith<$Res> {
  __$StartedEditingCopyWithImpl(this._self, this._then);

  final _StartedEditing _self;
  final $Res Function(_StartedEditing) _then;

  /// Create a copy of ToolbarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? object = null}) {
    return _then(
      _StartedEditing(
        null == object
            ? _self.object
            : object // ignore: cast_nullable_to_non_nullable
                as TextNode,
      ),
    );
  }

  /// Create a copy of ToolbarEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextNodeCopyWith<$Res> get object {
    return $TextNodeCopyWith<$Res>(_self.object, (value) {
      return _then(_self.copyWith(object: value));
    });
  }
}

/// @nodoc

class _EndedEditing implements ToolbarEvent {
  const _EndedEditing();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _EndedEditing);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ToolbarEvent.endedEditing()';
  }
}

/// @nodoc
class _$EndedEditingCopyWith<$Res> implements $ToolbarEventCopyWith<$Res> {
  _$EndedEditingCopyWith(_EndedEditing _, $Res Function(_EndedEditing) __);
}

/// @nodoc
class __$EndedEditingCopyWithImpl<$Res>
    implements _$EndedEditingCopyWith<$Res> {
  __$EndedEditingCopyWithImpl(this._self, this._then);

  final _EndedEditing _self;
  final $Res Function(_EndedEditing) _then;
}

/// @nodoc

class _ToggledSelectionTool implements ToolbarEvent {
  const _ToggledSelectionTool();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ToggledSelectionTool);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ToolbarEvent.toggledSelectionTool()';
  }
}

/// @nodoc
class _$ToggledSelectionToolCopyWith<$Res>
    implements $ToolbarEventCopyWith<$Res> {
  _$ToggledSelectionToolCopyWith(
    _ToggledSelectionTool _,
    $Res Function(_ToggledSelectionTool) __,
  );
}

/// @nodoc
class __$ToggledSelectionToolCopyWithImpl<$Res>
    implements _$ToggledSelectionToolCopyWith<$Res> {
  __$ToggledSelectionToolCopyWithImpl(this._self, this._then);

  final _ToggledSelectionTool _self;
  final $Res Function(_ToggledSelectionTool) _then;
}

/// @nodoc
mixin _$ToolbarState {
  SpaceTool get tool;
  ShapeType get activeShapeType;
  Node? get activeDrawingObject;
  TextNode? get editingObject;

  /// Create a copy of ToolbarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ToolbarStateCopyWith<ToolbarState> get copyWith =>
      _$ToolbarStateCopyWithImpl<ToolbarState>(
        this as ToolbarState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ToolbarState &&
            (identical(other.tool, tool) || other.tool == tool) &&
            (identical(other.activeShapeType, activeShapeType) ||
                other.activeShapeType == activeShapeType) &&
            (identical(other.activeDrawingObject, activeDrawingObject) ||
                other.activeDrawingObject == activeDrawingObject) &&
            (identical(other.editingObject, editingObject) ||
                other.editingObject == editingObject));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    tool,
    activeShapeType,
    activeDrawingObject,
    editingObject,
  );

  @override
  String toString() {
    return 'ToolbarState(tool: $tool, activeShapeType: $activeShapeType, activeDrawingObject: $activeDrawingObject, editingObject: $editingObject)';
  }
}

/// @nodoc
abstract mixin class $ToolbarStateCopyWith<$Res> {
  factory $ToolbarStateCopyWith(
    ToolbarState value,
    $Res Function(ToolbarState) _then,
  ) = _$ToolbarStateCopyWithImpl;
  @useResult
  $Res call({
    SpaceTool tool,
    ShapeType activeShapeType,
    Node? activeDrawingObject,
    TextNode? editingObject,
  });

  $TextNodeCopyWith<$Res>? get editingObject;
}

/// @nodoc
class _$ToolbarStateCopyWithImpl<$Res> implements $ToolbarStateCopyWith<$Res> {
  _$ToolbarStateCopyWithImpl(this._self, this._then);

  final ToolbarState _self;
  final $Res Function(ToolbarState) _then;

  /// Create a copy of ToolbarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tool = null,
    Object? activeShapeType = null,
    Object? activeDrawingObject = freezed,
    Object? editingObject = freezed,
  }) {
    return _then(
      _self.copyWith(
        tool:
            null == tool
                ? _self.tool
                : tool // ignore: cast_nullable_to_non_nullable
                    as SpaceTool,
        activeShapeType:
            null == activeShapeType
                ? _self.activeShapeType
                : activeShapeType // ignore: cast_nullable_to_non_nullable
                    as ShapeType,
        activeDrawingObject:
            freezed == activeDrawingObject
                ? _self.activeDrawingObject
                : activeDrawingObject // ignore: cast_nullable_to_non_nullable
                    as Node?,
        editingObject:
            freezed == editingObject
                ? _self.editingObject
                : editingObject // ignore: cast_nullable_to_non_nullable
                    as TextNode?,
      ),
    );
  }

  /// Create a copy of ToolbarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextNodeCopyWith<$Res>? get editingObject {
    if (_self.editingObject == null) {
      return null;
    }

    return $TextNodeCopyWith<$Res>(_self.editingObject!, (value) {
      return _then(_self.copyWith(editingObject: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ToolbarState].
extension ToolbarStatePatterns on ToolbarState {
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
    TResult Function(_ToolbarState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ToolbarState() when $default != null:
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
    TResult Function(_ToolbarState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ToolbarState():
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
    TResult? Function(_ToolbarState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ToolbarState() when $default != null:
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
      SpaceTool tool,
      ShapeType activeShapeType,
      Node? activeDrawingObject,
      TextNode? editingObject,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ToolbarState() when $default != null:
        return $default(
          _that.tool,
          _that.activeShapeType,
          _that.activeDrawingObject,
          _that.editingObject,
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
      SpaceTool tool,
      ShapeType activeShapeType,
      Node? activeDrawingObject,
      TextNode? editingObject,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ToolbarState():
        return $default(
          _that.tool,
          _that.activeShapeType,
          _that.activeDrawingObject,
          _that.editingObject,
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
      SpaceTool tool,
      ShapeType activeShapeType,
      Node? activeDrawingObject,
      TextNode? editingObject,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ToolbarState() when $default != null:
        return $default(
          _that.tool,
          _that.activeShapeType,
          _that.activeDrawingObject,
          _that.editingObject,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ToolbarState implements ToolbarState {
  _ToolbarState({
    this.tool = SpaceTool.pan,
    this.activeShapeType = ShapeType.rectangle,
    this.activeDrawingObject,
    this.editingObject,
  });

  @override
  @JsonKey()
  final SpaceTool tool;
  @override
  @JsonKey()
  final ShapeType activeShapeType;
  @override
  final Node? activeDrawingObject;
  @override
  final TextNode? editingObject;

  /// Create a copy of ToolbarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ToolbarStateCopyWith<_ToolbarState> get copyWith =>
      __$ToolbarStateCopyWithImpl<_ToolbarState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ToolbarState &&
            (identical(other.tool, tool) || other.tool == tool) &&
            (identical(other.activeShapeType, activeShapeType) ||
                other.activeShapeType == activeShapeType) &&
            (identical(other.activeDrawingObject, activeDrawingObject) ||
                other.activeDrawingObject == activeDrawingObject) &&
            (identical(other.editingObject, editingObject) ||
                other.editingObject == editingObject));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    tool,
    activeShapeType,
    activeDrawingObject,
    editingObject,
  );

  @override
  String toString() {
    return 'ToolbarState(tool: $tool, activeShapeType: $activeShapeType, activeDrawingObject: $activeDrawingObject, editingObject: $editingObject)';
  }
}

/// @nodoc
abstract mixin class _$ToolbarStateCopyWith<$Res>
    implements $ToolbarStateCopyWith<$Res> {
  factory _$ToolbarStateCopyWith(
    _ToolbarState value,
    $Res Function(_ToolbarState) _then,
  ) = __$ToolbarStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    SpaceTool tool,
    ShapeType activeShapeType,
    Node? activeDrawingObject,
    TextNode? editingObject,
  });

  @override
  $TextNodeCopyWith<$Res>? get editingObject;
}

/// @nodoc
class __$ToolbarStateCopyWithImpl<$Res>
    implements _$ToolbarStateCopyWith<$Res> {
  __$ToolbarStateCopyWithImpl(this._self, this._then);

  final _ToolbarState _self;
  final $Res Function(_ToolbarState) _then;

  /// Create a copy of ToolbarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tool = null,
    Object? activeShapeType = null,
    Object? activeDrawingObject = freezed,
    Object? editingObject = freezed,
  }) {
    return _then(
      _ToolbarState(
        tool:
            null == tool
                ? _self.tool
                : tool // ignore: cast_nullable_to_non_nullable
                    as SpaceTool,
        activeShapeType:
            null == activeShapeType
                ? _self.activeShapeType
                : activeShapeType // ignore: cast_nullable_to_non_nullable
                    as ShapeType,
        activeDrawingObject:
            freezed == activeDrawingObject
                ? _self.activeDrawingObject
                : activeDrawingObject // ignore: cast_nullable_to_non_nullable
                    as Node?,
        editingObject:
            freezed == editingObject
                ? _self.editingObject
                : editingObject // ignore: cast_nullable_to_non_nullable
                    as TextNode?,
      ),
    );
  }

  /// Create a copy of ToolbarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextNodeCopyWith<$Res>? get editingObject {
    if (_self.editingObject == null) {
      return null;
    }

    return $TextNodeCopyWith<$Res>(_self.editingObject!, (value) {
      return _then(_self.copyWith(editingObject: value));
    });
  }
}
