import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/domain/failure.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/visitors/hit_test_visitor.dart';
import 'dart:ui';

part 'shape_layer_bloc.freezed.dart';
part 'shape_layer_event.dart';
part 'shape_layer_state.dart';

// A unique ID generator for our objects to simplify finding them.
class ShapeLayerBloc extends Bloc<ShapeLayerEvent, ShapeLayerState> {
  final SpaceDataService _spaceDataService;
  final String id;

  ShapeLayerBloc({required this.id, required SpaceDataService spaceDataService})
    : _spaceDataService = spaceDataService,
      super(ShapeLayerState.initialize(data: ShapeLayerData())) {
    on<_Initialized>(_onInitialize);
    on<_NodeDragged>(_onNodeDragged);
    on<_AddNode>(_onAddNode);
    on<_RemoveNode>(_onRemoveNode);
    on<_UpdateNodes>(_onUpdateNodes);
    on<_NodeSelected>(_onNodeSelected);
    on<_SelectAtPoint>(_onSelectAtPoint);
    on<_HiddenNodes>(_onHiddenNodes);
  }

  Future<void> _onInitialize(
    _Initialized event,
    Emitter<ShapeLayerState> emit,
  ) async {
    try {
      emit(ShapeLayerState.loading(data: state.data));
      final generatedNodes = _spaceDataService.generateInitialNodes();

      emit(
        ShapeLayerState.success(data: ShapeLayerData(nodes: generatedNodes)),
      );
    } on Exception catch (e) {
      emit(
        ShapeLayerStateFailure(
          data: state.data,
          failure: Failure(message: e.toString()),
        ),
      );
    }
  }

  void _onNodeDragged(_NodeDragged event, Emitter<ShapeLayerState> emit) {
    // Currently no-op
  }

  void _onAddNode(_AddNode event, Emitter<ShapeLayerState> emit) {
    final newNodes = Map<int, Node>.from(state.data.nodes);
    newNodes[event.node.id] = event.node;
    emit(state.copyWith(data: state.data.copyWith(nodes: newNodes)));
  }

  void _onRemoveNode(_RemoveNode event, Emitter<ShapeLayerState> emit) {
    final newNodes = Map<int, Node>.from(state.data.nodes);
    newNodes.remove(event.nodeId);
    emit(state.copyWith(data: state.data.copyWith(nodes: newNodes)));
  }

  void _onUpdateNodes(_UpdateNodes event, Emitter<ShapeLayerState> emit) {
    final newNodes = Map<int, Node>.from(state.data.nodes);
    for (final node in event.nodes) {
      newNodes[node.id] = node;
    }
    emit(state.copyWith(data: state.data.copyWith(nodes: newNodes)));
  }

  void _onNodeSelected(_NodeSelected event, Emitter<ShapeLayerState> emit) {
    emit(
      state.copyWith(data: state.data.copyWith(selectedNodeId: event.nodeId)),
    );
  }

  void _onSelectAtPoint(_SelectAtPoint event, Emitter<ShapeLayerState> emit) {
    final visitor = HitTestVisitor(event.point);

    // Find all nodes that contain the point
    final hitNodes =
        state.data.nodes.values.where((node) => node.accept(visitor)).toList();

    if (hitNodes.isEmpty) {
      add(const ShapeLayerEvent.nodeSelected(null));
      return;
    }

    // Select the one with highest zIndex
    hitNodes.sort((a, b) => b.zIndex.compareTo(a.zIndex));
    add(ShapeLayerEvent.nodeSelected(hitNodes.first.id));
  }

  void _onHiddenNodes(_HiddenNodes event, Emitter<ShapeLayerState> emit) {
    emit(
      state.copyWith(data: state.data.copyWith(hiddenNodeIds: event.nodeIds)),
    );
  }
}
