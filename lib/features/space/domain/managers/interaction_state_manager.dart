import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/commands/add_connector_command.dart';
import 'package:ideascape/features/space/domain/commands/add_node_command.dart';
import 'package:ideascape/features/space/domain/models/connector_handle.dart';
import 'package:ideascape/features/space/domain/commands/reshape_connector_command.dart';
import 'package:ideascape/features/space/domain/commands/batch_delete_command.dart';
import 'package:ideascape/features/space/domain/commands/delete_node_command.dart';
import 'package:ideascape/features/space/domain/commands/move_node_command.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/objects/extensions/node_extensions.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

/// Manages the lifecycle of interactions, including committing changes,
/// finalizing moves, and handling deletions.
class InteractionStateManager {
  final ActiveLayerBloc activeBloc;
  final ShapeLayerBloc shapeBloc;
  final HistoryManager history;

  InteractionStateManager({
    required this.activeBloc,
    required this.shapeBloc,
    required this.history,
  });

  void finalizeInteraction() {
    final state = activeBloc.state;
    if (state.activeNodes.isNotEmpty) {
      final node = state.activeNodes.values.first;
      final originalNode = state.originalNode;

      // If we have an original node and position changed, record the move
      if (originalNode != null && originalNode.id == node.id) {
        // Check if the node actually moved
        if (_hasNodeMoved(originalNode, node)) {
          history.execute(
            MoveNodeCommand(originalNode: originalNode, movedNode: node),
          );
        }
      }

      activeBloc.add(ActiveLayerEvent.nodeActivated(node));
    }
  }

  void commitAndDeactivate() {
    final state = activeBloc.state;
    if (state.activeNodes.isNotEmpty) {
      final node = state.activeNodes.values.first;
      final originalNode = state.originalNode;

      final existsInShapeLayer = shapeBloc.state.data.nodes.containsKey(
        node.id,
      );

      // An object is "existing" if it's in the ShapeLayer OR if we have its original state tracked
      final isExisting =
          existsInShapeLayer ||
          (originalNode != null && originalNode.id == node.id);

      if (isExisting) {
        // If the node exists, we should finalize any pending interactions (moves, reshapes)
        if (node is ConnectorNode) {
          finalizeConnectorInteraction();
        } else {
          finalizeInteraction();
        }

        // If the object was removed from ShapeLayer (e.g. valid "Layer Hopping") but NOT modified,
        // no Command would have been executed by finalize* methods.
        // We must manually restore it to the ShapeLayer in this case.
        if (!existsInShapeLayer && originalNode != null) {
          bool changed = false;
          if (node is ConnectorNode) {
            // Connector interactions generally create a new instance if changed
            changed = (originalNode != node);
          } else {
            changed = _hasNodeMoved(originalNode, node);
          }

          if (!changed) {
            shapeBloc.add(ShapeLayerEvent.addNode(node));
          }
        }
      } else {
        // It's a truly new node (or we lost tracking), so add it via Command
        history.execute(AddNodeCommand(node));
      }

      activeBloc.add(ActiveLayerEvent.nodeDeactivated(node.id));
    }
  }

  void commitImmediate(Node node) {
    history.execute(AddNodeCommand(node));
  }

  void deleteNode(Node node) {
    history.execute(DeleteNodeCommand(node));
  }

  void deleteNodes(List<Node> nodes) {
    if (nodes.isEmpty) return;
    if (nodes.length == 1) {
      deleteNode(nodes.first);
    } else {
      history.execute(BatchDeleteCommand(nodes));
    }
  }

  void createConnector({
    required Offset startPoint,
    required Offset endPoint,
    int? startNodeId,
    int? endNodeId,
    ConnectorEdge? startLocation,
    ConnectorEdge? endLocation,
  }) {
    final id = DateTime.now().microsecondsSinceEpoch; // Simple unique ID
    final connector = ConnectorNode(
      id: id,
      startNodeId: startNodeId,
      endNodeId: endNodeId,
      startPoint: startPoint,
      endPoint: endPoint,
      strokeWidth: 2.0,
      color: Colors.black.toARGB32(),
      startLocation: startLocation,
      endLocation: endLocation,
    );
    history.execute(AddConnectorCommand(connector));
  }

  /// Checks if a node has actually moved from its original position.
  bool _hasNodeMoved(Node original, Node current) {
    return current.hasMovedFrom(original);
  }

  void dragActiveNode(Offset worldPoint, Offset delta) {
    final state = activeBloc.state;
    if (state.activeNodes.isNotEmpty && state.dragStartPoint != null) {
      final node = state.activeNodes.values.first;
      final updatedNode = node.move(delta);

      if (updatedNode != null) {
        activeBloc.add(
          ActiveLayerEvent.interactionStarted(
            node: updatedNode,
            point: worldPoint,
          ),
        );
      }
    }
  }

  void dragActiveConnector(Offset worldPoint, Offset delta) {
    final state = activeBloc.state;
    if (state.activeNodes.isNotEmpty && state.dragStartPoint != null) {
      final node = state.activeNodes.values.first;

      if (node is ConnectorNode) {
        ConnectorNode updatedConnector;
        if (state.connectorHandle == ConnectorHandle.start) {
          updatedConnector = node.copyWith(startPoint: node.startPoint + delta);
        } else if (state.connectorHandle == ConnectorHandle.end) {
          updatedConnector = node.copyWith(endPoint: node.endPoint + delta);
        } else {
          updatedConnector = node.copyWith(
            startPoint: node.startPoint + delta,
            endPoint: node.endPoint + delta,
          );
        }

        activeBloc.add(
          ActiveLayerEvent.interactionStarted(
            node: updatedConnector,
            point: worldPoint,
          ),
        );
      }
    }
  }

  void finalizeConnectorInteraction() {
    final state = activeBloc.state;
    if (state.activeNodes.isNotEmpty) {
      final node = state.activeNodes.values.first;
      if (node is ConnectorNode) {
        final original = state.originalNode;
        if (original is ConnectorNode && original.id == node.id) {
          if (original != node) {
            history.execute(
              ReshapeConnectorCommand(
                originalNode: original,
                modifiedNode: node,
              ),
            );
          }
        }
        activeBloc.add(ActiveLayerEvent.nodeActivated(node));
      }
    }
  }
}
