import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// Interface for modifying the Space state.
///
/// This abstracts the underlying state management (BLoC) from the Domain layer commands.
abstract class SpaceEditor {
  /// Adds a [node] to the space.
  Future<void> addNode(Node node);

  /// Removes a node with [id] from the space.
  Future<void> removeNode(int id);

  /// Updates an existing [node] in the space.
  Future<void> updateNode(Node node);

  /// Updates multiple [nodes] at once.
  Future<void> updateNodes(List<Node> nodes);
}
