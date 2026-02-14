import 'package:bloc/bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';

import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';

class ActiveLayerBloc extends Bloc<ActiveLayerEvent, ActiveLayerState> {
  ActiveLayerBloc() : super(const ActiveLayerState()) {
    on<ActiveLayerEvent>((event, emit) {
      event.map(
        started: (_) {},
        nodeActivated: (e) {
          final newNodes = Map<int, Node>.from(state.activeNodes);
          newNodes[e.node.id] = e.node;
          emit(state.copyWith(activeNodes: newNodes));
        },
        nodeChanged: (e) {
          if (state.activeNodes.containsKey(e.node.id)) {
            final newNodes = Map<int, Node>.from(state.activeNodes);
            newNodes[e.node.id] = e.node;
            emit(state.copyWith(activeNodes: newNodes));
          }
        },
        interactionStarted: (e) {
          final newNodes = Map<int, Node>.from(state.activeNodes);
          newNodes[e.node.id] = e.node;
          emit(state.copyWith(activeNodes: newNodes, dragStartPoint: e.point));
        },
        shapeUpdated: (e) {
          final newNodes = Map<int, Node>.from(state.activeNodes);
          newNodes[e.node.id] = e.node;
          emit(state.copyWith(activeNodes: newNodes));
        },
        nodeDeactivated: (e) {
          final newNodes = Map<int, Node>.from(state.activeNodes);
          newNodes.remove(e.nodeId);
          emit(
            state.copyWith(
              activeNodes: newNodes,
              dragStartPoint: null,
              originalNode: null,
            ),
          );
        },
        originalNodeSet: (e) {
          emit(state.copyWith(originalNode: e.node));
        },
        clear: (_) {
          emit(
            state.copyWith(
              activeNodes: {},
              dragStartPoint: null,
              originalNode: null,
            ),
          );
        },
        handleChanged: (e) {
          emit(state.copyWith(resizeHandle: e.handle));
        },
        connectorHandleSelected: (e) {
          emit(state.copyWith(connectorHandle: e.handle));
        },
        connectorDragStarted: (e) {
          emit(
            state.copyWith(
              connectorStartNodeId: e.startNodeId,
              connectorStartPoint: e.startPoint,
              connectorDragPosition: null,
            ),
          );
        },
        connectorDragUpdated: (e) {
          emit(state.copyWith(connectorDragPosition: e.position));
        },
        connectorDragEnded: (_) {
          emit(
            state.copyWith(
              connectorStartNodeId: null,
              connectorStartPoint: null,
              connectorDragPosition: null,
            ),
          );
        },
        connectorHoverChanged: (e) {
          emit(state.copyWith(connectorHoverNodeId: e.nodeId));
        },
      );
    });
  }
}
