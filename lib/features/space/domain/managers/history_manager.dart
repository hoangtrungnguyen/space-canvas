import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

/// Manages the execution and history (Undo/Redo) of [SpaceCommand]s.
class HistoryManager {
  final ShapeLayerBloc _bloc;

  final List<SpaceCommand> _undoStack = [];
  final List<SpaceCommand> _redoStack = [];

  HistoryManager(this._bloc);

  /// Executes a command and pushes it onto the undo stack.
  /// Clears the redo stack because a new history branch has started.
  Future<void> execute(SpaceCommand command) async {
    await command.execute(_bloc);
    _undoStack.add(command);
    _redoStack.clear();
  }

  /// Reverts the most recent command.
  Future<void> undo() async {
    if (_undoStack.isEmpty) return;

    final command = _undoStack.removeLast();
    await command.undo(_bloc);
    _redoStack.add(command);
  }

  /// Re-executes the most recently undone command.
  Future<void> redo() async {
    if (_redoStack.isEmpty) return;

    final command = _redoStack.removeLast();
    await command.execute(_bloc);
    _undoStack.add(command);
  }

  bool get canUndo => _undoStack.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;

  void clear() {
    _undoStack.clear();
    _redoStack.clear();
  }
}
