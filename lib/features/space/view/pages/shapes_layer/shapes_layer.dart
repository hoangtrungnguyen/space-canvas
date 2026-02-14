import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/node_painter.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/pages/active_layer/connector_painter.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';
import 'package:ideascape/features/space/view/constant.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

class ShapesLayer extends StatelessWidget {
  const ShapesLayer({super.key, required this.transformationController});

  final TransformationController transformationController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShapeLayerBloc, ShapeLayerState>(
      buildWhen: (p, c) {
        return p.data.nodes != c.data.nodes ||
            p.data.hiddenNodeIds != c.data.hiddenNodeIds;
      },
      builder: (context, state) {
        // Split nodes into connectors and others for layering
        final connectors = <ConnectorNode>[];
        final otherNodes = <Node>[];
        for (final node in state.data.nodes.values) {
          if (state.data.hiddenNodeIds.contains(node.id)) continue;

          if (node is ConnectorNode) {
            connectors.add(node);
          } else {
            otherNodes.add(node);
          }
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            if (connectors.isNotEmpty)
              CustomPaint(
                size: Size(defaultWidth, defaultHeight),
                painter: ConnectorPainter(
                  connectors: connectors,
                  transform: transformationController.value,
                ),
              ),
            if (otherNodes.isNotEmpty)
              CustomPaint(
                size: Size(defaultWidth, defaultHeight),
                painter: NodePainter(
                  nodes: otherNodes,
                  transform: transformationController.value,
                ),
              ),
          ],
        );
      },
    );
  }
}
