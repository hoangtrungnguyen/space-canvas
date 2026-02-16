import 'package:flutter/material.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/base_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/connector_background_gesture_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/connector_body_gesture_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/connector_handle_gesture_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_chain_builder.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/strategies/connector_strategies.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/strategies/interaction_strategy.dart';

/// Handles selection and manipulation of connectors using Chain of Responsibility for detection
/// and Strategy pattern for interaction.
class SelectConnectorToolHandler extends BaseToolHandler {
  const SelectConnectorToolHandler();

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

  /// Initiates the drag operation by routing through the gesture handler chain.
  ///
  /// The chain determines if we are dragging a handle (reshape) or the body (move).
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

  /// Updates the connector position or shape during the drag.
  ///
  /// Delegates to the appropriate [InteractionStrategy] based on the current state.
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

  /// Finalizes the connector interaction.
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
  /// Taps check for connector body (selection) or background (deselection).
  /// Handles are not relevant for taps.
  GestureHandler _buildTapGestureChain() {
    return GestureChainBuilder()
        .addHandler(ConnectorBodyGestureHandler()) // 1. Medium: Connector body
        .addHandler(ConnectorBackgroundGestureHandler()) // 2. Low: Background
        .build();
  }

  /// Builds the gesture chain for pan (drag) gestures.
  ///
  /// Pan checks for handles first (reshape), then body (move), then background.
  GestureHandler _buildPanGestureChain() {
    return GestureChainBuilder()
        .addHandler(
          ConnectorHandleGestureHandler(),
        ) // 1. High: Start/End handles
        .addHandler(ConnectorBodyGestureHandler()) // 2. Medium: Connector body
        .addHandler(ConnectorBackgroundGestureHandler()) // 3. Low: Background
        .build();
  }

  InteractionStrategy _getStrategyForState(ActiveLayerState state) {
    if (state.connectorHandle != null) {
      return const ReshapeConnectorStrategy();
    } else if (state.activeNodes.isNotEmpty) {
      return const MoveConnectorStrategy();
    }
    return const IdleStrategy();
  }
}
