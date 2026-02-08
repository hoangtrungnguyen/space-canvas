import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/toolbar/toolbar_widget.dart';
import 'package:ideascape/features/space/view/widgets/shape_library.dart';

import 'package:ideascape/features/space/domain/models/object_painter.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler_factory.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/widgets/inline_text_editor.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_object.dart';

class ToolbarLayer extends StatelessWidget {
  const ToolbarLayer({super.key, required this.transformationController});

  final TransformationController transformationController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToolbarBloc, ToolbarState>(
      builder: (context, state) {
        return CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.keyZ, meta: true):
                () => context.read<HistoryManager>().undo(),
            const SingleActivator(
                  LogicalKeyboardKey.keyZ,
                  meta: true,
                  shift: true,
                ):
                () => context.read<HistoryManager>().redo(),
            // Alternative shortcut for Redo (Cmd+Y)
            const SingleActivator(LogicalKeyboardKey.keyY, meta: true):
                () => context.read<HistoryManager>().redo(),
          },
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              // Display active drawing object
              if (state.activeDrawingObject != null)
                AnimatedBuilder(
                  animation: transformationController,
                  builder: (context, child) {
                    return IgnorePointer(
                      child: Transform(
                        transform: transformationController.value,
                        child: RepaintBoundary(
                          child: CustomPaint(
                            size: Size.infinite,
                            painter: ObjectPainter(
                              objects: [state.activeDrawingObject!],
                              transform: transformationController.value,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              // Gesture detector for interactions (e.g. drawing, placing shapes)
              // It only intercepts gestures when the current tool is NOT the pan tool.
              if (state.tool != SpaceTool.pan)
                MouseRegion(
                  onHover:
                      state.tool == SpaceTool.connector
                          ? (event) {
                            _handleConnectorHover(
                              event.localPosition,
                              context,
                              transformationController,
                            );
                          }
                          : null,
                  onExit:
                      state.tool == SpaceTool.connector
                          ? (_) {
                            context.read<ActiveLayerBloc>().add(
                              const ActiveLayerEvent.connectorHoverChanged(
                                null,
                              ),
                            );
                          }
                          : null,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTapUp: (details) {
                      final handler = ToolHandlerFactory.getHandler(state.tool);
                      handler.onTapUp(
                        details,
                        context,
                        transformationController,
                      );
                    },
                    onPanStart: (details) {
                      final handler = ToolHandlerFactory.getHandler(state.tool);
                      handler.onPanStart(
                        details,
                        context,
                        transformationController,
                      );
                    },
                    onPanUpdate: (details) {
                      final handler = ToolHandlerFactory.getHandler(state.tool);
                      handler.onPanUpdate(
                        details,
                        context,
                        transformationController,
                      );
                    },
                    onPanEnd: (details) {
                      final handler = ToolHandlerFactory.getHandler(state.tool);
                      handler.onPanEnd(
                        details,
                        context,
                        transformationController,
                      );
                    },
                  ),
                ),

              // Left-side main toolbar
              const Positioned(top: 16, left: 16, child: ToolbarWidget()),

              // Shape Library Panel
              if (state.tool == SpaceTool.shape)
                Positioned(
                  top: 16,
                  left: 90, // Next to toolbar
                  child: ShapeLibrary(
                    selectedShapeType: state.activeShapeType,
                    onShapeSelected: (type) {
                      context.read<ToolbarBloc>().add(
                        ToolbarEvent.shapeSelected(type),
                      );
                    },
                  ),
                ),
              // Inline text editor
              if (state.editingObject != null)
                InlineTextEditor(
                  textObject: state.editingObject!,
                  transformationController: transformationController,
                ),
            ],
          ),
        );
      },
    );
  }

  void _handleConnectorHover(
    Offset localPosition,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      localPosition,
    );

    final activeState = context.read<ActiveLayerBloc>().state;
    // If we are in the middle of creating a connector (Tap started),
    // update the drag position to follow the mouse
    if (activeState.connectorStartPoint != null) {
      context.read<ActiveLayerBloc>().add(
        ActiveLayerEvent.connectorDragUpdated(worldPoint),
      );
    }

    final shapeState = context.read<ShapeLayerBloc>().state;
    if (shapeState is ShapeLayerStateSuccess) {
      int? hoveredId;
      // Find object under cursor (sorted by z-index, top-most first)
      final sorted =
          shapeState.data.objects.values.toList()
            ..sort((a, b) => b.zIndex.compareTo(a.zIndex));

      for (final obj in sorted) {
        if (obj is ConnectorObject) continue;
        if (obj.rect.contains(worldPoint)) {
          hoveredId = obj.id;
          break;
        }
      }
      context.read<ActiveLayerBloc>().add(
        ActiveLayerEvent.connectorHoverChanged(hoveredId),
      );
    }
  }
}
