import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/managers/interaction_state_manager.dart';
import 'package:ideascape/features/space/domain/managers/selection_manager.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';

abstract class CanvasInteractionMediator {
  SpaceObject? hitTest(
    Offset worldPoint, {
    SelectionFilter filter = SelectionFilter.all,
  });

  void selectAt(
    Offset worldPoint, {
    required bool isDrag,
    SelectionFilter filter = SelectionFilter.all,
  });

  void selectConnectorAt(Offset worldPoint, {required bool isDrag});
  void dragActiveObject(Offset worldPoint, Offset delta);
  void dragActiveConnector(Offset worldPoint, Offset delta);

  void finalizeInteraction();
  void finalizeConnectorInteraction();
  void commitAndDeactivate();
  void commitImmediate(SpaceObject object);
  void startNewShape(SpaceObject object, Offset worldPoint);
  void updateNewShape(SpaceObject object, Offset worldPoint);
  void startDrawing(ListOfPointObject object, Offset worldPoint);
  void updateDrawing(ListOfPointObject object, Offset worldPoint);
  void deleteObject(SpaceObject object);
  void deleteObjects(List<SpaceObject> objects);
  void createConnector({
    required Offset startPoint,
    required Offset endPoint,
    int? startObjectId,
    int? endObjectId,
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
  SpaceObject? hitTest(
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
  void dragActiveObject(Offset worldPoint, Offset delta) {
    _stateManager.dragActiveObject(worldPoint, delta);
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
  void commitImmediate(SpaceObject object) {
    _stateManager.commitImmediate(object);
  }

  @override
  void startNewShape(SpaceObject object, Offset worldPoint) {
    activeBloc.add(
      ActiveLayerEvent.interactionStarted(object: object, point: worldPoint),
    );
  }

  @override
  void updateNewShape(SpaceObject object, Offset worldPoint) {
    activeBloc.add(ActiveLayerEvent.shapeUpdated(object));
  }

  @override
  void startDrawing(ListOfPointObject object, Offset worldPoint) {
    activeBloc.add(
      ActiveLayerEvent.interactionStarted(object: object, point: worldPoint),
    );
  }

  @override
  void updateDrawing(ListOfPointObject object, Offset worldPoint) {
    activeBloc.add(
      ActiveLayerEvent.interactionStarted(object: object, point: worldPoint),
    );
  }

  @override
  void deleteObject(SpaceObject object) {
    _stateManager.deleteObject(object);
  }

  @override
  void deleteObjects(List<SpaceObject> objects) {
    _stateManager.deleteObjects(objects);
  }

  @override
  void createConnector({
    required Offset startPoint,
    required Offset endPoint,
    int? startObjectId,
    int? endObjectId,
    ConnectorEdge? startLocation,
    ConnectorEdge? endLocation,
  }) {
    _stateManager.createConnector(
      startPoint: startPoint,
      endPoint: endPoint,
      startObjectId: startObjectId,
      endObjectId: endObjectId,
      startLocation: startLocation,
      endLocation: endLocation,
    );
  }
}
