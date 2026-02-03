import 'dart:ui';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

/// A visitor that creates a moved copy of a [SpaceObject] by applying a delta offset.
///
/// This visitor implements the Visitor pattern to handle different object types
/// polymorphically without type-checking conditionals.
class MoveVisitor implements SpaceObjectVisitor<SpaceObject?> {
  final Offset delta;

  const MoveVisitor(this.delta);

  @override
  SpaceObject? visitShape(ShapeObject object) {
    return object.copyWith(rect: object.rect.shift(delta));
  }

  @override
  SpaceObject? visitText(TextObject object) {
    return object.copyWith(position: object.position + delta);
  }

  @override
  SpaceObject? visitPath(PathObject object) {
    return object.copyWith(path: object.path.shift(delta));
  }

  @override
  SpaceObject? visitListOfPoint(ListOfPointObject object) {
    return object.copyWith(
      points: object.points.map((p) => p + delta).toList(),
    );
  }

  @override
  SpaceObject? visitConnector(ConnectorObject object) {
    return object.copyWith(
      startPoint: object.startPoint + delta,
      endPoint: object.endPoint + delta,
    );
  }

  @override
  SpaceObject? visitImage(ImageObject object) {
    return object.copyWith(rect: object.rect.shift(delta));
  }

  @override
  SpaceObject? visitGroup(GroupObject object) {
    return object.copyWith(rect: object.rect.shift(delta));
  }
}
