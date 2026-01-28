import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/grid_painter.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/active_layer/active_layer.dart';
import 'package:ideascape/features/space/view/pages/shapes_layer/shapes_layer.dart';

class CanvasLayer extends StatefulWidget {
  const CanvasLayer({super.key, required this.transformationController});

  final TransformationController transformationController;

  @override
  State<CanvasLayer> createState() => _CanvasLayerState();
}

class _CanvasLayerState extends State<CanvasLayer> {
  @override
  void initState() {
    super.initState();

    widget.transformationController.addListener(() {
      final matrix = widget.transformationController.value;
      final scale = matrix.getMaxScaleOnAxis();
      final translation = matrix.getTranslation();

      context.read<CanvasBloc>().add(
        CanvasEvent.transformUpdated(
          offset: Offset(translation.x, translation.y),
          scale: scale,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToolbarBloc, ToolbarState>(
      buildWhen: (p, c) {
        return p.tool != c.tool;
      },
      builder: (context, state) {
        return InteractiveViewer(
          panEnabled: state.panEnabled,
          transformationController: widget.transformationController,
          boundaryMargin: const EdgeInsets.all(double.infinity),
          minScale: 0.02,
          scaleFactor: 0.1,
          maxScale: 100.0,
          child: AnimatedBuilder(
            animation: widget.transformationController,
            builder: (BuildContext context, Widget? child) {
              return Stack(
                children: [
                  CustomPaint(
                    size: MediaQuery.of(context).size * 15,
                    painter: GridPainter(
                      transformationController: widget.transformationController,
                    ),
                  ),
                  ShapesLayer(
                    transformationController: widget.transformationController,
                  ),
                  ActiveLayer(
                    transformationController: widget.transformationController,
                  ),
                ],
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
