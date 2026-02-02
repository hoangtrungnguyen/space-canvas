import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

/// Command for moving an object on the canvas.
///
/// This command stores both the original and moved object states,
/// allowing for undo/redo of move operations.
class MoveObjectCommand extends SpaceCommand with DefaultComment {
  /// The object in its original position (before the move).
  final SpaceObject originalObject;

  /// The object in its new position (after the move).
  final SpaceObject movedObject;

  MoveObjectCommand({required this.originalObject, required this.movedObject});

  @override
  Future<void> execute(ShapeLayerBloc bloc) async {
    // Remove the original and add the moved version
    bloc.add(ShapeLayerEvent.removeObject(originalObject.id));
    bloc.add(ShapeLayerEvent.addObject(movedObject));
  }

  @override
  Future<void> undo(ShapeLayerBloc bloc) async {
    // Remove the moved and add the original back
    bloc.add(ShapeLayerEvent.removeObject(movedObject.id));
    bloc.add(ShapeLayerEvent.addObject(originalObject));
  }
}
