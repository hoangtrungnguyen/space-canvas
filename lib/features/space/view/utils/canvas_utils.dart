import 'package:flutter/material.dart';

/// Utility class for canvas coordinate transformations.
class CanvasUtils {
  CanvasUtils._();

  /// Transforms a local screen coordinate to world/canvas coordinate.
  static Offset toWorldPoint(
    Offset local,
    TransformationController controller,
  ) {
    return MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      local,
    );
  }
}
