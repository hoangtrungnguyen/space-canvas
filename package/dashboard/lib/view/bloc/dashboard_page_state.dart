part of 'dashboard_page_bloc.dart';

@freezed
abstract class DashboardPageState with _$DashboardPageState {
  const factory DashboardPageState.initial(DashboardPageData data) =
      DashboardPageStateInitial;

  const factory DashboardPageState.loading(DashboardPageData data) =
      DashboardPageStateLoading;

  const factory DashboardPageState.success(DashboardPageData data) =
      DashboardPageStateSuccess;

  const factory DashboardPageState.failure(
    DashboardPageData data, {
    required Exception failure,
  }) = DashboardPageStateFailure;

  const factory DashboardPageState.createSpaceSuccess(DashboardPageData data) =
      DashboardPageStateCreatedSpaceSuccess;
}

@freezed
abstract class DashboardPageData with _$DashboardPageData {
  const factory DashboardPageData({@Default([]) List<DashboardItem> items}) =
      _DashboardPageData;

  factory DashboardPageData.initialize() {
    return const DashboardPageData();
  }
}

@freezed
abstract class DashboardItem with _$DashboardItem {
  const factory DashboardItem({
    required String id,
    required String title,
    required String lastEdited,
  }) = _DashboardItem;
}

class MockDashboardItemData {
  // If you need more variety or specific scenarios:
  static List<DashboardItem> get itemsWithOldDates => [
    DashboardItem(
      id: "id 1",
      title: "Archived Document A",
      lastEdited: DateTime(2022, 5, 15).toString(),
    ),
    DashboardItem(
      id: "Id 2",
      title: "Old Project Plan",
      lastEdited: DateTime(2021, 1, 20).toString(),
    ),
  ];
}
