import 'package:flutter/material.dart';

/// Defines a strategy for handling drag interactions on the canvas.
abstract class InteractionStrategy {
  /// Handles the update phase of a drag gesture.
  void onUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  );

  /// Handles the end phase of a drag gesture.
  void onEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  );
}
