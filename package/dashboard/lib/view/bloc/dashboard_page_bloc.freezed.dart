// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_page_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardPageEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DashboardPageEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DashboardPageEvent()';
  }
}

/// @nodoc
class $DashboardPageEventCopyWith<$Res> {
  $DashboardPageEventCopyWith(
    DashboardPageEvent _,
    $Res Function(DashboardPageEvent) __,
  );
}

/// Adds pattern-matching-related methods to [DashboardPageEvent].
extension DashboardPageEventPatterns on DashboardPageEvent {
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
    TResult Function(_Initialized value)? initialized,
    TResult Function(_CreatedSpace value)? createdSpace,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that);
      case _CreatedSpace() when createdSpace != null:
        return createdSpace(_that);
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
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_CreatedSpace value) createdSpace,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized():
        return initialized(_that);
      case _CreatedSpace():
        return createdSpace(_that);
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
    TResult? Function(_Initialized value)? initialized,
    TResult? Function(_CreatedSpace value)? createdSpace,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that);
      case _CreatedSpace() when createdSpace != null:
        return createdSpace(_that);
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
    TResult Function()? initialized,
    TResult Function()? createdSpace,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized();
      case _CreatedSpace() when createdSpace != null:
        return createdSpace();
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
    required TResult Function() initialized,
    required TResult Function() createdSpace,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized():
        return initialized();
      case _CreatedSpace():
        return createdSpace();
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
    TResult? Function()? initialized,
    TResult? Function()? createdSpace,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized();
      case _CreatedSpace() when createdSpace != null:
        return createdSpace();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initialized implements DashboardPageEvent {
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
    return 'DashboardPageEvent.initialized()';
  }
}

/// @nodoc
class _$InitializedCopyWith<$Res> implements $DashboardPageEventCopyWith<$Res> {
  _$InitializedCopyWith(_Initialized _, $Res Function(_Initialized) __);
}

/// @nodoc
class __$InitializedCopyWithImpl<$Res> implements _$InitializedCopyWith<$Res> {
  __$InitializedCopyWithImpl(this._self, this._then);

  final _Initialized _self;
  final $Res Function(_Initialized) _then;
}

/// @nodoc

class _CreatedSpace implements DashboardPageEvent {
  const _CreatedSpace();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _CreatedSpace);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DashboardPageEvent.createdSpace()';
  }
}

/// @nodoc
class _$CreatedSpaceCopyWith<$Res>
    implements $DashboardPageEventCopyWith<$Res> {
  _$CreatedSpaceCopyWith(_CreatedSpace _, $Res Function(_CreatedSpace) __);
}

/// @nodoc
class __$CreatedSpaceCopyWithImpl<$Res>
    implements _$CreatedSpaceCopyWith<$Res> {
  __$CreatedSpaceCopyWithImpl(this._self, this._then);

  final _CreatedSpace _self;
  final $Res Function(_CreatedSpace) _then;
}

/// @nodoc
mixin _$DashboardPageState {
  DashboardPageData get data;

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardPageStateCopyWith<DashboardPageState> get copyWith =>
      _$DashboardPageStateCopyWithImpl<DashboardPageState>(
        this as DashboardPageState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardPageState &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'DashboardPageState(data: $data)';
  }
}

/// @nodoc
abstract mixin class $DashboardPageStateCopyWith<$Res> {
  factory $DashboardPageStateCopyWith(
    DashboardPageState value,
    $Res Function(DashboardPageState) _then,
  ) = _$DashboardPageStateCopyWithImpl;
  @useResult
  $Res call({DashboardPageData data});

  $DashboardPageDataCopyWith<$Res> get data;
}

/// @nodoc
class _$DashboardPageStateCopyWithImpl<$Res>
    implements $DashboardPageStateCopyWith<$Res> {
  _$DashboardPageStateCopyWithImpl(this._self, this._then);

  final DashboardPageState _self;
  final $Res Function(DashboardPageState) _then;

  /// Create a copy of DashboardPageState
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
                    as DashboardPageData,
      ),
    );
  }

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardPageDataCopyWith<$Res> get data {
    return $DashboardPageDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DashboardPageState].
extension DashboardPageStatePatterns on DashboardPageState {
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
    TResult Function(DashboardPageStateInitial value)? initial,
    TResult Function(DashboardPageStateLoading value)? loading,
    TResult Function(DashboardPageStateSuccess value)? success,
    TResult Function(DashboardPageStateFailure value)? failure,
    TResult Function(DashboardPageStateCreatedSpaceSuccess value)?
    createSpaceSuccess,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DashboardPageStateInitial() when initial != null:
        return initial(_that);
      case DashboardPageStateLoading() when loading != null:
        return loading(_that);
      case DashboardPageStateSuccess() when success != null:
        return success(_that);
      case DashboardPageStateFailure() when failure != null:
        return failure(_that);
      case DashboardPageStateCreatedSpaceSuccess()
          when createSpaceSuccess != null:
        return createSpaceSuccess(_that);
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
    required TResult Function(DashboardPageStateInitial value) initial,
    required TResult Function(DashboardPageStateLoading value) loading,
    required TResult Function(DashboardPageStateSuccess value) success,
    required TResult Function(DashboardPageStateFailure value) failure,
    required TResult Function(DashboardPageStateCreatedSpaceSuccess value)
    createSpaceSuccess,
  }) {
    final _that = this;
    switch (_that) {
      case DashboardPageStateInitial():
        return initial(_that);
      case DashboardPageStateLoading():
        return loading(_that);
      case DashboardPageStateSuccess():
        return success(_that);
      case DashboardPageStateFailure():
        return failure(_that);
      case DashboardPageStateCreatedSpaceSuccess():
        return createSpaceSuccess(_that);
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
    TResult? Function(DashboardPageStateInitial value)? initial,
    TResult? Function(DashboardPageStateLoading value)? loading,
    TResult? Function(DashboardPageStateSuccess value)? success,
    TResult? Function(DashboardPageStateFailure value)? failure,
    TResult? Function(DashboardPageStateCreatedSpaceSuccess value)?
    createSpaceSuccess,
  }) {
    final _that = this;
    switch (_that) {
      case DashboardPageStateInitial() when initial != null:
        return initial(_that);
      case DashboardPageStateLoading() when loading != null:
        return loading(_that);
      case DashboardPageStateSuccess() when success != null:
        return success(_that);
      case DashboardPageStateFailure() when failure != null:
        return failure(_that);
      case DashboardPageStateCreatedSpaceSuccess()
          when createSpaceSuccess != null:
        return createSpaceSuccess(_that);
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
    TResult Function(DashboardPageData data)? initial,
    TResult Function(DashboardPageData data)? loading,
    TResult Function(DashboardPageData data)? success,
    TResult Function(DashboardPageData data, Exception failure)? failure,
    TResult Function(DashboardPageData data)? createSpaceSuccess,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DashboardPageStateInitial() when initial != null:
        return initial(_that.data);
      case DashboardPageStateLoading() when loading != null:
        return loading(_that.data);
      case DashboardPageStateSuccess() when success != null:
        return success(_that.data);
      case DashboardPageStateFailure() when failure != null:
        return failure(_that.data, _that.failure);
      case DashboardPageStateCreatedSpaceSuccess()
          when createSpaceSuccess != null:
        return createSpaceSuccess(_that.data);
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
    required TResult Function(DashboardPageData data) initial,
    required TResult Function(DashboardPageData data) loading,
    required TResult Function(DashboardPageData data) success,
    required TResult Function(DashboardPageData data, Exception failure)
    failure,
    required TResult Function(DashboardPageData data) createSpaceSuccess,
  }) {
    final _that = this;
    switch (_that) {
      case DashboardPageStateInitial():
        return initial(_that.data);
      case DashboardPageStateLoading():
        return loading(_that.data);
      case DashboardPageStateSuccess():
        return success(_that.data);
      case DashboardPageStateFailure():
        return failure(_that.data, _that.failure);
      case DashboardPageStateCreatedSpaceSuccess():
        return createSpaceSuccess(_that.data);
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
    TResult? Function(DashboardPageData data)? initial,
    TResult? Function(DashboardPageData data)? loading,
    TResult? Function(DashboardPageData data)? success,
    TResult? Function(DashboardPageData data, Exception failure)? failure,
    TResult? Function(DashboardPageData data)? createSpaceSuccess,
  }) {
    final _that = this;
    switch (_that) {
      case DashboardPageStateInitial() when initial != null:
        return initial(_that.data);
      case DashboardPageStateLoading() when loading != null:
        return loading(_that.data);
      case DashboardPageStateSuccess() when success != null:
        return success(_that.data);
      case DashboardPageStateFailure() when failure != null:
        return failure(_that.data, _that.failure);
      case DashboardPageStateCreatedSpaceSuccess()
          when createSpaceSuccess != null:
        return createSpaceSuccess(_that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc

class DashboardPageStateInitial implements DashboardPageState {
  const DashboardPageStateInitial(this.data);

  @override
  final DashboardPageData data;

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardPageStateInitialCopyWith<DashboardPageStateInitial> get copyWith =>
      _$DashboardPageStateInitialCopyWithImpl<DashboardPageStateInitial>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardPageStateInitial &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'DashboardPageState.initial(data: $data)';
  }
}

/// @nodoc
abstract mixin class $DashboardPageStateInitialCopyWith<$Res>
    implements $DashboardPageStateCopyWith<$Res> {
  factory $DashboardPageStateInitialCopyWith(
    DashboardPageStateInitial value,
    $Res Function(DashboardPageStateInitial) _then,
  ) = _$DashboardPageStateInitialCopyWithImpl;
  @override
  @useResult
  $Res call({DashboardPageData data});

  @override
  $DashboardPageDataCopyWith<$Res> get data;
}

/// @nodoc
class _$DashboardPageStateInitialCopyWithImpl<$Res>
    implements $DashboardPageStateInitialCopyWith<$Res> {
  _$DashboardPageStateInitialCopyWithImpl(this._self, this._then);

  final DashboardPageStateInitial _self;
  final $Res Function(DashboardPageStateInitial) _then;

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? data = null}) {
    return _then(
      DashboardPageStateInitial(
        null == data
            ? _self.data
            : data // ignore: cast_nullable_to_non_nullable
                as DashboardPageData,
      ),
    );
  }

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardPageDataCopyWith<$Res> get data {
    return $DashboardPageDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc

class DashboardPageStateLoading implements DashboardPageState {
  const DashboardPageStateLoading(this.data);

  @override
  final DashboardPageData data;

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardPageStateLoadingCopyWith<DashboardPageStateLoading> get copyWith =>
      _$DashboardPageStateLoadingCopyWithImpl<DashboardPageStateLoading>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardPageStateLoading &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'DashboardPageState.loading(data: $data)';
  }
}

/// @nodoc
abstract mixin class $DashboardPageStateLoadingCopyWith<$Res>
    implements $DashboardPageStateCopyWith<$Res> {
  factory $DashboardPageStateLoadingCopyWith(
    DashboardPageStateLoading value,
    $Res Function(DashboardPageStateLoading) _then,
  ) = _$DashboardPageStateLoadingCopyWithImpl;
  @override
  @useResult
  $Res call({DashboardPageData data});

  @override
  $DashboardPageDataCopyWith<$Res> get data;
}

/// @nodoc
class _$DashboardPageStateLoadingCopyWithImpl<$Res>
    implements $DashboardPageStateLoadingCopyWith<$Res> {
  _$DashboardPageStateLoadingCopyWithImpl(this._self, this._then);

  final DashboardPageStateLoading _self;
  final $Res Function(DashboardPageStateLoading) _then;

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? data = null}) {
    return _then(
      DashboardPageStateLoading(
        null == data
            ? _self.data
            : data // ignore: cast_nullable_to_non_nullable
                as DashboardPageData,
      ),
    );
  }

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardPageDataCopyWith<$Res> get data {
    return $DashboardPageDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc

class DashboardPageStateSuccess implements DashboardPageState {
  const DashboardPageStateSuccess(this.data);

  @override
  final DashboardPageData data;

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardPageStateSuccessCopyWith<DashboardPageStateSuccess> get copyWith =>
      _$DashboardPageStateSuccessCopyWithImpl<DashboardPageStateSuccess>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardPageStateSuccess &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'DashboardPageState.success(data: $data)';
  }
}

/// @nodoc
abstract mixin class $DashboardPageStateSuccessCopyWith<$Res>
    implements $DashboardPageStateCopyWith<$Res> {
  factory $DashboardPageStateSuccessCopyWith(
    DashboardPageStateSuccess value,
    $Res Function(DashboardPageStateSuccess) _then,
  ) = _$DashboardPageStateSuccessCopyWithImpl;
  @override
  @useResult
  $Res call({DashboardPageData data});

  @override
  $DashboardPageDataCopyWith<$Res> get data;
}

/// @nodoc
class _$DashboardPageStateSuccessCopyWithImpl<$Res>
    implements $DashboardPageStateSuccessCopyWith<$Res> {
  _$DashboardPageStateSuccessCopyWithImpl(this._self, this._then);

  final DashboardPageStateSuccess _self;
  final $Res Function(DashboardPageStateSuccess) _then;

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? data = null}) {
    return _then(
      DashboardPageStateSuccess(
        null == data
            ? _self.data
            : data // ignore: cast_nullable_to_non_nullable
                as DashboardPageData,
      ),
    );
  }

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardPageDataCopyWith<$Res> get data {
    return $DashboardPageDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc

class DashboardPageStateFailure implements DashboardPageState {
  const DashboardPageStateFailure(this.data, {required this.failure});

  @override
  final DashboardPageData data;
  final Exception failure;

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardPageStateFailureCopyWith<DashboardPageStateFailure> get copyWith =>
      _$DashboardPageStateFailureCopyWithImpl<DashboardPageStateFailure>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardPageStateFailure &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, failure);

  @override
  String toString() {
    return 'DashboardPageState.failure(data: $data, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class $DashboardPageStateFailureCopyWith<$Res>
    implements $DashboardPageStateCopyWith<$Res> {
  factory $DashboardPageStateFailureCopyWith(
    DashboardPageStateFailure value,
    $Res Function(DashboardPageStateFailure) _then,
  ) = _$DashboardPageStateFailureCopyWithImpl;
  @override
  @useResult
  $Res call({DashboardPageData data, Exception failure});

  @override
  $DashboardPageDataCopyWith<$Res> get data;
}

/// @nodoc
class _$DashboardPageStateFailureCopyWithImpl<$Res>
    implements $DashboardPageStateFailureCopyWith<$Res> {
  _$DashboardPageStateFailureCopyWithImpl(this._self, this._then);

  final DashboardPageStateFailure _self;
  final $Res Function(DashboardPageStateFailure) _then;

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? data = null, Object? failure = null}) {
    return _then(
      DashboardPageStateFailure(
        null == data
            ? _self.data
            : data // ignore: cast_nullable_to_non_nullable
                as DashboardPageData,
        failure:
            null == failure
                ? _self.failure
                : failure // ignore: cast_nullable_to_non_nullable
                    as Exception,
      ),
    );
  }

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardPageDataCopyWith<$Res> get data {
    return $DashboardPageDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc

class DashboardPageStateCreatedSpaceSuccess implements DashboardPageState {
  const DashboardPageStateCreatedSpaceSuccess(this.data);

  @override
  final DashboardPageData data;

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardPageStateCreatedSpaceSuccessCopyWith<
    DashboardPageStateCreatedSpaceSuccess
  >
  get copyWith => _$DashboardPageStateCreatedSpaceSuccessCopyWithImpl<
    DashboardPageStateCreatedSpaceSuccess
  >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardPageStateCreatedSpaceSuccess &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'DashboardPageState.createSpaceSuccess(data: $data)';
  }
}

/// @nodoc
abstract mixin class $DashboardPageStateCreatedSpaceSuccessCopyWith<$Res>
    implements $DashboardPageStateCopyWith<$Res> {
  factory $DashboardPageStateCreatedSpaceSuccessCopyWith(
    DashboardPageStateCreatedSpaceSuccess value,
    $Res Function(DashboardPageStateCreatedSpaceSuccess) _then,
  ) = _$DashboardPageStateCreatedSpaceSuccessCopyWithImpl;
  @override
  @useResult
  $Res call({DashboardPageData data});

  @override
  $DashboardPageDataCopyWith<$Res> get data;
}

/// @nodoc
class _$DashboardPageStateCreatedSpaceSuccessCopyWithImpl<$Res>
    implements $DashboardPageStateCreatedSpaceSuccessCopyWith<$Res> {
  _$DashboardPageStateCreatedSpaceSuccessCopyWithImpl(this._self, this._then);

  final DashboardPageStateCreatedSpaceSuccess _self;
  final $Res Function(DashboardPageStateCreatedSpaceSuccess) _then;

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? data = null}) {
    return _then(
      DashboardPageStateCreatedSpaceSuccess(
        null == data
            ? _self.data
            : data // ignore: cast_nullable_to_non_nullable
                as DashboardPageData,
      ),
    );
  }

  /// Create a copy of DashboardPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardPageDataCopyWith<$Res> get data {
    return $DashboardPageDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc
mixin _$DashboardPageData {
  List<DashboardItem> get items;

  /// Create a copy of DashboardPageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardPageDataCopyWith<DashboardPageData> get copyWith =>
      _$DashboardPageDataCopyWithImpl<DashboardPageData>(
        this as DashboardPageData,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardPageData &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'DashboardPageData(items: $items)';
  }
}

/// @nodoc
abstract mixin class $DashboardPageDataCopyWith<$Res> {
  factory $DashboardPageDataCopyWith(
    DashboardPageData value,
    $Res Function(DashboardPageData) _then,
  ) = _$DashboardPageDataCopyWithImpl;
  @useResult
  $Res call({List<DashboardItem> items});
}

/// @nodoc
class _$DashboardPageDataCopyWithImpl<$Res>
    implements $DashboardPageDataCopyWith<$Res> {
  _$DashboardPageDataCopyWithImpl(this._self, this._then);

  final DashboardPageData _self;
  final $Res Function(DashboardPageData) _then;

  /// Create a copy of DashboardPageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null}) {
    return _then(
      _self.copyWith(
        items:
            null == items
                ? _self.items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<DashboardItem>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [DashboardPageData].
extension DashboardPageDataPatterns on DashboardPageData {
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
    TResult Function(_DashboardPageData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardPageData() when $default != null:
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
    TResult Function(_DashboardPageData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardPageData():
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
    TResult? Function(_DashboardPageData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardPageData() when $default != null:
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
    TResult Function(List<DashboardItem> items)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardPageData() when $default != null:
        return $default(_that.items);
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
    TResult Function(List<DashboardItem> items) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardPageData():
        return $default(_that.items);
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
    TResult? Function(List<DashboardItem> items)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardPageData() when $default != null:
        return $default(_that.items);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DashboardPageData implements DashboardPageData {
  const _DashboardPageData({final List<DashboardItem> items = const []})
    : _items = items;

  final List<DashboardItem> _items;
  @override
  @JsonKey()
  List<DashboardItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of DashboardPageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DashboardPageDataCopyWith<_DashboardPageData> get copyWith =>
      __$DashboardPageDataCopyWithImpl<_DashboardPageData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DashboardPageData &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'DashboardPageData(items: $items)';
  }
}

/// @nodoc
abstract mixin class _$DashboardPageDataCopyWith<$Res>
    implements $DashboardPageDataCopyWith<$Res> {
  factory _$DashboardPageDataCopyWith(
    _DashboardPageData value,
    $Res Function(_DashboardPageData) _then,
  ) = __$DashboardPageDataCopyWithImpl;
  @override
  @useResult
  $Res call({List<DashboardItem> items});
}

/// @nodoc
class __$DashboardPageDataCopyWithImpl<$Res>
    implements _$DashboardPageDataCopyWith<$Res> {
  __$DashboardPageDataCopyWithImpl(this._self, this._then);

  final _DashboardPageData _self;
  final $Res Function(_DashboardPageData) _then;

  /// Create a copy of DashboardPageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? items = null}) {
    return _then(
      _DashboardPageData(
        items:
            null == items
                ? _self._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<DashboardItem>,
      ),
    );
  }
}

/// @nodoc
mixin _$DashboardItem {
  String get id;
  String get title;
  String get lastEdited;

  /// Create a copy of DashboardItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardItemCopyWith<DashboardItem> get copyWith =>
      _$DashboardItemCopyWithImpl<DashboardItem>(
        this as DashboardItem,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.lastEdited, lastEdited) ||
                other.lastEdited == lastEdited));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, lastEdited);

  @override
  String toString() {
    return 'DashboardItem(id: $id, title: $title, lastEdited: $lastEdited)';
  }
}

/// @nodoc
abstract mixin class $DashboardItemCopyWith<$Res> {
  factory $DashboardItemCopyWith(
    DashboardItem value,
    $Res Function(DashboardItem) _then,
  ) = _$DashboardItemCopyWithImpl;
  @useResult
  $Res call({String id, String title, String lastEdited});
}

/// @nodoc
class _$DashboardItemCopyWithImpl<$Res>
    implements $DashboardItemCopyWith<$Res> {
  _$DashboardItemCopyWithImpl(this._self, this._then);

  final DashboardItem _self;
  final $Res Function(DashboardItem) _then;

  /// Create a copy of DashboardItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? lastEdited = null,
  }) {
    return _then(
      _self.copyWith(
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _self.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        lastEdited:
            null == lastEdited
                ? _self.lastEdited
                : lastEdited // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [DashboardItem].
extension DashboardItemPatterns on DashboardItem {
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
    TResult Function(_DashboardItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardItem() when $default != null:
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
    TResult Function(_DashboardItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardItem():
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
    TResult? Function(_DashboardItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardItem() when $default != null:
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
    TResult Function(String id, String title, String lastEdited)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardItem() when $default != null:
        return $default(_that.id, _that.title, _that.lastEdited);
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
    TResult Function(String id, String title, String lastEdited) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardItem():
        return $default(_that.id, _that.title, _that.lastEdited);
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
    TResult? Function(String id, String title, String lastEdited)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardItem() when $default != null:
        return $default(_that.id, _that.title, _that.lastEdited);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DashboardItem implements DashboardItem {
  const _DashboardItem({
    required this.id,
    required this.title,
    required this.lastEdited,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String lastEdited;

  /// Create a copy of DashboardItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DashboardItemCopyWith<_DashboardItem> get copyWith =>
      __$DashboardItemCopyWithImpl<_DashboardItem>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DashboardItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.lastEdited, lastEdited) ||
                other.lastEdited == lastEdited));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, lastEdited);

  @override
  String toString() {
    return 'DashboardItem(id: $id, title: $title, lastEdited: $lastEdited)';
  }
}

/// @nodoc
abstract mixin class _$DashboardItemCopyWith<$Res>
    implements $DashboardItemCopyWith<$Res> {
  factory _$DashboardItemCopyWith(
    _DashboardItem value,
    $Res Function(_DashboardItem) _then,
  ) = __$DashboardItemCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String title, String lastEdited});
}

/// @nodoc
class __$DashboardItemCopyWithImpl<$Res>
    implements _$DashboardItemCopyWith<$Res> {
  __$DashboardItemCopyWithImpl(this._self, this._then);

  final _DashboardItem _self;
  final $Res Function(_DashboardItem) _then;

  /// Create a copy of DashboardItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? lastEdited = null,
  }) {
    return _then(
      _DashboardItem(
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _self.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        lastEdited:
            null == lastEdited
                ? _self.lastEdited
                : lastEdited // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}
