import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

/// Composite Command Pattern - Batch multiple deletions into a single undo operation.
class BatchDeleteCommand extends SpaceCommand with DefaultComment {
  final List<Node> nodes;

  BatchDeleteCommand(this.nodes);

  @override
  Future<void> execute(ShapeLayerBloc bloc) async {
    for (final node in nodes) {
      bloc.add(ShapeLayerEvent.removeNode(node.id));
    }
  }

  @override
  Future<void> undo(ShapeLayerBloc bloc) async {
    for (final node in nodes) {
      bloc.add(ShapeLayerEvent.addNode(node));
    }
  }
}
