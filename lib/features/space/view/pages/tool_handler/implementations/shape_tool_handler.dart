import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/commands/add_shape_command.dart';
import 'package:ideascape/features/space/domain/factories/space_object_factory.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';

class ShapeToolHandler extends ToolHandler {
  const ShapeToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      details.localPosition,
    );
    final shapeType = context.read<ToolbarBloc>().state.activeShapeType;

    // Create object using Factory
    final id = getIt<SpaceDataService>().nextUniqueId;
    final newShape = SpaceObjectFactory.createShape(
      id: id,
      type: shapeType,
      center: worldPoint,
    );

    // Execute via HistoryManager (Command Pattern)
    context.read<HistoryManager>().execute(AddShapeCommand(newShape));
  }

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    // Intentionally empty for now
  }

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {}

  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {}
}
