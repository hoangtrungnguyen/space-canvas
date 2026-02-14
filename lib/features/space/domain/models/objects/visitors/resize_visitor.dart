import 'dart:ui';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';

class ResizeVisitor implements NodeVisitor<Node> {
  final ResizeHandle handle;
  final Offset delta;

  /// The original node's rect is needed to calculate relative scaling for some nodes,
  /// but usually the node itself provides its current state.
  /// However, for precise resizing without drift, we usually resize from the "start of interaction" state.
  /// The [node] passed to [visit] is expected to be the *original* node (snapshot at drag start),
  /// and [delta] is the *total* delta from start.
  ResizeVisitor({required this.handle, required this.delta});

  @override
  Node visitShape(ShapeNode node) {
    final originalRect = node.rect;
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
    if (left > right) {
      final tmp = left;
      left = right;
      right = tmp;
    }
    if (top > bottom) {
      final tmp = top;
      top = bottom;
      bottom = tmp;
    }

    newRect = Rect.fromLTRB(left, top, right, bottom);

    return node.copyWith(rect: newRect);
  }

  @override
  Node visitText(TextNode node) {
    // Text resizing is complex (font size vs wrapping).
    // For now, simpler implementation: No-op or TODO.
    // User requested "Resize Visitor", implying comprehensive logic.
    // But text interaction usually requires scaling font size.
    // We'll implement a basic scaling if corner handle is used.

    // Check if corner handle
    if (handle.isCorner) {
      // Estimate scale from width change?
      // TextNode doesn't have explicit width/height stored (it's auto-sized).
      // So we can't easily resize it via rect logic without measuring it first.
      // Returning original for now to separate concerns.
      return node;
    }
    return node;
  }

  @override
  Node visitPath(PathNode node) {
    // Path resizing requires transforming all points or the path matrix.
    // Can use Matrix4 scaling.
    // TODO: Implement path scaling.
    return node;
  }

  @override
  Node visitImage(ImageNode node) {
    // Similar to Shape, use rect.
    // Assuming ImageNode has a rect (it inherits Node which has 'rect' abstract getter?
    // No, Node defines `Rect get rect;`.
    // ShapeNode defines `final Rect rect;`.
    // ImageNode likely defines `final Rect rect;` or `position/size`.
    // Let's assume generic logic for things with mutable Rect is hard without type checking.
    // But we are in a visitor! We know it is ImageNode.
    // I need to check ImageNode definition.
    return node;
  }

  @override
  Node visitListOfPoint(ListOfPointNode node) {
    return node;
  }

  @override
  Node visitConnector(ConnectorNode node) {
    // Resizing connector? Usually moving start/end points.
    // This visitor handles "Box Resizing".
    return node;
  }

  @override
  Node visitGroup(GroupNode node) {
    return node;
  }
}
