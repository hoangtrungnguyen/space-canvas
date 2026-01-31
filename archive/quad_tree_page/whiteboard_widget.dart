import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'object_painter.dart';
import 'space_object.dart';
import 'whiteboard_state.dart';

class WhiteboardWidget extends StatefulWidget {
  const WhiteboardWidget({super.key});

  @override
  State<WhiteboardWidget> createState() => _WhiteboardWidgetState();
}

class _WhiteboardWidgetState extends State<WhiteboardWidget> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<WhiteboardState>(context);

    return GestureDetector(
      onTapUp: (details) {
        // Convert screen coordinates to canvas coordinates
        final canvasOffset = _transformationController.toScene(
          details.localPosition,
        );

        // Create and add a new object at the tapped location
        final newObject = SpaceObject(
          x: canvasOffset.dx - 15, // Center the object on the tap
          y: canvasOffset.dy - 15,
          width: 30,
          height: 30,
          color: Colors.amber,
        );
        state.addObject(newObject);
      },
      child: InteractiveViewer(
        transformationController: _transformationController,
        // Set boundary margin to allow panning beyond the initial content
        boundaryMargin: const EdgeInsets.all(double.infinity),
        minScale: 0.1,
        maxScale: 4.0,
        // We listen to the controller to trigger repaints on pan/zoom
        child: ListenableBuilder(
          listenable: _transformationController,
          builder: (context, child) {
            return CustomPaint(
              // The painter takes the current transform and other state
              painter: ObjectPainter(
                transformationController: _transformationController,
                state: state,
              ),
              // This child ensures the CustomPaint has a size to draw on
              child: Container(),
            );
          },
        ),
      ),
    );
  }
}
