import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

class DeleteObjectCommand implements SpaceCommand {
  final SpaceObject object;

  DeleteObjectCommand(this.object);

  @override
  Future<void> execute(ShapeLayerBloc bloc) async {
    bloc.add(ShapeLayerEvent.removeObject(object.id));
  }

  @override
  Future<void> undo(ShapeLayerBloc bloc) async {
    bloc.add(ShapeLayerEvent.addObject(object));
  }
}
