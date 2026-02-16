import 'package:ideascape/features/space/domain/interfaces/space_editor.dart';

/// The Command Interface for the Undo/Redo system.
///
/// Each command represents a user action that alters the state of the Space.
/// It must be reversible.
abstract class SpaceCommand {
  /// Optional comment describing the context or reason for this command.
  /// Useful for debugging and history inspection.
  /// Override this getter in subclasses to provide a comment.
  String? get comment;

  /// Executes the command logic against the provided [editor].
  Future<void> execute(SpaceEditor editor);

  /// Reverts the effects of [execute].
  Future<void> undo(SpaceEditor editor);
}

/// Mixin that provides a default null comment implementation.
/// Use this mixin in command classes that don't need a custom comment.
mixin DefaultComment on SpaceCommand {
  @override
  String? get comment => null;
}
