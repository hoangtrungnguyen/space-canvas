import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/managers/interaction_state_manager.dart';
import 'package:ideascape/features/space/domain/managers/selection_manager.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';

abstract class CanvasInteractionMediator {
  Node? hitTest(
    Offset worldPoint, {
    SelectionFilter filter = SelectionFilter.all,
  });

  void selectAt(
    Offset worldPoint, {
    required bool isDrag,
    SelectionFilter filter = SelectionFilter.all,
  });

  void selectConnectorAt(Offset worldPoint, {required bool isDrag});
  void dragActiveNode(Offset worldPoint, Offset delta);
  void dragActiveConnector(Offset worldPoint, Offset delta);

  void finalizeInteraction();
  void finalizeConnectorInteraction();
  void commitAndDeactivate();
  void commitImmediate(Node node);
  void startNewShape(Node node, Offset worldPoint);
  void updateNewShape(Node node, Offset worldPoint);
  void startDrawing(ListOfPointNode node, Offset worldPoint);
  void updateDrawing(ListOfPointNode node, Offset worldPoint);
  void deleteNode(Node node);
  void deleteNodes(List<Node> nodes);
  void createConnector({
    required Offset startPoint,
    required Offset endPoint,
    int? startNodeId,
    int? endNodeId,
    ConnectorEdge? startLocation,
    ConnectorEdge? endLocation,
  });
}

class CanvasInteractionMediatorImpl implements CanvasInteractionMediator {
  final ShapeLayerBloc shapeBloc;
  final ActiveLayerBloc activeBloc;
  final HistoryManager history;
  final ToolbarBloc toolbarBloc;

  late final SelectionManager _selectionManager;
  late final InteractionStateManager _stateManager;

  CanvasInteractionMediatorImpl({
    required this.shapeBloc,
    required this.activeBloc,
    required this.history,
    required this.toolbarBloc,
    InteractionStateManager? stateManager,
    SelectionManager? selectionManager,
  }) {
    _stateManager =
        stateManager ??
        InteractionStateManager(
          activeBloc: activeBloc,
          shapeBloc: shapeBloc,
          history: history,
        );
    _selectionManager =
        selectionManager ??
        SelectionManager(
          activeBloc: activeBloc,
          shapeBloc: shapeBloc,
          toolbarBloc: toolbarBloc,
          interactionManager: _stateManager,
        );
  }

  @override
  Node? hitTest(
    Offset worldPoint, {
    SelectionFilter filter = SelectionFilter.all,
  }) {
    return _selectionManager.hitTest(worldPoint, filter: filter);
  }

  @override
  void selectAt(
    Offset worldPoint, {
    required bool isDrag,
    SelectionFilter filter = SelectionFilter.all,
  }) {
    _selectionManager.selectAt(worldPoint, isDrag: isDrag, filter: filter);
  }

  @override
  void selectConnectorAt(Offset worldPoint, {required bool isDrag}) {
    _selectionManager.selectConnectorAt(worldPoint, isDrag: isDrag);
  }

  // ... rest of implementation stays same
  @override
  void dragActiveNode(Offset worldPoint, Offset delta) {
    _stateManager.dragActiveNode(worldPoint, delta);
  }

  @override
  void dragActiveConnector(Offset worldPoint, Offset delta) {
    _stateManager.dragActiveConnector(worldPoint, delta);
  }

  @override
  void finalizeInteraction() {
    _stateManager.finalizeInteraction();
  }

  @override
  void finalizeConnectorInteraction() {
    _stateManager.finalizeConnectorInteraction();
  }

  @override
  void commitAndDeactivate() {
    _stateManager.commitAndDeactivate();
  }

  @override
  void commitImmediate(Node node) {
    _stateManager.commitImmediate(node);
  }

  @override
  void startNewShape(Node node, Offset worldPoint) {
    activeBloc.add(
      ActiveLayerEvent.interactionStarted(node: node, point: worldPoint),
    );
  }

  @override
  void updateNewShape(Node node, Offset worldPoint) {
    activeBloc.add(ActiveLayerEvent.shapeUpdated(node));
  }

  @override
  void startDrawing(ListOfPointNode node, Offset worldPoint) {
    activeBloc.add(
      ActiveLayerEvent.interactionStarted(node: node, point: worldPoint),
    );
  }

  @override
  void updateDrawing(ListOfPointNode node, Offset worldPoint) {
    activeBloc.add(
      ActiveLayerEvent.interactionStarted(node: node, point: worldPoint),
    );
  }

  @override
  void deleteNode(Node node) {
    _stateManager.deleteNode(node);
  }

  @override
  void deleteNodes(List<Node> nodes) {
    _stateManager.deleteNodes(nodes);
  }

  @override
  void createConnector({
    required Offset startPoint,
    required Offset endPoint,
    int? startNodeId,
    int? endNodeId,
    ConnectorEdge? startLocation,
    ConnectorEdge? endLocation,
  }) {
    _stateManager.createConnector(
      startPoint: startPoint,
      endPoint: endPoint,
      startNodeId: startNodeId,
      endNodeId: endNodeId,
      startLocation: startLocation,
      endLocation: endLocation,
    );
  }
}
