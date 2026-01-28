import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/commands/add_shape_command.dart';
import 'package:ideascape/features/space/domain/factories/space_object_factory.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';

class ConnectorToolHandler extends ToolHandler {
  // Maintaining state for dragging; in a real app this might be in BLoC or ephemeral state
  static int? _startObjectId;
  static Offset? _currentDragPosition;

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
    final worldPoint = MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      details.localPosition,
    );

    final state = context.read<ShapeLayerBloc>().state;
    if (state is ShapeLayerStateSuccess) {
      final id = _findObjectAt(worldPoint, state.data.objects);
      if (id != null) {
        _startObjectId = id;
      }
    }
  }

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    if (_startObjectId != null) {
      final worldPoint = MatrixUtils.transformPoint(
        Matrix4.inverted(controller.value),
        details.localPosition,
      );
      _currentDragPosition = worldPoint;
      // Ideally trigger UI update here
    }
  }

  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    if (_startObjectId != null && _currentDragPosition != null) {
      final state = context.read<ShapeLayerBloc>().state;
      if (state is ShapeLayerStateSuccess) {
        final endId = _findObjectAt(_currentDragPosition!, state.data.objects);
        if (endId != null && endId != _startObjectId) {
          final startObj = state.data.objects[_startObjectId];
          final endObj = state.data.objects[endId];

          if (startObj != null && endObj != null) {
            final id = getIt<SpaceDataService>().nextUniqueId;
            final connector = SpaceObjectFactory.createConnector(
              id: id,
              startId: _startObjectId!,
              endId: endId,
              startPoint: startObj.rect.center,
              endPoint: endObj.rect.center,
            );

            context.read<HistoryManager>().execute(AddShapeCommand(connector));
          }
        }
      }
    }
    _startObjectId = null;
    _currentDragPosition = null;
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
}
