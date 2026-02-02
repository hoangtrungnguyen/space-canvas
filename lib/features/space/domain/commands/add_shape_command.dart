import 'package:flutter/foundation.dart';
import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

class AddShapeCommand extends SpaceCommand {
  final SpaceObject object;
  final String _caller;

  AddShapeCommand(this.object) : _caller = _getCallerInfo();

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
          !line.contains('add_shape_command.dart') &&
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
  Future<void> execute(ShapeLayerBloc bloc) async {
    debugPrint('┌─ AddShapeCommand.execute ─────────────────────────────────');
    debugPrint('│ Object: ${object.runtimeType} (id: ${object.id})');
    debugPrint('│ Caller: $_caller');
    debugPrint('└───────────────────────────────────────────────────────────');
    bloc.add(ShapeLayerEvent.addObject(object));
  }

  @override
  Future<void> undo(ShapeLayerBloc bloc) async {
    debugPrint('┌─ AddShapeCommand.undo ────────────────────────────────────');
    debugPrint('│ Object: ${object.runtimeType} (id: ${object.id})');
    debugPrint('│ Caller: $_caller');
    debugPrint('└───────────────────────────────────────────────────────────');
    bloc.add(ShapeLayerEvent.removeObject(object.id));
  }
}
