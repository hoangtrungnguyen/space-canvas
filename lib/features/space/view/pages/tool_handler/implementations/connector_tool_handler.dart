import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_object.dart';
import 'package:ideascape/features/space/domain/utils/connector_utils.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';

/// Handles connector tool interactions using the Mediator and State patterns.
///
/// Connectors can be drawn from any point to any point. If the start or end
/// point is on an object, it will be linked to that object.
class ConnectorToolHandler extends ToolHandler {
  const ConnectorToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = _toWorldPoint(details.localPosition, controller);
    final activeState = context.read<ActiveLayerBloc>().state;
    final shapeState = context.read<ShapeLayerBloc>().state;

    // Case 1: End the connector (Tap-to-End)
    if (activeState.connectorStartPoint != null) {
      _finalizeConnector(
        context,
        startPoint: activeState.connectorStartPoint!,
        startObjectId: activeState.connectorStartObjectId,
        endPoint: worldPoint,
        shapeState: shapeState,
      );
      return;
    }

    // Case 2: Start the connector (Tap-to-Start)
    if (shapeState is ShapeLayerStateSuccess) {
      final objectId = _findObjectAt(worldPoint, shapeState.data.objects);
      if (objectId != null) {
        final object = shapeState.data.objects[objectId];
        if (object != null) {
          // Check if we are close to an anchor
          final anchor = ConnectorUtils.getEdgeFromPoint(
            object.rect,
            worldPoint,
          );
          final anchorPoint = ConnectorUtils.getPointOnEdge(
            object.rect,
            anchor,
          );

          // Simple distance check (e.g. 20.0 radius)
          if ((worldPoint - anchorPoint).distance <= 20.0) {
            context.read<ActiveLayerBloc>().add(
              ActiveLayerEvent.connectorDragStarted(
                startObjectId: objectId,
                startPoint: anchorPoint,
              ),
            );
          }
        }
      }
    }
  }

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    // If we already have a start point (from Tap), don't reset it.
    // Just let the drag update continue from where the mouse is.
    final activeState = context.read<ActiveLayerBloc>().state;
    if (activeState.connectorStartPoint != null) {
      return;
    }

    final worldPoint = _toWorldPoint(details.localPosition, controller);

    // Find if we're starting on an object (optional)
    int? startObjectId;
    final state = context.read<ShapeLayerBloc>().state;
    if (state is ShapeLayerStateSuccess) {
      startObjectId = _findObjectAt(worldPoint, state.data.objects);
    }

    // Always start the drag, even without an object
    context.read<ActiveLayerBloc>().add(
      ActiveLayerEvent.connectorDragStarted(
        startObjectId: startObjectId,
        startPoint: worldPoint,
      ),
    );
  }

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeState = context.read<ActiveLayerBloc>().state;
    if (activeState.connectorStartPoint != null) {
      final worldPoint = _toWorldPoint(details.localPosition, controller);
      context.read<ActiveLayerBloc>().add(
        ActiveLayerEvent.connectorDragUpdated(worldPoint),
      );
    }
  }

  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeState = context.read<ActiveLayerBloc>().state;
    final startPoint = activeState.connectorStartPoint;
    final startObjectId = activeState.connectorStartObjectId;
    final endPoint = activeState.connectorDragPosition;

    if (startPoint != null && endPoint != null) {
      final shapeState = context.read<ShapeLayerBloc>().state;
      _finalizeConnector(
        context,
        startPoint: startPoint,
        startObjectId: startObjectId,
        endPoint: endPoint,
        shapeState: shapeState,
      );
    } else {
      // Just clear if valid start/end not present
      context.read<ActiveLayerBloc>().add(
        const ActiveLayerEvent.connectorDragEnded(),
      );
    }
  }

  void _finalizeConnector(
    BuildContext context, {
    required Offset startPoint,
    required Offset endPoint,
    required int? startObjectId,
    required ShapeLayerState shapeState,
  }) {
    final mediator = context.read<CanvasInteractionMediator>();

    int? endObjectId;
    if (shapeState is ShapeLayerStateSuccess) {
      endObjectId = _findObjectAt(endPoint, shapeState.data.objects);
    }

    // Calculate locations
    ConnectorEdge? startLocation;
    ConnectorEdge? endLocation;

    if (shapeState is ShapeLayerStateSuccess) {
      if (startObjectId != null) {
        final startObj = shapeState.data.objects[startObjectId];
        if (startObj != null) {
          startLocation = ConnectorUtils.getEdgeFromPoint(
            startObj.rect,
            startPoint,
          );
        }
      }
      if (endObjectId != null) {
        final endObj = shapeState.data.objects[endObjectId];
        if (endObj != null) {
          endLocation = ConnectorUtils.getEdgeFromPoint(endObj.rect, endPoint);
        }
      }
    }

    // Create connector with optional object IDs & locations
    mediator.createConnector(
      startPoint: startPoint,
      endPoint: endPoint,
      startObjectId: startObjectId,
      endObjectId: endObjectId,
      startLocation: startLocation,
      endLocation: endLocation,
    );

    // Switch tool to Select Connector
    context.read<ToolbarBloc>().add(
      ToolbarEvent.selected(SpaceTool.selectConnector),
    );

    // Always clear the drag state
    context.read<ActiveLayerBloc>().add(
      const ActiveLayerEvent.connectorDragEnded(),
    );
  }

  int? _findObjectAt(Offset position, Map<int, SpaceObject> objects) {
    final sorted =
        objects.values.toList()..sort((a, b) => b.zIndex.compareTo(a.zIndex));
    for (final obj in sorted) {
      if (obj.rect.contains(position)) {
        return obj.id;
      }
    }
    return null;
  }

  Offset _toWorldPoint(Offset local, TransformationController controller) {
    return MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      local,
    );
  }
}
