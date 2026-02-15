import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/visitors/hit_test_visitor.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/base_tool_handler.dart';

/// Eraser tool handler supporting tap-to-delete and drag-to-erase.
class EraserToolHandler extends BaseToolHandler {
  /// Track objects erased during drag for batch undo.
  final Set<Node> _erasedNodes = {};

  EraserToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = toWorldPoint(details.localPosition, controller);
    final hitNode = _hitTest(worldPoint, context);

    if (hitNode != null) {
      final mediator = getMediator(context);
      mediator.deleteNode(hitNode);
    }
  }

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    _erasedNodes.clear();
  }

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = toWorldPoint(details.localPosition, controller);
    final hitNode = _hitTest(worldPoint, context);

    if (hitNode != null && !_erasedNodes.any((o) => o.id == hitNode.id)) {
      _erasedNodes.add(hitNode);
      // Delete object through mediator which records to history
      final mediator = getMediator(context);
      mediator.deleteNode(hitNode);
    }
  }

  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    // Just clear the tracking set - deletions were already recorded to history
    _erasedNodes.clear();
  }

  /// Hit-test using the Visitor pattern for accurate shape detection.
  Node? _hitTest(Offset worldPoint, BuildContext context) {
    final state = getShapeLayerBloc(context).state;
    final visitor = HitTestVisitor(worldPoint);
    final nodes =
        state.data.nodes.values.toList()
          ..sort((a, b) => b.zIndex.compareTo(a.zIndex));

    for (final node in nodes) {
      if (node.accept(visitor)) return node;
    }
    return null;
  }
}
