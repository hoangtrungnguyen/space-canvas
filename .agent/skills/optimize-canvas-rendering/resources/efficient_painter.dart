import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

// --- View Model (Decoupled from BLoC State) ---
class ShapeViewModel extends Equatable {
  final String id;
  final Offset position;
  final Color color;
  final double radius;

  const ShapeViewModel({
    required this.id,
    required this.position,
    required this.color,
    required this.radius,
  });

  @override
  List<Object> get props => [id, position, color, radius];
}

// --- The Painter ---
class EfficientShapePainter extends CustomPainter {
  final ShapeViewModel data;

  EfficientShapePainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    // Optimization: Avoid heavy calculations in paint
    // Optimization: Use primitive drawing commands where possible
    final paint =
        Paint()
          ..color = data.color
          ..style = PaintingStyle.fill;

    canvas.drawCircle(data.position, data.radius, paint);
  }

  @override
  bool shouldRepaint(covariant EfficientShapePainter oldDelegate) {
    // Optimization: Granular check
    // Only repaint if the data explicitly changed
    return oldDelegate.data != data;
  }
}

// --- Usage in Widget ---
class OptimizedShapeWidget extends StatelessWidget {
  final ShapeViewModel shape;

  const OptimizedShapeWidget({super.key, required this.shape});

  @override
  Widget build(BuildContext context) {
    // Optimization: RepaintBoundary isolates this painter from parent rebuilds
    return RepaintBoundary(
      child: CustomPaint(
        painter: EfficientShapePainter(data: shape),
        size: Size(shape.radius * 2, shape.radius * 2),
      ),
    );
  }
}
