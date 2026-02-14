import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/data_layer/repositories/space_dashboard_repository.dart';

part 'dashboard_page_bloc.freezed.dart';
part 'dashboard_page_event.dart';
part 'dashboard_page_state.dart';

class DashboardPageBloc extends Bloc<DashboardPageEvent, DashboardPageState> {
  final SpaceDashboardRepository _dashboardRepository;

  DashboardPageBloc(this._dashboardRepository)
    : super(DashboardPageState.initial(DashboardPageData.initialize())) {
    on<_Initialized>(_onInitialized);
    on<_CreatedSpace>(_onCreatedSpace);
  }

  FutureOr<void> _onInitialized(
    _Initialized event,
    Emitter<DashboardPageState> emit,
  ) async {
    emit(DashboardPageState.loading(state.data));
    // final data = await _dashboardRepository.getAll();
    final data = [];
    final items =
        data.map((e) {
            return DashboardItem(
              id: e.id,
              title: e.name,
              lastEdited: e.lastEdited,
            );
          }).toList()
          ..addAll(MockDashboardItemData.itemsWithOldDates);

    emit(DashboardPageState.success(state.data.copyWith(items: items)));
  }

  FutureOr<void> _onCreatedSpace(
    _CreatedSpace event,
    Emitter<DashboardPageState> emit,
  ) async {
    emit(DashboardPageState.loading(state.data));
    final result = await _dashboardRepository.create();
    emit(
      DashboardPageState.createSpaceSuccess(
        state.data.copyWith(
          items: [
            ...state.data.items,
            DashboardItem(
              id: result.id,
              title: result.name,
              lastEdited: result.lastEdited,
            ),
          ],
        ),
      ),
    );
  }
}
