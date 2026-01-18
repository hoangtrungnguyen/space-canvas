part of 'page_bloc.dart';

@freezed
class PageState with _$PageState {
  const factory PageState.init() = PageInit;
  const factory PageState.inProgress() = PageInProgress;
  const factory PageState.failure({required Exception error}) = PageFailure;
  const factory PageState.success() = PageSuccess;
}
