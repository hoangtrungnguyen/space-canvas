import 'package:ideascape/features/space/domain/interfaces/space_editor.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

class ShapeLayerEditor implements SpaceEditor {
  final ShapeLayerBloc bloc;

  ShapeLayerEditor(this.bloc);

  @override
  Future<void> addNode(Node node) async {
    bloc.add(ShapeLayerEvent.addNode(node));
  }

  @override
  Future<void> removeNode(int id) async {
    bloc.add(ShapeLayerEvent.removeNode(id));
  }

  @override
  Future<void> updateNode(Node node) async {
    // ShapeLayerEvent handles single updates efficiently via updateNodes or overwrite logic
    // We can use updateNodes with a single element list for consistency
    bloc.add(ShapeLayerEvent.updateNodes([node]));
  }

  @override
  Future<void> updateNodes(List<Node> nodes) async {
    bloc.add(ShapeLayerEvent.updateNodes(nodes));
  }
}
