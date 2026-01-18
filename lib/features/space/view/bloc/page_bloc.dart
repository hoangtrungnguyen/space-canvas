import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/domain/space_data_service.dart';

part 'page_event.dart';
part 'page_state.dart';
part 'page_bloc.freezed.dart';

class SpacePageBloc extends Bloc<PageEvent, PageState> {
  final String _id;
  final SpaceDataService _spaceDataService;

  SpacePageBloc({
    required String id,
    required SpaceDataService spaceDataService,
  }) : _id = id,
       _spaceDataService = spaceDataService,
       super(const PageState.init()) {
    on<PageLoad>(_onLoad);
    on<PageSave>(_onSave);
  }

  void _onLoad(PageLoad event, Emitter<PageState> emit) async {
    emit(const PageState.inProgress());
    try {
      // TODO: implement load logic
      await Future.delayed(const Duration(seconds: 1)); // simulating load
      emit(const PageState.success());
    } on Exception catch (e) {
      emit(PageState.failure(error: e));
    }
  }

  void _onSave(PageSave event, Emitter<PageState> emit) async {
    emit(const PageState.inProgress());
    try {
      // TODO: implement save logic
      await Future.delayed(const Duration(seconds: 1)); // simulating save
      emit(const PageState.success());
    } on Exception catch (e) {
      emit(PageState.failure(error: e));
    }
  }
}
