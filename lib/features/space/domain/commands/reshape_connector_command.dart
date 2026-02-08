import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

/// Command for reshaping a connector (moving start/end points).
class ReshapeConnectorCommand extends SpaceCommand with DefaultComment {
  final ConnectorObject originalObject;
  final ConnectorObject modifiedObject;

  ReshapeConnectorCommand({
    required this.originalObject,
    required this.modifiedObject,
  });

  @override
  Future<void> execute(ShapeLayerBloc bloc) async {
    bloc.add(ShapeLayerEvent.removeObject(originalObject.id));
    bloc.add(ShapeLayerEvent.addObject(modifiedObject));
  }

  @override
  Future<void> undo(ShapeLayerBloc bloc) async {
    bloc.add(ShapeLayerEvent.removeObject(modifiedObject.id));
    bloc.add(ShapeLayerEvent.addObject(originalObject));
  }
}
