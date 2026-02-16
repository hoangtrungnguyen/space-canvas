import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/interfaces/space_editor.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

class DeleteNodeCommand extends SpaceCommand with DefaultComment {
  final Node node;

  DeleteNodeCommand(this.node);

  @override
  Future<void> execute(SpaceEditor editor) async {
    await editor.removeNode(node.id);
  }

  @override
  Future<void> undo(SpaceEditor editor) async {
    await editor.addNode(node);
  }
}
