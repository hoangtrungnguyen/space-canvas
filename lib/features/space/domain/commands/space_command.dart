import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

/// The Command Interface for the Undo/Redo system.
///
/// Each command represents a user action that alters the state of the Space.
/// It must be reversible.
abstract class SpaceCommand {
  /// Executes the command logic against the provided [bloc].
  Future<void> execute(ShapeLayerBloc bloc);

  /// Reverts the effects of [execute].
  Future<void> undo(ShapeLayerBloc bloc);
}
