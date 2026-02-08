import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/hit_test_visitor.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';

import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';

import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'interaction_state_manager.dart';

/// Manages object selection logic.
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

  SpaceObject? hitTest(
    Offset worldPoint, {
    SelectionFilter filter = SelectionFilter.all,
  }) {
    final activeState = activeBloc.state;
    final visitor = HitTestVisitor(worldPoint);

    // 1. Check if we hit an ALREADY active object
    if (activeState.activeObjects.isNotEmpty) {
      final activeObj = activeState.activeObjects.values.first;

      bool isAllowed = true;
      if (filter == SelectionFilter.connectorsOnly &&
          activeObj is! ConnectorObject) {
        isAllowed = false;
      } else if (filter == SelectionFilter.excludeConnectors &&
          activeObj is ConnectorObject) {
        isAllowed = false;
      }

      if (isAllowed && activeObj.accept(visitor)) {
        return activeObj;
      }
    }

    // 2. Check if we hit a NEW object in ShapeLayer
    final objects = shapeBloc.state.data.objects.values.toList();
    final hitObjects =
        objects.where((obj) {
          if (!obj.accept(visitor)) return false;

          if (filter == SelectionFilter.connectorsOnly &&
              obj is! ConnectorObject) {
            return false;
          }
          if (filter == SelectionFilter.excludeConnectors &&
              obj is ConnectorObject) {
            return false;
          }
          return true;
        }).toList();

    if (hitObjects.isNotEmpty) {
      hitObjects.sort((a, b) => b.zIndex.compareTo(a.zIndex));
      return hitObjects.first;
    }

    return null;
  }

  void selectAt(
    Offset worldPoint, {
    required bool isDrag,
    SelectionFilter filter = SelectionFilter.all,
  }) {
    final hitObject = hitTest(worldPoint, filter: filter);

    final activeState = activeBloc.state;
    final currentlyActive =
        activeState.activeObjects.isNotEmpty
            ? activeState.activeObjects.values.first
            : null;

    if (hitObject != null) {
      // If it's the currently active object
      if (currentlyActive != null && currentlyActive.id == hitObject.id) {
        if (isDrag) {
          activeBloc.add(ActiveLayerEvent.originalObjectSet(hitObject));
          activeBloc.add(
            ActiveLayerEvent.interactionStarted(
              object: hitObject,
              point: worldPoint,
            ),
          );
        }
        return;
      }

      // If it's a new object (from ShapeLayer)
      // First, deselect current if any (though logic usually implies single selection mode here)
      if (currentlyActive != null) {
        interactionManager.commitAndDeactivate();
      }

      activeBloc.add(ActiveLayerEvent.originalObjectSet(hitObject));

      activeBloc.add(
        ActiveLayerEvent.interactionStarted(
          object: hitObject,
          point: worldPoint,
        ),
      );

      if (hitObject is ConnectorObject) {
        toolbarBloc.add(const ToolbarEvent.selected(SpaceTool.selectConnector));
      }
    } else {
      // Nothing hit
      if (currentlyActive != null) {
        interactionManager.commitAndDeactivate();
      } else {
        // Just in case, ensure clean slate
        activeBloc.add(const ActiveLayerEvent.originalObjectSet(null));
        shapeBloc.add(const ShapeLayerEvent.objectSelected(null));
      }
    }
  }

  void selectConnectorAt(Offset worldPoint, {required bool isDrag}) {
    final hitObject = hitTest(
      worldPoint,
      filter: SelectionFilter.all,
    );

    final activeState = activeBloc.state;
    final currentlyActive =
        activeState.activeObjects.isNotEmpty
            ? activeState.activeObjects.values.first
            : null;

    if (hitObject != null) {
      if (currentlyActive != null && currentlyActive.id == hitObject.id) {
        if (isDrag) {
          activeBloc.add(ActiveLayerEvent.originalObjectSet(hitObject));
          activeBloc.add(
            ActiveLayerEvent.interactionStarted(
              object: hitObject,
              point: worldPoint,
            ),
          );
        }
        return;
      }

      if (currentlyActive != null) {
        interactionManager.commitAndDeactivate();
      }

      activeBloc.add(ActiveLayerEvent.originalObjectSet(hitObject));

      activeBloc.add(
        ActiveLayerEvent.interactionStarted(
          object: hitObject,
          point: worldPoint,
        ),
      );

      if (hitObject is! ConnectorObject) {
        toolbarBloc.add(const ToolbarEvent.selected(SpaceTool.select));
      }
    } else {
      if (currentlyActive != null) {
        interactionManager.commitAndDeactivate();
      } else {
        activeBloc.add(const ActiveLayerEvent.originalObjectSet(null));
        shapeBloc.add(const ShapeLayerEvent.objectSelected(null));
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
