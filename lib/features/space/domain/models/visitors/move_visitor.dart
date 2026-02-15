import 'dart:ui';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// A visitor that creates a moved copy of a [Node] by applying a delta offset.
///
/// This visitor implements the Visitor pattern to handle different object types
/// polymorphically without type-checking conditionals.
class MoveVisitor implements NodeVisitor<Node?> {
  final Offset delta;

  const MoveVisitor(this.delta);

  @override
  Node? visitShape(ShapeNode node) {
    return node.copyWith(rect: node.rect.shift(delta));
  }

  @override
  Node? visitText(TextNode node) {
    return node.copyWith(position: node.position + delta);
  }

  @override
  Node? visitListOfPoint(ListOfPointNode node) {
    return node.copyWith(points: node.points.map((p) => p + delta).toList());
  }

  @override
  Node? visitConnector(ConnectorNode node) {
    return node.copyWith(
      startPoint: node.startPoint + delta,
      endPoint: node.endPoint + delta,
    );
  }

  @override
  Node? visitImage(ImageNode node) {
    return node.copyWith(rect: node.rect.shift(delta));
  }

  @override
  Node? visitGroup(GroupNode node) {
    return node.copyWith(rect: node.rect.shift(delta));
  }
}
