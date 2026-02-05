import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';

/// Handles connector tool interactions using the Mediator and State patterns.
///
/// Connectors can be drawn from any point to any point. If the start or end
/// point is on an object, it will be linked to that object.
class ConnectorToolHandler extends ToolHandler {
  const ConnectorToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {}

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = _toWorldPoint(details.localPosition, controller);

    // Find if we're starting on an object (optional)
    int? startObjectId;
    final state = context.read<ShapeLayerBloc>().state;
    if (state is ShapeLayerStateSuccess) {
      startObjectId = _findObjectAt(worldPoint, state.data.objects);
    }

    // Always start the drag, even without an object
    context.read<ActiveLayerBloc>().add(
      ActiveLayerEvent.connectorDragStarted(
        startObjectId: startObjectId,
        startPoint: worldPoint,
      ),
    );
  }

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeState = context.read<ActiveLayerBloc>().state;
    if (activeState.connectorStartPoint != null) {
      final worldPoint = _toWorldPoint(details.localPosition, controller);
      context.read<ActiveLayerBloc>().add(
        ActiveLayerEvent.connectorDragUpdated(worldPoint),
      );
    }
  }

  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeState = context.read<ActiveLayerBloc>().state;
    final startPoint = activeState.connectorStartPoint;
    final startObjectId = activeState.connectorStartObjectId;
    final endPoint = activeState.connectorDragPosition;

    if (startPoint != null && endPoint != null) {
      final shapeState = context.read<ShapeLayerBloc>().state;
      final mediator = context.read<CanvasInteractionMediator>();

      int? endObjectId;
      if (shapeState is ShapeLayerStateSuccess) {
        endObjectId = _findObjectAt(endPoint, shapeState.data.objects);
      }

      // Create connector with optional object IDs
      mediator.createConnector(
        startPoint: startPoint,
        endPoint: endPoint,
        startObjectId: startObjectId,
        endObjectId: endObjectId,
      );
    }

    // Always clear the drag state
    context.read<ActiveLayerBloc>().add(
      const ActiveLayerEvent.connectorDragEnded(),
    );
  }

  int? _findObjectAt(Offset position, Map<int, SpaceObject> objects) {
    final sorted =
        objects.values.toList()..sort((a, b) => b.zIndex.compareTo(a.zIndex));
    for (final obj in sorted) {
      if (obj.rect.contains(position)) {
        return obj.id;
      }
    }
    return null;
  }

  Offset _toWorldPoint(Offset local, TransformationController controller) {
    return MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      local,
    );
  }
}
