import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/commands/add_shape_command.dart';
import 'package:ideascape/features/space/domain/factories/space_object_factory.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';

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
    final worldPoint = MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      details.localPosition,
    );

    final id = getIt<SpaceDataService>().nextUniqueId;
    final path = Path()..moveTo(worldPoint.dx, worldPoint.dy);
    final newPathObject = SpaceObjectFactory.createPath(id: id, path: path);

    context.read<ActiveLayerBloc>().add(
      ActiveLayerEvent.interactionStarted(
        object: newPathObject,
        point: worldPoint,
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

    if (activeState.activeObjects.isNotEmpty) {
      final currentObject = activeState.activeObjects.values.first;

      if (currentObject is PathObject) {
        final worldPoint = MatrixUtils.transformPoint(
          Matrix4.inverted(controller.value),
          details.localPosition,
        );

        // Create new path by adding line to current point
        // We need to copy the path primarily because Path is mutable but we want immutable state updates if possible,
        // or just append to it. However, since we are replacing the object in bloc, let's append.
        // Actually, Path in Flutter is a native object. Modifying it in place might not trigger Bloc equality check if reference is same.
        // Better to effectively "evolve" it.
        // For performance in high frequency pan updates, modifying the path object itself and emitting a new state with SAME path object
        // might be tricky for Bloc's check.
        // But let's assume standard flow: modify the path, emit new state.

        currentObject.path.lineTo(worldPoint.dx, worldPoint.dy);

        context.read<ActiveLayerBloc>().add(
          ActiveLayerEvent.objectChanged(currentObject),
        );
      }
    }
  }

  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final activeState = context.read<ActiveLayerBloc>().state;

    if (activeState.activeObjects.isNotEmpty) {
      final finalObject = activeState.activeObjects.values.first;

      // Commit to history/main layer
      context.read<HistoryManager>().execute(AddShapeCommand(finalObject));

      // Clear active layer
      context.read<ActiveLayerBloc>().add(
        ActiveLayerEvent.objectDeactivated(finalObject.id),
      );
    }
  }
}
