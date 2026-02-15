import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/visitors/hit_test_visitor.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';

import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';

import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'interaction_state_manager.dart';

/// Manages node selection logic.
class SelectionManager {
  final ActiveLayerBloc activeBloc;
  final ShapeLayerBloc shapeBloc;
  final ToolbarBloc toolbarBloc;
  final InteractionStateManager interactionManager;

  SelectionManager({
    required this.activeBloc,
    required this.shapeBloc,
    required this.toolbarBloc,
    required this.interactionManager,
  });

  Node? hitTest(
    Offset worldPoint, {
    SelectionFilter filter = SelectionFilter.all,
  }) {
    final activeState = activeBloc.state;
    final visitor = HitTestVisitor(worldPoint);

    // 1. Check if we hit an ALREADY active node
    if (activeState.activeNodes.isNotEmpty) {
      final activeNode = activeState.activeNodes.values.first;

      bool isAllowed = true;
      if (filter == SelectionFilter.connectorsOnly &&
          activeNode is! ConnectorNode) {
        isAllowed = false;
      } else if (filter == SelectionFilter.excludeConnectors &&
          activeNode is ConnectorNode) {
        isAllowed = false;
      }

      if (isAllowed && activeNode.accept(visitor)) {
        return activeNode;
      }
    }

    // 2. Check if we hit a NEW node in ShapeLayer
    final nodes = shapeBloc.state.data.nodes.values.toList();
    final hitNodes =
        nodes.where((node) {
          if (!node.accept(visitor)) return false;

          if (filter == SelectionFilter.connectorsOnly &&
              node is! ConnectorNode) {
            return false;
          }
          if (filter == SelectionFilter.excludeConnectors &&
              node is ConnectorNode) {
            return false;
          }
          return true;
        }).toList();

    if (hitNodes.isNotEmpty) {
      hitNodes.sort((a, b) => b.zIndex.compareTo(a.zIndex));
      return hitNodes.first;
    }

    return null;
  }

  void selectAt(
    Offset worldPoint, {
    required bool isDrag,
    SelectionFilter filter = SelectionFilter.all,
  }) {
    final hitNode = hitTest(worldPoint, filter: filter);

    final activeState = activeBloc.state;
    final currentlyActive =
        activeState.activeNodes.isNotEmpty
            ? activeState.activeNodes.values.first
            : null;

    if (hitNode != null) {
      // If it's the currently active node
      if (currentlyActive != null && currentlyActive.id == hitNode.id) {
        if (isDrag) {
          activeBloc.add(ActiveLayerEvent.originalNodeSet(hitNode));
          activeBloc.add(
            ActiveLayerEvent.interactionStarted(
              node: hitNode,
              point: worldPoint,
            ),
          );
        }
        return;
      }

      // If it's a new node (from ShapeLayer)
      // First, deselect current if any (though logic usually implies single selection mode here)
      if (currentlyActive != null) {
        interactionManager.commitAndDeactivate();
      }

      activeBloc.add(ActiveLayerEvent.originalNodeSet(hitNode));

      activeBloc.add(
        ActiveLayerEvent.interactionStarted(node: hitNode, point: worldPoint),
      );

      if (hitNode is ConnectorNode) {
        toolbarBloc.add(const ToolbarEvent.selected(SpaceTool.selectConnector));
      } else {
        toolbarBloc.add(const ToolbarEvent.selected(SpaceTool.select));
      }
    } else {
      // Nothing hit
      if (currentlyActive != null) {
        interactionManager.commitAndDeactivate();
      } else {
        // Just in case, ensure clean slate
        activeBloc.add(const ActiveLayerEvent.originalNodeSet(null));
        shapeBloc.add(const ShapeLayerEvent.nodeSelected(null));
      }
    }
  }

  void selectConnectorAt(Offset worldPoint, {required bool isDrag}) {
    final hitNode = hitTest(worldPoint, filter: SelectionFilter.all);

    final activeState = activeBloc.state;
    final currentlyActive =
        activeState.activeNodes.isNotEmpty
            ? activeState.activeNodes.values.first
            : null;

    if (hitNode != null) {
      if (currentlyActive != null && currentlyActive.id == hitNode.id) {
        if (isDrag) {
          activeBloc.add(ActiveLayerEvent.originalNodeSet(hitNode));
          activeBloc.add(
            ActiveLayerEvent.interactionStarted(
              node: hitNode,
              point: worldPoint,
            ),
          );
        }
        return;
      }

      if (currentlyActive != null) {
        interactionManager.commitAndDeactivate();
      }

      activeBloc.add(ActiveLayerEvent.originalNodeSet(hitNode));

      activeBloc.add(
        ActiveLayerEvent.interactionStarted(node: hitNode, point: worldPoint),
      );

      if (hitNode is! ConnectorNode) {
        toolbarBloc.add(const ToolbarEvent.selected(SpaceTool.select));
      }
    } else {
      if (currentlyActive != null) {
        interactionManager.commitAndDeactivate();
      } else {
        activeBloc.add(const ActiveLayerEvent.originalNodeSet(null));
        shapeBloc.add(const ShapeLayerEvent.nodeSelected(null));
      }
    }
  }

  SpaceTool determineSelectionTool(Offset worldPoint) {
    if (hitTest(worldPoint, filter: SelectionFilter.connectorsOnly) != null) {
      return SpaceTool.selectConnector;
    }
    return SpaceTool.select;
  }
}
