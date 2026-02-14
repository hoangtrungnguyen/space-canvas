import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/utils/connector_utils.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

class ActiveNodeObserver extends StatelessWidget {
  final Widget child;

  const ActiveNodeObserver({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActiveLayerBloc, ActiveLayerState>(
      listener: (context, activeState) {
        final activeNodes = activeState.activeNodes;

        // Optimized: unexpected non-movement updates might trigger this,
        // but checking emptiness is a good first step.
        // Ideally we only want to run this if nodes *moved*.
        // The bloc event stream should mostly be movement during drag.
        if (activeNodes.isEmpty) return;

        final shapeBloc = context.read<ShapeLayerBloc>();
        final shapeState = shapeBloc.state;
        final allNodes = shapeState.data.nodes;

        List<Node> updatedConnectors = [];

        for (final activeNode in activeNodes.values) {
          // Find connectors attached to this node
          final attachedConnectors = allNodes.values
              .whereType<ConnectorNode>()
              .where((c) {
                return c.startNodeId == activeNode.id ||
                    c.endNodeId == activeNode.id;
              });

          for (final connector in attachedConnectors) {
            ConnectorNode updatedConnector = connector;
            bool changed = false;

            if (connector.startNodeId == activeNode.id) {
              // Update start point
              // Logic: Start point should be the center of the active node?
              // Or closest point?
              // Prerequisite: Maintain relative offset or snap to center/edge.
              // For MVP/simplicity: Move start point by the same delta?
              // The active node in ActiveLayerState has the NEW position.
              // We need to calculate where the connection point should be.
              //
              // Using existing simple logic: Center of rect for now, or maintain relative?
              // Re-reading usage: "connectors move accordingly".
              //
              // Better implementation:
              // If we knew the anchor placement (relative), we'd re-calculate.
              // Let's assume clamping to center or a specific edge point.
              //
              // Let's look at `ConnectorNode` - it has `startPoint`, `endPoint`.
              // It also has `startLocation` (Edge).
              //
              // Strategy: Re-calculate point on the node rect based on `startLocation`.
              // If `startLocation` is null, maybe just keep it relative?
              // Let's assume standard behavior: Snap to center of the edge defined by startLocation.

              if (connector.startLocation != null) {
                final newStart = ConnectorUtils.getPointOnEdge(
                  activeNode.rect,
                  connector.startLocation!,
                );
                if (newStart != updatedConnector.startPoint) {
                  updatedConnector = updatedConnector.copyWith(
                    startPoint: newStart,
                  );
                  changed = true;
                }
              }
            }

            if (connector.endNodeId == activeNode.id) {
              if (connector.endLocation != null) {
                final newEnd = ConnectorUtils.getPointOnEdge(
                  activeNode.rect,
                  connector.endLocation!,
                );
                if (newEnd != updatedConnector.endPoint) {
                  updatedConnector = updatedConnector.copyWith(
                    endPoint: newEnd,
                  );
                  changed = true;
                }
              }
            }
            if (changed) {
              updatedConnectors.add(updatedConnector);
            }
          }
        }

        if (updatedConnectors.isNotEmpty) {
          shapeBloc.add(ShapeLayerEvent.updateNodes(updatedConnectors));
        }
      },
      child: child,
    );
  }
}
