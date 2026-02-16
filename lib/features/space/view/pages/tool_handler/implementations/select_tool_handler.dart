import 'package:flutter/material.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/base_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/background_gesture_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/connector_gesture_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_chain_builder.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/node_gesture_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/resize_handle_gesture_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/strategies/interaction_strategy.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/strategies/select_strategies.dart';

/// Handles selection and manipulation (move/resize) of nodes.
///
/// Uses the **Chain of Responsibility** pattern for [onTapUp] and [onPanStart]
/// to determine *what* was clicked, and the **Strategy** pattern for
/// [onPanUpdate] and [onPanEnd] to determine *how* to interact with it.
///
/// ## Tap Gesture Chain Priority (onTapUp)
///
/// 1. **ConnectorGestureHandler** — Connector nodes (highest)
/// 2. **NodeGestureHandler** — Regular nodes (shapes, text, images)
/// 3. **BackgroundGestureHandler** — Empty canvas (lowest / fallback)
///
/// ## Pan Gesture Chain Priority (onPanStart)
///
/// 1. **ResizeHandleGestureHandler** — Resize handles on active nodes (highest)
/// 2. **ConnectorGestureHandler** — Connector nodes
/// 3. **NodeGestureHandler** — Regular nodes (shapes, text, images)
/// 4. **BackgroundGestureHandler** — Empty canvas (lowest / fallback)
///
/// Resize handles are only checked during pan (drag) gestures, not during taps,
/// since tapping a handle area should select the node, not initiate a resize.
class SelectToolHandler extends BaseToolHandler {
  const SelectToolHandler();

  /// Handles tap gestures by routing through the tap gesture handler chain.
  ///
  /// Taps check for connectors and regular nodes (no resize handles).
  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final event = GestureEvent.tapUp(details, controller);
    final chain = _buildTapGestureChain();
    chain.handle(event, context);
  }

  /// Initiates a drag or resize operation by routing through the pan
  /// gesture handler chain.
  ///
  /// Pan start checks resize handles first, then connectors, then nodes.
  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final event = GestureEvent.panStart(details, controller);
    final chain = _buildPanGestureChain();
    chain.handle(event, context);
  }

  /// Handles ongoing drag gestures.
  ///
  /// Delegates to the appropriate [InteractionStrategy] based on the current
  /// state (resize handle active → [ResizeStrategy], nodes selected →
  /// [MoveStrategy], otherwise → [IdleStrategy]).
  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final state = getActiveLayerBloc(context).state;
    final strategy = _getStrategyForState(state);
    strategy.onUpdate(details, context, controller);
  }

  /// Handles the end of a drag or resize operation.
  ///
  /// Delegates to the appropriate [InteractionStrategy] based on the current state.
  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final state = getActiveLayerBloc(context).state;
    final strategy = _getStrategyForState(state);
    strategy.onEnd(details, context, controller);
  }

  /// Builds the gesture chain for tap gestures.
  ///
  /// Taps do NOT check resize handles — they only detect connectors,
  /// regular nodes, or background.
  GestureHandler _buildTapGestureChain() {
    return GestureChainBuilder()
        .addHandler(ConnectorGestureHandler()) // 1. High: Connectors
        .addHandler(NodeGestureHandler()) // 2. Medium: Regular nodes
        .addHandler(BackgroundGestureHandler()) // 3. Low: Background/deselect
        .build();
  }

  /// Builds the gesture chain for pan (drag) gestures.
  ///
  /// Pan gestures check resize handles first (highest priority),
  /// then connectors, nodes, and background.
  GestureHandler _buildPanGestureChain() {
    return GestureChainBuilder()
        .addHandler(ResizeHandleGestureHandler()) // 1. Highest: Resize handles
        .addHandler(ConnectorGestureHandler()) // 2. High: Connectors
        .addHandler(NodeGestureHandler()) // 3. Medium: Regular nodes
        .addHandler(BackgroundGestureHandler()) // 4. Low: Background/deselect
        .build();
  }

  /// Selects the appropriate strategy based on the current active layer state.
  InteractionStrategy _getStrategyForState(ActiveLayerState state) {
    if (state.resizeHandle != null) {
      return const ResizeStrategy();
    } else if (state.activeNodes.isNotEmpty) {
      return const MoveStrategy();
    }
    return const IdleStrategy();
  }
}
