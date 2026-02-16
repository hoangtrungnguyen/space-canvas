import 'dart:ui';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/visitors/move_visitor.dart';

/// Extension methods on [Node] that provide a clean API
/// while internally delegating to the Visitor pattern.
///
/// This hybrid approach combines:
/// - **Visitor Pattern**: For type-safe, polymorphic logic handling
/// - **Extension Methods**: For a clean, discoverable API
extension NodeTransformations on Node {
  /// Creates a new [Node] moved by the given [delta].
  ///
  /// Returns `null` if the movement cannot be applied to this object type.
  ///
  /// Example:
  /// ```dart
  /// final movedShape = shape.move(Offset(10, 20));
  /// ```
  Node? move(Offset delta) {
    return accept(MoveVisitor(delta));
  }
}
