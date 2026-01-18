import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/grid_painter.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/active_layer/active_layer.dart';
import 'package:ideascape/features/space/view/pages/shapes_layer/shapes_layer.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler_factory.dart';

class CanvasLayer extends StatelessWidget {
  const CanvasLayer({super.key, required this.transformationController});

  final TransformationController transformationController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToolbarBloc, ToolbarState>(
      buildWhen: (p, c) {
        return p.tool != c.tool;
      },
      builder: (context, state) {
        return InteractiveViewer(
          panEnabled: state.panEnabled,
          transformationController: transformationController,
          boundaryMargin: const EdgeInsets.all(double.infinity),
          minScale: 0.02,
          scaleFactor: 0.1,
          maxScale: 100.0,
          child: AnimatedBuilder(
            animation: transformationController,
            builder: (BuildContext context, Widget? child) {
              return GestureDetector(
                onTapUp: (details) {
                  final tool = context.read<ToolbarBloc>().state.tool;
                  final handler = ToolHandlerFactory.getHandler(tool);
                  handler.onTapUp(details, context, transformationController);
                },
                onPanStart:
                    state.panEnabled
                        ? null
                        : (details) {
                          final tool = context.read<ToolbarBloc>().state.tool;
                          final handler = ToolHandlerFactory.getHandler(tool);
                          handler.onPanStart(
                            details,
                            context,
                            transformationController,
                          );
                        },
                onPanUpdate:
                    state.panEnabled
                        ? null
                        : (details) {
                          final tool = context.read<ToolbarBloc>().state.tool;
                          final handler = ToolHandlerFactory.getHandler(tool);
                          handler.onPanUpdate(
                            details,
                            context,
                            transformationController,
                          );
                        },
                onPanEnd:
                    state.panEnabled
                        ? null
                        : (details) {
                          final tool = context.read<ToolbarBloc>().state.tool;
                          final handler = ToolHandlerFactory.getHandler(tool);
                          handler.onPanEnd(
                            details,
                            context,
                            transformationController,
                          );
                        },
                child: Stack(
                  children: [
                    CustomPaint(
                      size: MediaQuery.of(context).size * 15,
                      painter: GridPainter(
                        transformationController: transformationController,
                      ),
                    ),
                    ShapesLayer(
                      transformationController: transformationController,
                    ),
                    const ActiveLayer(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

extension on ToolbarState {
  bool get panEnabled => tool == SpaceTool.pan;
}
