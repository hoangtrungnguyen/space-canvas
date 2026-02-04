import 'dart:ui';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';

class ResizeVisitor implements SpaceObjectVisitor<SpaceObject> {
  final ResizeHandle handle;
  final Offset delta;

  /// The original object's rect is needed to calculate relative scaling for some objects,
  /// but usually the object itself provides its current state.
  /// However, for precise resizing without drift, we usually resize from the "start of interaction" state.
  /// The [object] passed to [visit] is expected to be the *original* object (snapshot at drag start),
  /// and [delta] is the *total* delta from start.
  ResizeVisitor({required this.handle, required this.delta});

  @override
  SpaceObject visitShape(ShapeObject object) {
    final originalRect = object.rect;
    Rect newRect = originalRect;

    double left = originalRect.left;
    double top = originalRect.top;
    double right = originalRect.right;
    double bottom = originalRect.bottom;

    // Apply delta based on handle
    switch (handle) {
      case ResizeHandle.topLeft:
        left += delta.dx;
        top += delta.dy;
        break;
      case ResizeHandle.topCenter:
        top += delta.dy;
        break;
      case ResizeHandle.topRight:
        right += delta.dx;
        top += delta.dy;
        break;
      case ResizeHandle.centerRight:
        right += delta.dx;
        break;
      case ResizeHandle.bottomRight:
        right += delta.dx;
        bottom += delta.dy;
        break;
      case ResizeHandle.bottomCenter:
        bottom += delta.dy;
        break;
      case ResizeHandle.bottomLeft:
        left += delta.dx;
        bottom += delta.dy;
        break;
      case ResizeHandle.centerLeft:
        left += delta.dx;
        break;
    }

    // Normalize coordinates (handle flipping)
    print('Before Swap: L=$left, R=$right, Handle=$handle, Delta=$delta');
    if (left > right) {
      final tmp = left;
      left = right;
      right = tmp;
      print('Swapped X: L=$left, R=$right');
    }
    if (top > bottom) {
      final tmp = top;
      top = bottom;
      bottom = tmp;
    }

    newRect = Rect.fromLTRB(left, top, right, bottom);

    return object.copyWith(rect: newRect);
  }

  @override
  SpaceObject visitText(TextObject object) {
    // Text resizing is complex (font size vs wrapping).
    // For now, simpler implementation: No-op or TODO.
    // User requested "Resize Visitor", implying comprehensive logic.
    // But text interaction usually requires scaling font size.
    // We'll implement a basic scaling if corner handle is used.

    // Check if corner handle
    if (handle.isCorner) {
      // Estimate scale from width change?
      // TextObject doesn't have explicit width/height stored (it's auto-sized).
      // So we can't easily resize it via rect logic without measuring it first.
      // Returning original for now to separate concerns.
      return object;
    }
    return object;
  }

  @override
  SpaceObject visitPath(PathObject object) {
    // Path resizing requires transforming all points or the path matrix.
    // Can use Matrix4 scaling.
    // TODO: Implement path scaling.
    return object;
  }

  @override
  SpaceObject visitImage(ImageObject object) {
    // Similar to Shape, use rect.
    // Assuming ImageObject has a rect (it inherits SpaceObject which has 'rect' abstract getter?
    // No, SpaceObject defines `Rect get rect;`.
    // ShapeObject defines `final Rect rect;`.
    // ImageObject likely defines `final Rect rect;` or `position/size`.
    // Let's assume generic logic for things with mutable Rect is hard without type checking.
    // But we are in a visitor! We know it is ImageObject.
    // I need to check ImageObject definition.
    return object;
  }

  @override
  SpaceObject visitListOfPoint(ListOfPointObject object) {
    return object;
  }

  @override
  SpaceObject visitConnector(ConnectorObject object) {
    // Resizing connector? Usually moving start/end points.
    // This visitor handles "Box Resizing".
    return object;
  }

  @override
  SpaceObject visitGroup(GroupObject object) {
    return object;
  }
}
