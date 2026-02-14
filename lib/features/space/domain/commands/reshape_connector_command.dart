import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

/// Command for reshaping a connector (moving start/end points).
class ReshapeConnectorCommand extends SpaceCommand with DefaultComment {
  final ConnectorNode originalNode;
  final ConnectorNode modifiedNode;

  ReshapeConnectorCommand({
    required this.originalNode,
    required this.modifiedNode,
  });

  @override
  Future<void> execute(ShapeLayerBloc bloc) async {
    bloc.add(ShapeLayerEvent.removeNode(originalNode.id));
    bloc.add(ShapeLayerEvent.addNode(modifiedNode));
  }

  @override
  Future<void> undo(ShapeLayerBloc bloc) async {
    bloc.add(ShapeLayerEvent.removeNode(modifiedNode.id));
    bloc.add(ShapeLayerEvent.addNode(originalNode));
  }
}
