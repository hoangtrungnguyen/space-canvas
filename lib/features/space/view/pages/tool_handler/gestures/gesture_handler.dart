import 'package:flutter/material.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';

/// Base class for the Chain of Responsibility pattern in gesture handling.
///
/// Each [GestureHandler] in the chain checks if it can handle a [GestureEvent].
/// If it can, it processes the event and the chain stops. If it cannot, the
/// event is passed to the [next] handler in the chain.
///
/// ## Usage
///
/// Build a chain by setting the [next] handler:
/// ```dart
/// final chain = ResizeHandleGestureHandler()
///   ..setNext(ConnectorGestureHandler()
///   ..setNext(NodeGestureHandler()
///   ..setNext(BackgroundGestureHandler())));
///
/// chain.handle(event, context);
/// ```
///
/// ## Benefits
///
/// - **Single Responsibility**: Each handler has one job
/// - **Open/Closed**: Add new handlers without modifying existing code
/// - **Explicit Priority**: Chain order defines precedence
/// - **Testable**: Each handler can be tested independently
abstract class GestureHandler {
  /// The next handler in the chain.
  GestureHandler? next;

  /// Sets the next handler in the chain and returns it for fluent chaining.
  GestureHandler setNext(GestureHandler handler) {
    next = handler;
    return handler;
  }

  /// Attempts to handle the [event].
  ///
  /// Returns `true` if this handler (or any handler in the chain) handled
  /// the event, `false` if no handler in the chain could handle it.
  bool handle(GestureEvent event, BuildContext context) {
    if (canHandle(event, context)) {
      doHandle(event, context);
      return true;
    }
    return next?.handle(event, context) ?? false;
  }

  /// Checks whether this handler can process the given [event].
  ///
  /// Implementations should perform lightweight checks (e.g., hit testing)
  /// to determine if this handler is the appropriate one.
  bool canHandle(GestureEvent event, BuildContext context);

  /// Processes the [event].
  ///
  /// Only called when [canHandle] returns `true`. Implementations should
  /// perform the actual gesture handling logic here.
  void doHandle(GestureEvent event, BuildContext context);
}
