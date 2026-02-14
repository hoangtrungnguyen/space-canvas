import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/domain/models/node_painter.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/pages/active_layer/selection_painter.dart';
import 'package:ideascape/features/space/view/pages/active_layer/connector_preview_painter.dart';
import 'package:ideascape/features/space/view/pages/active_layer/connector_anchor_painter.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';
import 'package:ideascape/features/space/view/pages/active_layer/connector_selection_painter.dart';
import 'package:ideascape/features/space/view/pages/active_layer/connector_painter.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

class ActiveLayer extends StatelessWidget {
  const ActiveLayer({super.key, required this.transformationController});

  final TransformationController transformationController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveLayerBloc, ActiveLayerState>(
      builder: (context, state) {
        // Check if there's anything to render
        final hasActiveNodes = state.activeNodes.isNotEmpty;
        final hasConnectorPreview =
            state.connectorStartPoint != null &&
            state.connectorDragPosition != null;
        final hasConnectorHover = state.connectorHoverNodeId != null;

        if (!hasActiveNodes && !hasConnectorPreview && !hasConnectorHover) {
          return const SizedBox.shrink();
        }

        return AnimatedBuilder(
          animation: transformationController,
          builder: (context, child) {
            return BlocBuilder<ToolbarBloc, ToolbarState>(
              builder: (context, toolbarState) {
                return BlocBuilder<ShapeLayerBloc, ShapeLayerState>(
                  builder: (context, shapeState) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        if (hasActiveNodes)
                          _ActiveNodesView(
                            activeNodes: state.activeNodes,
                            transform: transformationController.value,
                          ),
                        if (hasActiveNodes)
                          _SelectionView(
                            activeNodes: state.activeNodes,
                            tool: toolbarState.tool,
                            transform: transformationController.value,
                          ),
                        if (hasConnectorHover &&
                            toolbarState.tool == SpaceTool.connector)
                          _ConnectorAnchorView(
                            hoveredNodeId: state.connectorHoverNodeId,
                            shapeNodes: shapeState.data.nodes,
                          ),
                        if (hasConnectorPreview)
                          _ConnectorPreviewView(
                            startPoint: state.connectorStartPoint,
                            dragPosition: state.connectorDragPosition,
                          ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class _ActiveNodesView extends StatelessWidget {
  const _ActiveNodesView({required this.activeNodes, required this.transform});

  final Map<int, Node> activeNodes;
  final Matrix4 transform;

  @override
  Widget build(BuildContext context) {
    // Split nodes into connectors and others for layering
    final connectors = activeNodes.values.whereType<ConnectorNode>().toList();
    final otherNodes =
        activeNodes.values.where((node) => node is! ConnectorNode).toList();

    return Stack(
      fit: StackFit.expand,
      children: [
        if (connectors.isNotEmpty)
          CustomPaint(
            size: Size.infinite,
            painter: ConnectorPainter(
              connectors: connectors,
              transform: transform,
            ),
          ),
        if (otherNodes.isNotEmpty)
          CustomPaint(
            size: Size.infinite,
            painter: NodePainter(nodes: otherNodes, transform: transform),
          ),
      ],
    );
  }
}

class _SelectionView extends StatelessWidget {
  const _SelectionView({
    required this.activeNodes,
    required this.tool,
    required this.transform,
  });

  final Map<int, Node> activeNodes;
  final SpaceTool tool;
  final Matrix4 transform;

  @override
  Widget build(BuildContext context) {
    if (tool == SpaceTool.select) {
      return CustomPaint(
        size: Size.infinite,
        painter: SelectionPainter(
          nodes: activeNodes.values.toList(),
          transform: transform,
        ),
      );
    }

    if (tool == SpaceTool.selectConnector) {
      final connectors = activeNodes.values.whereType<ConnectorNode>().toList();
      if (connectors.isNotEmpty) {
        return CustomPaint(
          size: Size.infinite,
          painter: ConnectorSelectionPainter(
            connectors: connectors,
            transform: transform,
          ),
        );
      }
    }

    return const SizedBox.shrink();
  }
}

class _ConnectorAnchorView extends StatelessWidget {
  const _ConnectorAnchorView({
    required this.hoveredNodeId,
    required this.shapeNodes,
  });

  final int? hoveredNodeId;
  final Map<int, Node> shapeNodes;

  @override
  Widget build(BuildContext context) {
    if (hoveredNodeId == null) return const SizedBox.shrink();

    final hoveredNode = shapeNodes[hoveredNodeId];
    if (hoveredNode == null) return const SizedBox.shrink();

    return CustomPaint(
      size: Size.infinite,
      painter: ConnectorAnchorPainter(node: hoveredNode),
    );
  }
}

class _ConnectorPreviewView extends StatelessWidget {
  const _ConnectorPreviewView({
    required this.startPoint,
    required this.dragPosition,
  });

  final Offset? startPoint;
  final Offset? dragPosition;

  @override
  Widget build(BuildContext context) {
    if (startPoint == null || dragPosition == null) {
      return const SizedBox.shrink();
    }

    return CustomPaint(
      size: Size.infinite,
      painter: ConnectorPreviewPainter(
        startPoint: startPoint!,
        endPoint: dragPosition!,
      ),
    );
  }
}
