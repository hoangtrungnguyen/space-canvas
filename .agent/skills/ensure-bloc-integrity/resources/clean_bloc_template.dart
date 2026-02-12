
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

// Note: These would typically be in separate files.
// Included here for template completeness.

// --- Domain Layer: UseCase Interface ---
abstract class LoadDataUseCase {
  Future<List<String>> execute();
}

// --- BLoC State (Clean & Immutable) ---
part 'clean_bloc_template.freezed.dart';

@freezed
class CleanState with _$CleanState {
  const factory CleanState.initial() = _Initial;
  const factory CleanState.loading() = _Loading;
  const factory CleanState.loaded(List<String> items) = _Loaded;
  const factory CleanState.error(String message) = _Error;
}

// --- BLoC Events ---
@freezed
class CleanEvent with _$CleanEvent {
  const factory CleanEvent.started() = _Started;
  const factory CleanEvent.refreshRequested() = _RefreshRequested;
}

// --- The BLoC Implementation ---
@injectable
class CleanBloc extends Bloc<CleanEvent, CleanState> {
  final LoadDataUseCase _loadDataUseCase;

  // Injection via constructor: Loose coupling
  CleanBloc(this._loadDataUseCase) : super(const CleanState.initial()) {
    on<_Started>(_onStarted);
    on<_RefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(_Started event, Emitter<CleanState> emit) async {
    emit(const CleanState.loading());
    try {
      final items = await _loadDataUseCase.execute();
      emit(CleanState.loaded(items));
    } catch (e) {
      emit(CleanState.error(e.toString()));
    }
  }

  Future<void> _onRefreshRequested(_RefreshRequested event, Emitter<CleanState> emit) async {
    // Avoid emitting loading if we want silent refresh?
    // Or maybe just re-emit loading.
    emit(const CleanState.loading());
    try {
      final items = await _loadDataUseCase.execute();
      emit(CleanState.loaded(items));
    } catch (e) {
      emit(CleanState.error(e.toString()));
    }
  }
}
