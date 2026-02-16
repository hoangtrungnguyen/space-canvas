import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_handler.dart';

/// Utility for building gesture handler chains with fluent API.
///
/// Example:
/// ```dart
/// final chain = GestureChainBuilder()
///   .addHandler(ResizeHandleGestureHandler())
///   .addHandler(ConnectorGestureHandler())
///   .addHandler(NodeGestureHandler())
///   .addHandler(BackgroundGestureHandler())
///   .build();
/// ```
class GestureChainBuilder {
  final List<GestureHandler> _handlers = [];

  /// Adds a handler to the end of the chain.
  GestureChainBuilder addHandler(GestureHandler handler) {
    _handlers.add(handler);
    return this;
  }

  /// Builds the chain and returns the first handler (head of chain).
  ///
  /// Throws [StateError] if no handlers have been added.
  GestureHandler build() {
    if (_handlers.isEmpty) {
      throw StateError('Cannot build an empty gesture chain.');
    }

    // Link each handler to the next one
    for (var i = 0; i < _handlers.length - 1; i++) {
      _handlers[i].setNext(_handlers[i + 1]);
    }

    return _handlers.first;
  }
}
