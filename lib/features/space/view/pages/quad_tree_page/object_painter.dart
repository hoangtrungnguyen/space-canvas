// object_painter.dart
// The CustomPainter responsible for drawing objects and debug info onto the canvas.
// It receives only the *visible* objects to draw, making it highly performant.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as rendering;
import 'package:quadtree_dart/quadtree_dart.dart' as quad_tree;

import 'space_object.dart';
import 'whiteboard_state.dart';

class ObjectPainter extends CustomPainter {
  final TransformationController transformationController;
  final WhiteboardState state;

  ObjectPainter({required this.transformationController, required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    // The current transformation matrix from the InteractiveViewer
    final Matrix4 transform = transformationController.value;

    // --- Culling Step ---
    // 1. Calculate the rectangle representing the visible area of the canvas.
    final Rect visibleRect = _calculateVisibleRect(size, transform);

    // 2. Query the quadtree to get only the objects within that visible rectangle.
    final List<SpaceObject> visibleObjects = state.getVisibleObjects(
      quad_tree.Rect(
        x: visibleRect.top,
        y: visibleRect.left,
        width: visibleRect.width,
        height: visibleRect.height,
      ),
    );

    // --- Drawing Step ---
    // 3. Draw only the visible objects.
    for (final object in visibleObjects) {
      // Create a Rect from our SpaceObject for drawing
      final objectRect = Rect.fromLTWH(
        object.left,
        object.top,
        object.width,
        object.height,
      );
      canvas.drawRect(objectRect, object.paint);
    }

    // --- Debug Visualization ---
    if (state.isDebugMode) {
      _drawDebugInfo(canvas, visibleRect, state.quadtree);
    }
  }

  /// Calculates the visible rectangle in canvas coordinates.
  rendering.Rect _calculateVisibleRect(Size size, Matrix4 transform) {
    // The matrix for converting from screen coordinates to canvas (scene) coordinates
    final Matrix4 invertedMatrix = Matrix4.inverted(transform);

    // Get the top-left and bottom-right corners of the screen
    final Offset topLeftScreen = Offset.zero;
    final Offset bottomRightScreen = size.bottomRight(Offset.zero);

    // Transform these screen corners to canvas coordinates
    final Offset topLeftCanvas = MatrixUtils.transformPoint(
      invertedMatrix,
      topLeftScreen,
    );
    final Offset bottomRightCanvas = MatrixUtils.transformPoint(
      invertedMatrix,
      bottomRightScreen,
    );

    // Create a rectangle from the transformed points
    return rendering.Rect.fromPoints(topLeftCanvas, bottomRightCanvas);
  }

  /// Draws debug information: quadtree nodes and visible area bounds.
  void _drawDebugInfo(
    Canvas canvas,
    rendering.Rect visibleRect,
    quad_tree.Quadtree<SpaceObject> quadtree,
  ) {
    // Paint for quadtree nodes
    final nodePaint =
        Paint()
          ..color = Colors.green.withValues(alpha: 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

    // Retrieve all node boundaries from the quadtree
    final List<quad_tree.Rect> nodes = quadtree.retrieveAllNodes();
    for (final nodeRect in nodes) {
      final rect = rendering.Rect.fromLTWH(
        nodeRect.x,
        nodeRect.y,
        nodeRect.width,
        nodeRect.height,
      );
      canvas.drawRect(rect, nodePaint);
    }

    // Paint for the visible rectangle boundary
    final visibleRectPaint =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;
    canvas.drawRect(visibleRect, visibleRectPaint);

    // Paint for text labels
    _drawDebugText(canvas, visibleRect.topLeft);
  }

  void _drawDebugText(Canvas canvas, Offset position) {
    final textPainter = TextPainter(
      text: TextSpan(
        text:
            'Total Objects: ${state.allObjects.length}\n'
            'Rendered Objects: ${state.visibleObjectCount}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          backgroundColor: Colors.black54,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      position + const Offset(10, 10),
    ); // Offset for padding
  }

  @override
  bool shouldRepaint(covariant ObjectPainter oldDelegate) {
    // The painter should repaint if the state or transform changes.
    // The ListenableBuilder on the InteractiveViewer's controller handles the transform changes.
    // The Provider/Consumer pattern handles the state changes.
    return true;
  }
}
