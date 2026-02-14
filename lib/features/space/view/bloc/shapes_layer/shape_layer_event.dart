part of 'shape_layer_bloc.dart';

@freezed
class ShapeLayerEvent with _$ShapeLayerEvent {
  const factory ShapeLayerEvent.initialize() = _Initialized;

  const factory ShapeLayerEvent.nodeDragged({
    required int nodeId,
    required Offset delta,
  }) = _NodeDragged;

  const factory ShapeLayerEvent.addNode(Node node) = _AddNode;

  const factory ShapeLayerEvent.removeNode(int nodeId) = _RemoveNode;

  const factory ShapeLayerEvent.shapeSelected({required int nodeId}) =
      _ShapeSelected;

  const factory ShapeLayerEvent.nodeSelected(int? nodeId) = _NodeSelected;

  const factory ShapeLayerEvent.selectAtPoint(Offset point) = _SelectAtPoint;

  const factory ShapeLayerEvent.updateNodes(List<Node> nodes) = _UpdateNodes;

  const factory ShapeLayerEvent.hiddenNodes(Set<int> nodeIds) = _HiddenNodes;
}
