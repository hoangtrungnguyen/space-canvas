part of 'dashboard_page_bloc.dart';

@freezed
sealed class DashboardPageEvent with _$DashboardPageEvent {
  const factory DashboardPageEvent.initialized() = _Initialized;
  const factory DashboardPageEvent.createdSpace() = _CreatedSpace;
}
