import 'package:flutter/foundation.dart';
import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

/// Manages the execution and history (Undo/Redo) of [SpaceCommand]s.
class HistoryManager extends ChangeNotifier {
  ShapeLayerBloc _bloc;

  final List<SpaceCommand> _undoStack = [];
  final List<SpaceCommand> _redoStack = [];

  HistoryManager(this._bloc);

  void updateShapeLayerBloc(ShapeLayerBloc bloc) {
    if (_bloc != bloc) {
      _bloc = bloc;
      // Optionally notify listeners if internal state depends on bloc identity,
      // but usually we just want the new bloc for future commands.
    }
  }

  /// Executes a command and pushes it onto the undo stack.
  /// Clears the redo stack because a new history branch has started.
  Future<void> execute(SpaceCommand command) async {
    await command.execute(_bloc);
    _undoStack.add(command);
    _redoStack.clear();
    notifyListeners();
  }

  /// Reverts the most recent command.
  Future<void> undo() async {
    if (_undoStack.isEmpty) return;

    final command = _undoStack.removeLast();
    await command.undo(_bloc);
    _redoStack.add(command);
    notifyListeners();
  }

  /// Re-executes the most recently undone command.
  Future<void> redo() async {
    if (_redoStack.isEmpty) return;

    final command = _redoStack.removeLast();
    await command.execute(_bloc);
    _undoStack.add(command);
    notifyListeners();
  }

  bool get canUndo => _undoStack.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;

  void clear() {
    _undoStack.clear();
    _redoStack.clear();
    notifyListeners();
  }
}
