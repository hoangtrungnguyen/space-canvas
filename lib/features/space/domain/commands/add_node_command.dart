import 'package:flutter/foundation.dart';
import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/interfaces/space_editor.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

class AddNodeCommand extends SpaceCommand {
  final Node node;
  final String _caller;

  AddNodeCommand(this.node) : _caller = _getCallerInfo();

  /// Returns the location where this command was created.
  @override
  String? get comment => _caller;

  /// Extracts the caller location from the stack trace.
  static String _getCallerInfo() {
    final trace = StackTrace.current.toString();
    final lines = trace.split('\n');
    // Skip the first few frames (this method, constructor, etc.)
    // and find the actual caller
    for (var i = 2; i < lines.length && i < 6; i++) {
      final line = lines[i].trim();
      if (line.isNotEmpty &&
          !line.contains('add_node_command.dart') &&
          !line.contains('<anonymous closure>')) {
        // Extract just the relevant part
        final match = RegExp(r'#\d+\s+(.+)').firstMatch(line);
        if (match != null) {
          return match.group(1) ?? line;
        }
        return line;
      }
    }
    return 'unknown';
  }

  @override
  Future<void> execute(SpaceEditor editor) async {
    debugPrint('┌─ AddNodeCommand.execute ─────────────────────────────────');
    debugPrint('│ Node: ${node.runtimeType} (id: ${node.id})');
    debugPrint('│ Caller: $_caller');
    debugPrint('└───────────────────────────────────────────────────────────');
    await editor.addNode(node);
  }

  @override
  Future<void> undo(SpaceEditor editor) async {
    debugPrint('┌─ AddNodeCommand.undo ────────────────────────────────────');
    debugPrint('│ Node: ${node.runtimeType} (id: ${node.id})');
    debugPrint('│ Caller: $_caller');
    debugPrint('└───────────────────────────────────────────────────────────');
    await editor.removeNode(node.id);
  }
}
