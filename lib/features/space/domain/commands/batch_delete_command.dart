import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

/// Composite Command Pattern - Batch multiple deletions into a single undo operation.
class BatchDeleteCommand extends SpaceCommand with DefaultComment {
  final List<SpaceObject> objects;

  BatchDeleteCommand(this.objects);

  @override
  Future<void> execute(ShapeLayerBloc bloc) async {
    for (final obj in objects) {
      bloc.add(ShapeLayerEvent.removeObject(obj.id));
    }
  }

  @override
  Future<void> undo(ShapeLayerBloc bloc) async {
    for (final obj in objects) {
      bloc.add(ShapeLayerEvent.addObject(obj));
    }
  }
}
