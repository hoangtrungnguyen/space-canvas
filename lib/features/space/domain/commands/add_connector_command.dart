import 'package:flutter/foundation.dart';
import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_object.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

class AddConnectorCommand extends SpaceCommand {
  final ConnectorObject connector;
  final String _caller;

  AddConnectorCommand(this.connector) : _caller = _getCallerInfo();

  @override
  String? get comment => _caller;

  static String _getCallerInfo() {
    final trace = StackTrace.current.toString();
    final lines = trace.split('\n');
    for (var i = 2; i < lines.length && i < 6; i++) {
      final line = lines[i].trim();
      if (line.isNotEmpty &&
          !line.contains('add_connector_command.dart') &&
          !line.contains('<anonymous closure>')) {
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
    debugPrint(
      '┌─ AddConnectorCommand.execute ─────────────────────────────────',
    );
    debugPrint('│ Connector (id: ${connector.id})');
    debugPrint('│ Caller: $_caller');
    debugPrint('└───────────────────────────────────────────────────────────');
    bloc.add(ShapeLayerEvent.addObject(connector));
  }

  @override
  Future<void> undo(ShapeLayerBloc bloc) async {
    debugPrint(
      '┌─ AddConnectorCommand.undo ────────────────────────────────────',
    );
    debugPrint('│ Connector (id: ${connector.id})');
    debugPrint('│ Caller: $_caller');
    debugPrint('└───────────────────────────────────────────────────────────');
    bloc.add(ShapeLayerEvent.removeObject(connector.id));
  }
}
