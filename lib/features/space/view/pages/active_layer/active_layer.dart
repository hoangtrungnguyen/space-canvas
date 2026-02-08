import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/domain/models/object_painter.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/pages/active_layer/selection_painter.dart';
import 'package:ideascape/features/space/view/pages/active_layer/connector_preview_painter.dart';
import 'package:ideascape/features/space/view/pages/active_layer/connector_anchor_painter.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_object.dart';
import 'package:ideascape/features/space/view/pages/active_layer/connector_selection_painter.dart';
import 'package:ideascape/features/space/view/pages/active_layer/connector_painter.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

class ActiveLayer extends StatelessWidget {
  const ActiveLayer({super.key, required this.transformationController});

  final TransformationController transformationController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveLayerBloc, ActiveLayerState>(
      builder: (context, state) {
        // Check if there's anything to render
        final hasActiveObjects = state.activeObjects.isNotEmpty;
        final hasConnectorPreview =
            state.connectorStartPoint != null &&
            state.connectorDragPosition != null;
        final hasConnectorHover = state.connectorHoverObjectId != null;

        if (!hasActiveObjects && !hasConnectorPreview && !hasConnectorHover) {
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
                        if (hasActiveObjects)
                          _ActiveObjectsView(
                            activeObjects: state.activeObjects,
                            transform: transformationController.value,
                          ),
                        if (hasActiveObjects)
                          _SelectionView(
                            activeObjects: state.activeObjects,
                            tool: toolbarState.tool,
                            transform: transformationController.value,
                          ),
                        if (hasConnectorHover &&
                            toolbarState.tool == SpaceTool.connector)
                          _ConnectorAnchorView(
                            hoveredObjectId: state.connectorHoverObjectId,
                            shapeObjects: shapeState.data.objects,
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

class _ActiveObjectsView extends StatelessWidget {
  const _ActiveObjectsView({
    required this.activeObjects,
    required this.transform,
  });

  final Map<int, SpaceObject> activeObjects;
  final Matrix4 transform;

  @override
  Widget build(BuildContext context) {
    // Split objects into connectors and others for layering
    final connectors =
        activeObjects.values.whereType<ConnectorObject>().toList();
    final otherObjects =
        activeObjects.values.where((obj) => obj is! ConnectorObject).toList();

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
        if (otherObjects.isNotEmpty)
          CustomPaint(
            size: Size.infinite,
            painter: ObjectPainter(objects: otherObjects, transform: transform),
          ),
      ],
    );
  }
}

class _SelectionView extends StatelessWidget {
  const _SelectionView({
    required this.activeObjects,
    required this.tool,
    required this.transform,
  });

  final Map<int, SpaceObject> activeObjects;
  final SpaceTool tool;
  final Matrix4 transform;

  @override
  Widget build(BuildContext context) {
    if (tool == SpaceTool.select) {
      return CustomPaint(
        size: Size.infinite,
        painter: SelectionPainter(
          objects: activeObjects.values.toList(),
          transform: transform,
        ),
      );
    }

    if (tool == SpaceTool.selectConnector) {
      final connectors =
          activeObjects.values.whereType<ConnectorObject>().toList();
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
    required this.hoveredObjectId,
    required this.shapeObjects,
  });

  final int? hoveredObjectId;
  final Map<int, SpaceObject> shapeObjects;

  @override
  Widget build(BuildContext context) {
    if (hoveredObjectId == null) return const SizedBox.shrink();

    final hoveredObject = shapeObjects[hoveredObjectId];
    if (hoveredObject == null) return const SizedBox.shrink();

    return CustomPaint(
      size: Size.infinite,
      painter: ConnectorAnchorPainter(object: hoveredObject),
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
