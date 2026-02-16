import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/interfaces/space_editor.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// Command for reshaping a connector (moving start/end points).
class ReshapeConnectorCommand extends SpaceCommand with DefaultComment {
  final ConnectorNode originalNode;
  final ConnectorNode modifiedNode;

  ReshapeConnectorCommand({
    required this.originalNode,
    required this.modifiedNode,
  });

  @override
  Future<void> execute(SpaceEditor editor) async {
    await editor.updateNode(modifiedNode);
  }

  @override
  Future<void> undo(SpaceEditor editor) async {
    await editor.updateNode(originalNode);
  }
}
