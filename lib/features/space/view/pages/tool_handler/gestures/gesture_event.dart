import 'package:flutter/material.dart';
import 'package:ideascape/features/space/view/utils/canvas_utils.dart';

/// The type of gesture event being processed.
enum GestureType {
  /// A tap gesture completed (finger lifted).
  tapUp,

  /// A drag gesture started.
  panStart,

  /// A drag gesture is in progress.
  panUpdate,

  /// A drag gesture ended.
  panEnd,
}

/// Wrapper for gesture events with common pre-computed data.
///
/// Encapsulates the gesture's world-space position, local position,
/// transformation controller, and gesture type, eliminating the need
/// for each handler to perform redundant coordinate transformations.
class GestureEvent {
  /// The gesture position in world (canvas) coordinates.
  final Offset worldPoint;

  /// The gesture position in local (screen) coordinates.
  final Offset localPosition;

  /// The current transformation controller for the canvas.
  final TransformationController controller;

  /// The type of gesture that triggered this event.
  final GestureType type;

  const GestureEvent({
    required this.worldPoint,
    required this.localPosition,
    required this.controller,
    required this.type,
  });

  /// Creates a [GestureEvent] from a [TapUpDetails].
  factory GestureEvent.tapUp(
    TapUpDetails details,
    TransformationController controller,
  ) {
    final worldPoint = CanvasUtils.toWorldPoint(
      details.localPosition,
      controller,
    );
    return GestureEvent(
      worldPoint: worldPoint,
      localPosition: details.localPosition,
      controller: controller,
      type: GestureType.tapUp,
    );
  }

  /// Creates a [GestureEvent] from a [DragStartDetails].
  factory GestureEvent.panStart(
    DragStartDetails details,
    TransformationController controller,
  ) {
    final worldPoint = CanvasUtils.toWorldPoint(
      details.localPosition,
      controller,
    );
    return GestureEvent(
      worldPoint: worldPoint,
      localPosition: details.localPosition,
      controller: controller,
      type: GestureType.panStart,
    );
  }

  /// Creates a [GestureEvent] from a [DragUpdateDetails].
  factory GestureEvent.panUpdate(
    DragUpdateDetails details,
    TransformationController controller,
  ) {
    final worldPoint = CanvasUtils.toWorldPoint(
      details.localPosition,
      controller,
    );
    return GestureEvent(
      worldPoint: worldPoint,
      localPosition: details.localPosition,
      controller: controller,
      type: GestureType.panUpdate,
    );
  }

  /// Creates a [GestureEvent] from a [DragEndDetails].
  ///
  /// Note: [DragEndDetails] does not have position information,
  /// so worldPoint and localPosition default to [Offset.zero].
  factory GestureEvent.panEnd(
    DragEndDetails details,
    TransformationController controller,
  ) {
    return GestureEvent(
      worldPoint: Offset.zero,
      localPosition: Offset.zero,
      controller: controller,
      type: GestureType.panEnd,
    );
  }

  /// The current zoom scale of the canvas.
  double get scale => controller.value.getMaxScaleOnAxis();
}
