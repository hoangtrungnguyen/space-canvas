import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/view/bloc/canvas_layer/canvas_bloc.dart';

/// A listener widget that responds to CanvasBloc state changes.
///
/// This widget sits between IdeaSpace and SpaceView to handle side effects
/// such as logging, analytics, or triggering actions based on canvas state changes.
class SpaceListener extends StatelessWidget {
  const SpaceListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CanvasBloc, CanvasState>(
      listener: (context, state) {
        // Example: Log canvas transformations
        debugPrint(
          'Canvas transformed - Scale: ${state.scale}, Offset: ${state.offset}',
        );

        // You can add more side effects here:
        // - Show notifications when certain thresholds are reached
        // - Trigger analytics events
        // - Update other parts of the app
        // - Show warnings (e.g., if zoomed out too far)

        // Example: Show a snackbar when zoomed in very close
        if (state.scale > 50.0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Maximum zoom level reached'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            // Main child widget
            child,

            // Debug overlay at top-left
            Positioned(
              top: 16,
              left: 124,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'DEBUG INFO',
                      style: TextStyle(
                        color: Colors.green[300],
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Scale: ${state.scale.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Offset X: ${state.offset.dx.toStringAsFixed(1)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Offset Y: ${state.offset.dy.toStringAsFixed(1)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
