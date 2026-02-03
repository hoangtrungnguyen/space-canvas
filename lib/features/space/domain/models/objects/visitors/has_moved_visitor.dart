import 'package:flutter/foundation.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

/// A visitor that checks if an object has moved from its original position.
///
/// This visitor compares the original object (the one being visited) with
/// the current object to determine if a movement has occurred.
class HasMovedVisitor implements SpaceObjectVisitor<bool> {
  final SpaceObject current;

  const HasMovedVisitor(this.current);

  @override
  bool visitShape(ShapeObject original) {
    if (current is! ShapeObject) return false;
    return (current as ShapeObject).rect != original.rect;
  }

  @override
  bool visitText(TextObject original) {
    if (current is! TextObject) return false;
    return (current as TextObject).position != original.position;
  }

  @override
  bool visitPath(PathObject original) {
    if (current is! PathObject) return false;
    return (current as PathObject).path != original.path;
  }

  @override
  bool visitListOfPoint(ListOfPointObject original) {
    if (current is! ListOfPointObject) return false;
    final currentObj = current as ListOfPointObject;

    if (original.points.length != currentObj.points.length) return true;

    return !listEquals(original.points, currentObj.points);
  }

  @override
  bool visitConnector(ConnectorObject original) {
    if (current is! ConnectorObject) return false;
    final currentObj = current as ConnectorObject;
    return original.startPoint != currentObj.startPoint ||
        original.endPoint != currentObj.endPoint;
  }

  @override
  bool visitImage(ImageObject original) {
    if (current is! ImageObject) return false;
    return (current as ImageObject).rect != original.rect;
  }

  @override
  bool visitGroup(GroupObject original) {
    if (current is! GroupObject) return false;
    return (current as GroupObject).rect != original.rect;
  }
}
