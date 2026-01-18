// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PageEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PageEvent()';
  }
}

/// @nodoc
class $PageEventCopyWith<$Res> {
  $PageEventCopyWith(PageEvent _, $Res Function(PageEvent) __);
}

/// Adds pattern-matching-related methods to [PageEvent].
extension PageEventPatterns on PageEvent {
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
    TResult Function(PageLoad value)? load,
    TResult Function(PageSave value)? save,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case PageLoad() when load != null:
        return load(_that);
      case PageSave() when save != null:
        return save(_that);
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
    required TResult Function(PageLoad value) load,
    required TResult Function(PageSave value) save,
  }) {
    final _that = this;
    switch (_that) {
      case PageLoad():
        return load(_that);
      case PageSave():
        return save(_that);
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
    TResult? Function(PageLoad value)? load,
    TResult? Function(PageSave value)? save,
  }) {
    final _that = this;
    switch (_that) {
      case PageLoad() when load != null:
        return load(_that);
      case PageSave() when save != null:
        return save(_that);
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
    TResult Function()? load,
    TResult Function()? save,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case PageLoad() when load != null:
        return load();
      case PageSave() when save != null:
        return save();
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
    required TResult Function() load,
    required TResult Function() save,
  }) {
    final _that = this;
    switch (_that) {
      case PageLoad():
        return load();
      case PageSave():
        return save();
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
    TResult? Function()? load,
    TResult? Function()? save,
  }) {
    final _that = this;
    switch (_that) {
      case PageLoad() when load != null:
        return load();
      case PageSave() when save != null:
        return save();
      case _:
        return null;
    }
  }
}

/// @nodoc

class PageLoad implements PageEvent {
  const PageLoad();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PageLoad);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PageEvent.load()';
  }
}

/// @nodoc
class $PageLoadCopyWith<$Res> implements $PageEventCopyWith<$Res> {
  $PageLoadCopyWith(PageLoad _, $Res Function(PageLoad) __);
}

/// @nodoc
class _$PageLoadCopyWithImpl<$Res> implements $PageLoadCopyWith<$Res> {
  _$PageLoadCopyWithImpl(this._self, this._then);

  final PageLoad _self;
  final $Res Function(PageLoad) _then;
}

/// @nodoc

class PageSave implements PageEvent {
  const PageSave();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PageSave);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PageEvent.save()';
  }
}

/// @nodoc
class $PageSaveCopyWith<$Res> implements $PageEventCopyWith<$Res> {
  $PageSaveCopyWith(PageSave _, $Res Function(PageSave) __);
}

/// @nodoc
class _$PageSaveCopyWithImpl<$Res> implements $PageSaveCopyWith<$Res> {
  _$PageSaveCopyWithImpl(this._self, this._then);

  final PageSave _self;
  final $Res Function(PageSave) _then;
}

/// @nodoc
mixin _$PageState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PageState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PageState()';
  }
}

/// @nodoc
class $PageStateCopyWith<$Res> {
  $PageStateCopyWith(PageState _, $Res Function(PageState) __);
}

/// Adds pattern-matching-related methods to [PageState].
extension PageStatePatterns on PageState {
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
    TResult Function(PageInit value)? init,
    TResult Function(PageInProgress value)? inProgress,
    TResult Function(PageFailure value)? failure,
    TResult Function(PageSuccess value)? success,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case PageInit() when init != null:
        return init(_that);
      case PageInProgress() when inProgress != null:
        return inProgress(_that);
      case PageFailure() when failure != null:
        return failure(_that);
      case PageSuccess() when success != null:
        return success(_that);
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
    required TResult Function(PageInit value) init,
    required TResult Function(PageInProgress value) inProgress,
    required TResult Function(PageFailure value) failure,
    required TResult Function(PageSuccess value) success,
  }) {
    final _that = this;
    switch (_that) {
      case PageInit():
        return init(_that);
      case PageInProgress():
        return inProgress(_that);
      case PageFailure():
        return failure(_that);
      case PageSuccess():
        return success(_that);
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
    TResult? Function(PageInit value)? init,
    TResult? Function(PageInProgress value)? inProgress,
    TResult? Function(PageFailure value)? failure,
    TResult? Function(PageSuccess value)? success,
  }) {
    final _that = this;
    switch (_that) {
      case PageInit() when init != null:
        return init(_that);
      case PageInProgress() when inProgress != null:
        return inProgress(_that);
      case PageFailure() when failure != null:
        return failure(_that);
      case PageSuccess() when success != null:
        return success(_that);
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
    TResult Function()? init,
    TResult Function()? inProgress,
    TResult Function(Exception error)? failure,
    TResult Function()? success,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case PageInit() when init != null:
        return init();
      case PageInProgress() when inProgress != null:
        return inProgress();
      case PageFailure() when failure != null:
        return failure(_that.error);
      case PageSuccess() when success != null:
        return success();
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
    required TResult Function() init,
    required TResult Function() inProgress,
    required TResult Function(Exception error) failure,
    required TResult Function() success,
  }) {
    final _that = this;
    switch (_that) {
      case PageInit():
        return init();
      case PageInProgress():
        return inProgress();
      case PageFailure():
        return failure(_that.error);
      case PageSuccess():
        return success();
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
    TResult? Function()? init,
    TResult? Function()? inProgress,
    TResult? Function(Exception error)? failure,
    TResult? Function()? success,
  }) {
    final _that = this;
    switch (_that) {
      case PageInit() when init != null:
        return init();
      case PageInProgress() when inProgress != null:
        return inProgress();
      case PageFailure() when failure != null:
        return failure(_that.error);
      case PageSuccess() when success != null:
        return success();
      case _:
        return null;
    }
  }
}

/// @nodoc

class PageInit implements PageState {
  const PageInit();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PageInit);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PageState.init()';
  }
}

/// @nodoc
class $PageInitCopyWith<$Res> implements $PageStateCopyWith<$Res> {
  $PageInitCopyWith(PageInit _, $Res Function(PageInit) __);
}

/// @nodoc
class _$PageInitCopyWithImpl<$Res> implements $PageInitCopyWith<$Res> {
  _$PageInitCopyWithImpl(this._self, this._then);

  final PageInit _self;
  final $Res Function(PageInit) _then;
}

/// @nodoc

class PageInProgress implements PageState {
  const PageInProgress();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PageInProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PageState.inProgress()';
  }
}

/// @nodoc
class $PageInProgressCopyWith<$Res> implements $PageStateCopyWith<$Res> {
  $PageInProgressCopyWith(PageInProgress _, $Res Function(PageInProgress) __);
}

/// @nodoc
class _$PageInProgressCopyWithImpl<$Res>
    implements $PageInProgressCopyWith<$Res> {
  _$PageInProgressCopyWithImpl(this._self, this._then);

  final PageInProgress _self;
  final $Res Function(PageInProgress) _then;
}

/// @nodoc

class PageFailure implements PageState {
  const PageFailure({required this.error});

  final Exception error;

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PageFailureCopyWith<PageFailure> get copyWith =>
      _$PageFailureCopyWithImpl<PageFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PageFailure &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'PageState.failure(error: $error)';
  }
}

/// @nodoc
abstract mixin class $PageFailureCopyWith<$Res>
    implements $PageStateCopyWith<$Res> {
  factory $PageFailureCopyWith(
    PageFailure value,
    $Res Function(PageFailure) _then,
  ) = _$PageFailureCopyWithImpl;
  @useResult
  $Res call({Exception error});
}

/// @nodoc
class _$PageFailureCopyWithImpl<$Res> implements $PageFailureCopyWith<$Res> {
  _$PageFailureCopyWithImpl(this._self, this._then);

  final PageFailure _self;
  final $Res Function(PageFailure) _then;

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? error = null}) {
    return _then(
      PageFailure(
        error:
            null == error
                ? _self.error
                : error // ignore: cast_nullable_to_non_nullable
                    as Exception,
      ),
    );
  }
}

/// @nodoc

class PageSuccess implements PageState {
  const PageSuccess();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PageSuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PageState.success()';
  }
}

/// @nodoc
class $PageSuccessCopyWith<$Res> implements $PageStateCopyWith<$Res> {
  $PageSuccessCopyWith(PageSuccess _, $Res Function(PageSuccess) __);
}

/// @nodoc
class _$PageSuccessCopyWithImpl<$Res> implements $PageSuccessCopyWith<$Res> {
  _$PageSuccessCopyWithImpl(this._self, this._then);

  final PageSuccess _self;
  final $Res Function(PageSuccess) _then;
}
