import 'dart:ui' show Offset;

import 'package:quadtree_dart/quadtree_dart.dart';

extension RectContains on Rect {
  /// Checks if the rectangle's bounds contain the given point.
  /// This mimics the behavior of dart:ui's Rect.contains(Offset).
  /// The right and bottom edges are exclusive.
  bool contains(Offset point) {
    return (point.dx >= x &&
        point.dx < x + width &&
        point.dy >= y &&
        point.dy < y + height);
  }
}
