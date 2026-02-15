import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';
import 'package:ideascape/features/space/domain/utils/connector_utils.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/base_tool_handler.dart';

/// Handles connector tool interactions using the Mediator and State patterns.
///
/// Connectors can be drawn from any point to any point. If the start or end
/// point is on an object, it will be linked to that object.
class ConnectorToolHandler extends BaseToolHandler {
  const ConnectorToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = toWorldPoint(details.localPosition, controller);
    final activeState = getActiveLayerBloc(context).state;
    final shapeState = getShapeLayerBloc(context).state;

    // Case 1: End the connector (Tap-to-End)
    if (activeState.connectorStartPoint != null) {
      _finalizeConnector(
        context,
        startPoint: activeState.connectorStartPoint!,
        startNodeId: activeState.connectorStartNodeId,
        endPoint: worldPoint,
        shapeState: shapeState,
      );
      return;
    }

    // Case 2: Start the connector (Tap-to-Start)
    if (shapeState is ShapeLayerStateSuccess) {
      final nodeId = _findNodeAt(worldPoint, shapeState.data.nodes);
      if (nodeId != null) {
        final node = shapeState.data.nodes[nodeId];
        if (node != null) {
          // Check if we are close to an anchor
          final anchor = ConnectorUtils.getEdgeFromPoint(node.rect, worldPoint);
          final anchorPoint = ConnectorUtils.getPointOnEdge(node.rect, anchor);

          // Simple distance check (e.g. 20.0 radius)
          if ((worldPoint - anchorPoint).distance <= 20.0) {
            getActiveLayerBloc(context).add(
              ActiveLayerEvent.connectorDragStarted(
                startNodeId: nodeId,
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
    final activeState = getActiveLayerBloc(context).state;
    if (activeState.connectorStartPoint != null) {
      return;
    }

    final worldPoint = toWorldPoint(details.localPosition, controller);

    // Find if we're starting on an object (optional)
    int? startNodeId;
    final state = getShapeLayerBloc(context).state;
    if (state is ShapeLayerStateSuccess) {
      startNodeId = _findNodeAt(worldPoint, state.data.nodes);
    }

    // Always start the drag, even without an object
    getActiveLayerBloc(context).add(
      ActiveLayerEvent.connectorDragStarted(
        startNodeId: startNodeId,
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
    final activeState = getActiveLayerBloc(context).state;
    if (activeState.connectorStartPoint != null) {
      final worldPoint = toWorldPoint(details.localPosition, controller);
      getActiveLayerBloc(context).add(
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
    final activeState = getActiveLayerBloc(context).state;
    final startPoint = activeState.connectorStartPoint;
    final startNodeId = activeState.connectorStartNodeId;
    final endPoint = activeState.connectorDragPosition;

    if (startPoint != null && endPoint != null) {
      final shapeState = getShapeLayerBloc(context).state;
      _finalizeConnector(
        context,
        startPoint: startPoint,
        startNodeId: startNodeId,
        endPoint: endPoint,
        shapeState: shapeState,
      );
    } else {
      // Just clear if valid start/end not present
      getActiveLayerBloc(context).add(
        const ActiveLayerEvent.connectorDragEnded(),
      );
    }
  }

  void _finalizeConnector(
    BuildContext context, {
    required Offset startPoint,
    required Offset endPoint,
    required int? startNodeId,
    required ShapeLayerState shapeState,
  }) {
    final mediator = getMediator(context);

    int? endNodeId;
    if (shapeState is ShapeLayerStateSuccess) {
      endNodeId = _findNodeAt(endPoint, shapeState.data.nodes);
    }

    // Calculate locations
    ConnectorEdge? startLocation;
    ConnectorEdge? endLocation;

    if (shapeState is ShapeLayerStateSuccess) {
      if (startNodeId != null) {
        final startNode = shapeState.data.nodes[startNodeId];
        if (startNode != null) {
          startLocation = ConnectorUtils.getEdgeFromPoint(
            startNode.rect,
            startPoint,
          );
        }
      }
      if (endNodeId != null) {
        final endNode = shapeState.data.nodes[endNodeId];
        if (endNode != null) {
          endLocation = ConnectorUtils.getEdgeFromPoint(endNode.rect, endPoint);
        }
      }
    }

    // Create connector with optional object IDs & locations
    mediator.createConnector(
      startPoint: startPoint,
      endPoint: endPoint,
      startNodeId: startNodeId,
      endNodeId: endNodeId,
      startLocation: startLocation,
      endLocation: endLocation,
    );

    // Switch tool to Select Connector
    getToolbarBloc(context).add(
      ToolbarEvent.selected(SpaceTool.selectConnector),
    );

    // Always clear the drag state
    getActiveLayerBloc(context).add(
      const ActiveLayerEvent.connectorDragEnded(),
    );
  }

  int? _findNodeAt(Offset position, Map<int, Node> nodes) {
    final sorted =
        nodes.values.toList()..sort((a, b) => b.zIndex.compareTo(a.zIndex));
    for (final node in sorted) {
      if (node.rect.contains(position)) {
        return node.id;
      }
    }
    return null;
  }
}
