import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/interfaces/space_editor.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// Composite Command Pattern - Batch multiple deletions into a single undo operation.
class BatchDeleteCommand extends SpaceCommand with DefaultComment {
  final List<Node> nodes;

  BatchDeleteCommand(this.nodes);

  @override
  Future<void> execute(SpaceEditor editor) async {
    for (final node in nodes) {
      await editor.removeNode(node.id);
    }
  }

  @override
  Future<void> undo(SpaceEditor editor) async {
    for (final node in nodes) {
      await editor.addNode(node);
    }
  }
}
