import 'package:flutter/foundation.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// A visitor that checks if a node has moved from its original position.
///
/// This visitor compares the original node (the one being visited) with
/// the current node to determine if a movement has occurred.
class HasMovedVisitor implements NodeVisitor<bool> {
  final Node current;

  const HasMovedVisitor(this.current);

  @override
  bool visitShape(ShapeNode original) {
    if (current is! ShapeNode) return false;
    return (current as ShapeNode).rect != original.rect;
  }

  @override
  bool visitText(TextNode original) {
    if (current is! TextNode) return false;
    return (current as TextNode).position != original.position;
  }

  @override
  bool visitListOfPoint(ListOfPointNode original) {
    if (current is! ListOfPointNode) return false;
    final currentNode = current as ListOfPointNode;

    if (original.points.length != currentNode.points.length) return true;

    return !listEquals(original.points, currentNode.points);
  }

  @override
  bool visitConnector(ConnectorNode original) {
    if (current is! ConnectorNode) return false;
    final currentNode = current as ConnectorNode;
    return original.startPoint != currentNode.startPoint ||
        original.endPoint != currentNode.endPoint;
  }

  @override
  bool visitImage(ImageNode original) {
    if (current is! ImageNode) return false;
    return (current as ImageNode).rect != original.rect;
  }

  @override
  bool visitGroup(GroupNode original) {
    if (current is! GroupNode) return false;
    return (current as GroupNode).rect != original.rect;
  }
}
