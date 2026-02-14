import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

/// Command for moving an object on the canvas.
///
/// This command stores both the original and moved object states,
/// allowing for undo/redo of move operations.
class MoveNodeCommand extends SpaceCommand with DefaultComment {
  /// The object in its original position (before the move).
  final Node originalNode;

  /// The object in its new position (after the move).
  final Node movedNode;

  MoveNodeCommand({required this.originalNode, required this.movedNode});

  @override
  Future<void> execute(ShapeLayerBloc bloc) async {
    // Remove the original and add the moved version
    bloc.add(ShapeLayerEvent.removeNode(originalNode.id));
    bloc.add(ShapeLayerEvent.addNode(movedNode));
  }

  @override
  Future<void> undo(ShapeLayerBloc bloc) async {
    // Remove the moved and add the original back
    bloc.add(ShapeLayerEvent.removeNode(movedNode.id));
    bloc.add(ShapeLayerEvent.addNode(originalNode));
  }
}
