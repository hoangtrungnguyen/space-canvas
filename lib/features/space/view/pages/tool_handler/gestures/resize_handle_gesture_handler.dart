import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_handler.dart';

/// Handles resize handle interactions on active nodes.
///
/// **Priority:** Highest — should be first in the chain.
///
/// **Responsibility:** Detects if the user tapped/dragged near a resize handle
/// of an already-selected node, and initiates a resize operation.
///
/// This handler only activates when:
/// 1. There are active (selected) nodes
/// 2. The gesture point is within the hit radius of a resize handle
class ResizeHandleGestureHandler extends GestureHandler {
  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    final state = context.read<ActiveLayerBloc>().state;

    // Can only resize if there are active nodes
    if (state.activeNodes.isEmpty) return false;

    final hitRadius = 20.0 / event.scale;

    for (final node in state.activeNodes.values) {
      final rect = node.rect.inflate(4.0); // Padding from SelectionPainter
      final handle = _getHitHandle(event.worldPoint, rect, hitRadius);
      if (handle != null) return true;
    }

    return false;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;
    final hitRadius = 20.0 / event.scale;

    for (final node in state.activeNodes.values) {
      final rect = node.rect.inflate(4.0);
      final handle = _getHitHandle(event.worldPoint, rect, hitRadius);

      if (handle != null) {
        // Set the active resize handle
        activeBloc.add(ActiveLayerEvent.handleChanged(handle));

        // Temporarily remove from ShapeLayer so we don't see the "old" version
        // beneath the active one being resized.
        context.read<ShapeLayerBloc>().add(ShapeLayerEvent.removeNode(node.id));

        // Start the resize interaction
        activeBloc.add(
          ActiveLayerEvent.interactionStarted(
            node: node,
            point: event.worldPoint,
          ),
        );
        return;
      }
    }
  }

  /// Determines which resize handle (if any) is at the given [point].
  ResizeHandle? _getHitHandle(Offset point, Rect rect, double radius) {
    if ((point - rect.topLeft).distance <= radius) {
      return ResizeHandle.topLeft;
    }
    if ((point - rect.topRight).distance <= radius) {
      return ResizeHandle.topRight;
    }
    if ((point - rect.bottomLeft).distance <= radius) {
      return ResizeHandle.bottomLeft;
    }
    if ((point - rect.bottomRight).distance <= radius) {
      return ResizeHandle.bottomRight;
    }
    if ((point - rect.topCenter).distance <= radius) {
      return ResizeHandle.topCenter;
    }
    if ((point - rect.bottomCenter).distance <= radius) {
      return ResizeHandle.bottomCenter;
    }
    if ((point - rect.centerLeft).distance <= radius) {
      return ResizeHandle.centerLeft;
    }
    if ((point - rect.centerRight).distance <= radius) {
      return ResizeHandle.centerRight;
    }
    return null;
  }
}
