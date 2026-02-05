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
                          CustomPaint(
                            size: Size.infinite,
                            painter: ObjectPainter(
                              objects: state.activeObjects.values.toList(),
                              transform: transformationController.value,
                            ),
                          ),
                        if (toolbarState.tool == SpaceTool.select &&
                            hasActiveObjects)
                          CustomPaint(
                            size: Size.infinite,
                            painter: SelectionPainter(
                              objects: state.activeObjects.values.toList(),
                              transform: transformationController.value,
                            ),
                          ),
                        // Connector anchor points on hovered object
                        if (hasConnectorHover &&
                            toolbarState.tool == SpaceTool.connector)
                          Builder(
                            builder: (context) {
                              final hoveredObject =
                                  shapeState.data.objects[state
                                      .connectorHoverObjectId];
                              if (hoveredObject == null) {
                                return const SizedBox.shrink();
                              }
                              return CustomPaint(
                                size: Size.infinite,
                                painter: ConnectorAnchorPainter(
                                  object: hoveredObject,
                                ),
                              );
                            },
                          ),
                        // Connector preview while dragging
                        if (hasConnectorPreview)
                          CustomPaint(
                            size: Size.infinite,
                            painter: ConnectorPreviewPainter(
                              startPoint: state.connectorStartPoint!,
                              endPoint: state.connectorDragPosition!,
                            ),
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
