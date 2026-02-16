import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/interfaces/space_editor.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// Command for modifying any property of a node (position, color, text, etc.).
///
/// This replaces the specific `MoveNodeCommand` by being generic enough
/// to handle any change between two states of the same node ID.
class ModifyNodeCommand extends SpaceCommand with DefaultComment {
  /// The node state before the modification.
  final Node originalNode;

  /// The node state after the modification.
  final Node modifiedNode;

  ModifyNodeCommand({required this.originalNode, required this.modifiedNode})
    : assert(originalNode.id == modifiedNode.id, 'Node IDs must match');

  @override
  Future<void> execute(SpaceEditor editor) async {
    await editor.updateNode(modifiedNode);
  }

  @override
  Future<void> undo(SpaceEditor editor) async {
    await editor.updateNode(originalNode);
  }
}
