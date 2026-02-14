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

  /// Logs the current state of the undo and redo stacks to the console.
  void _logStacks(String operation) {
    debugPrint('╔══════════════════════════════════════════════════════════');
    debugPrint('║ HistoryManager [$operation]');
    debugPrint('╠══════════════════════════════════════════════════════════');
    debugPrint('║ Undo Stack (${_undoStack.length} items):');
    for (var i = 0; i < _undoStack.length; i++) {
      final command = _undoStack[i];
      debugPrint('║   [$i] ${_formatCommand(command)}');
    }
    debugPrint('╠──────────────────────────────────────────────────────────');
    debugPrint('║ Redo Stack (${_redoStack.length} items):');
    for (var i = 0; i < _redoStack.length; i++) {
      final command = _redoStack[i];
      debugPrint('║   [$i] ${_formatCommand(command)}');
    }
    debugPrint('╚══════════════════════════════════════════════════════════');
  }

  /// Formats a command for logging, including object ID(s) and comment.
  String _formatCommand(SpaceCommand command) {
    final type = command.runtimeType.toString();
    final objectInfo = _getObjectInfo(command);
    final comment = command.comment;

    final parts = <String>[];
    if (objectInfo.isNotEmpty) {
      parts.add(objectInfo);
    }
    if (comment != null && comment.isNotEmpty) {
      parts.add('comment: "$comment"');
    }

    if (parts.isNotEmpty) {
      return '$type (${parts.join(', ')})';
    }
    return type;
  }

  /// Extracts object ID information from a command.
  String _getObjectInfo(SpaceCommand command) {
    // Import-free type checking using runtime type names
    final typeName = command.runtimeType.toString();

    try {
      if (typeName == 'AddNodeCommand') {
        final dynamic cmd = command;
        return 'id: ${cmd.object.id}';
      } else if (typeName == 'DeleteNodeCommand') {
        final dynamic cmd = command;
        return 'id: ${cmd.object.id}';
      } else if (typeName == 'MoveNodeCommand') {
        final dynamic cmd = command;
        return 'id: ${cmd.originalNode.id}';
      } else if (typeName == 'BatchDeleteCommand') {
        final dynamic cmd = command;
        final ids = (cmd.objects as List).map((o) => o.id).toList();
        return 'ids: $ids';
      }
    } catch (_) {
      // If we can't extract info, just return empty
    }
    return '';
  }

  /// Executes a command and pushes it onto the undo stack.
  /// Clears the redo stack because a new history branch has started.
  Future<void> execute(SpaceCommand command) async {
    await command.execute(_bloc);
    _undoStack.add(command);
    _redoStack.clear();
    _logStacks('EXECUTE: ${command.runtimeType}');
    notifyListeners();
  }

  /// Reverts the most recent command.
  Future<void> undo() async {
    if (_undoStack.isEmpty) return;

    final command = _undoStack.removeLast();
    await command.undo(_bloc);
    _redoStack.add(command);
    _logStacks('UNDO: ${command.runtimeType}');
    notifyListeners();
  }

  /// Re-executes the most recently undone command.
  Future<void> redo() async {
    if (_redoStack.isEmpty) return;

    final command = _redoStack.removeLast();
    await command.execute(_bloc);
    _undoStack.add(command);
    _logStacks('REDO: ${command.runtimeType}');
    notifyListeners();
  }

  bool get canUndo => _undoStack.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;

  void clear() {
    _undoStack.clear();
    _redoStack.clear();
    _logStacks('CLEAR');
    notifyListeners();
  }
}
