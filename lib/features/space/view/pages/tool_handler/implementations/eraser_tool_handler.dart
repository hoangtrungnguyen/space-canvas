import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';

class EraserToolHandler extends ToolHandler {
  const EraserToolHandler();

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

    final state = context.read<ShapeLayerBloc>().state;
    if (state is ShapeLayerStateSuccess) {
      final id = _findObjectAt(worldPoint, state.data.objects);
      if (id != null) {
        // context.read<ShapeLayerBloc>().add(ShapeLayerEvent.objectRemoved(id));
      }
    }
  }

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {}

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
