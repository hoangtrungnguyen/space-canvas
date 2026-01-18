import 'package:flutter/material.dart';

import '../space/domain/models/grid_painter.dart';

class GridInteractionDemo extends StatefulWidget {
  const GridInteractionDemo({super.key});

  @override
  State<GridInteractionDemo> createState() => _GridInteractionDemoState();
}

class _GridInteractionDemoState extends State<GridInteractionDemo> {
  late TransformationController _transformationController;

  // Store positions of the draggable cards
  final List<Offset> _cardPositions = [
    const Offset(100, 200),
    const Offset(350, 350),
    const Offset(200, 500),
  ];

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Grid Canvas'),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      backgroundColor: const Color(0xFFFFFFFF), // Dark canvas background
      body: InteractiveViewer(
        transformationController: _transformationController,
        boundaryMargin: const EdgeInsets.all(double.infinity),
        minScale: 0.1,
        maxScale: 4.0,
        // Use an AnimatedBuilder to listen for changes in the controller
        // and rebuild the grid painter efficiently.
        child: AnimatedBuilder(
          animation: _transformationController,
          builder: (context, child) {
            return Stack(
              children: [
                // The Grid Painter
                CustomPaint(
                  // Make the painter cover the entire viewport
                  size: MediaQuery.of(context).size * 20, // A very large canvas
                  painter: GridPainter(
                    transformationController: _transformationController,
                    gridSpacing: 50.0,
                    gridColor: Colors.grey,
                  ),
                ),
                // Your interactive content goes here
                ..._buildDraggableCards(),
              ],
            );
          },
        ),
      ),
    );
  }

  // Helper to build the draggable card widgets
  List<Widget> _buildDraggableCards() {
    return List.generate(_cardPositions.length, (index) {
      return Positioned(
        left: _cardPositions[index].dx,
        top: _cardPositions[index].dy,
        child: Draggable(
          // The widget that is dragged
          feedback: _buildCard('Card ${index + 1}', isDragging: true),
          // The widget that is displayed in the original position
          child: _buildCard('Card ${index + 1}'),
          // Update position when drag ends
          onDragEnd: (details) {
            // The InteractiveViewer's coordinate system is what we need.
            // We get the new position by transforming the global drag-end position
            // back into the local coordinate system of the InteractiveViewer's child.
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final Offset localOffset = renderBox.globalToLocal(details.offset);
            final Matrix4 inverseMatrix = Matrix4.inverted(
              _transformationController.value,
            );
            final Offset relativeOffset = MatrixUtils.transformPoint(
              inverseMatrix,
              localOffset,
            );

            setState(() {
              _cardPositions[index] = relativeOffset;
            });
          },
        ),
      );
    });
  }

  // Helper to build a single card widget
  Widget _buildCard(String text, {bool isDragging = false}) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 180,
        height: 100,
        decoration: BoxDecoration(
          color: isDragging ? Colors.teal.withValues(alpha: 0.8) : Colors.teal,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!isDragging)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
