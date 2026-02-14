import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/factories/node_factory.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:provider/provider.dart';

class PenToolHandler extends ToolHandler {
  const PenToolHandler();

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
    final mediator = context.read<CanvasInteractionMediator>();

    final id = getIt<SpaceDataService>().nextUniqueId;
    final newListObject = NodeFactory.createListOfPoint(
      id: id,
      points: [worldPoint],
    );

    mediator.startDrawing(newListObject, worldPoint);

    context.read<ToolbarBloc>().add(
      ToolbarEvent.updateDrawingObject(newListObject),
    );
  }

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeState = context.read<ActiveLayerBloc>().state;
    final mediator = context.read<CanvasInteractionMediator>();

    if (activeState.activeNodes.isNotEmpty) {
      final currentObject = activeState.activeNodes.values.first;

      if (currentObject is ListOfPointNode) {
        final worldPoint = _toWorldPoint(details.localPosition, controller);

        // Optimization: Only add point if it's far enough from the last point
        const distanceThreshold = 0.5;
        final lastPoint = currentObject.points.last;
        final distance = (worldPoint - lastPoint).distance;

        if (distance > distanceThreshold) {
          final updatedObject = currentObject.copyWith(
            points: [...currentObject.points, worldPoint],
          );

          mediator.updateDrawing(updatedObject, worldPoint);

          context.read<ToolbarBloc>().add(
            ToolbarEvent.updateDrawingObject(updatedObject),
          );
        }
      }
    }
  }

  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final mediator = context.read<CanvasInteractionMediator>();
    mediator.commitAndDeactivate();

    context.read<ToolbarBloc>().add(
      const ToolbarEvent.updateDrawingObject(null),
    );
  }

  Offset _toWorldPoint(Offset local, TransformationController controller) {
    return MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      local,
    );
  }
}
