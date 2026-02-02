import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/hit_test_visitor.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:ideascape/features/space/view/utils/canvas_utils.dart';

/// Eraser tool handler supporting tap-to-delete and drag-to-erase.
class EraserToolHandler extends ToolHandler {
  /// Track objects erased during drag for batch undo.
  final Set<SpaceObject> _erasedObjects = {};

  EraserToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = CanvasUtils.toWorldPoint(
      details.localPosition,
      controller,
    );
    final hitObject = _hitTest(worldPoint, context);

    if (hitObject != null) {
      final mediator = context.read<CanvasInteractionMediator>();
      mediator.deleteObject(hitObject);
    }
  }

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    _erasedObjects.clear();
  }

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = CanvasUtils.toWorldPoint(
      details.localPosition,
      controller,
    );
    final hitObject = _hitTest(worldPoint, context);

    if (hitObject != null && !_erasedObjects.any((o) => o.id == hitObject.id)) {
      _erasedObjects.add(hitObject);
      // Delete object through mediator which records to history
      final mediator = context.read<CanvasInteractionMediator>();
      mediator.deleteObject(hitObject);
    }
  }

  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    // Just clear the tracking set - deletions were already recorded to history
    _erasedObjects.clear();
  }

  /// Hit-test using the Visitor pattern for accurate shape detection.
  SpaceObject? _hitTest(Offset worldPoint, BuildContext context) {
    final state = context.read<ShapeLayerBloc>().state;
    final visitor = HitTestVisitor(worldPoint);
    final objects =
        state.data.objects.values.toList()
          ..sort((a, b) => b.zIndex.compareTo(a.zIndex));

    for (final obj in objects) {
      if (obj.accept(visitor)) return obj;
    }
    return null;
  }
}
