import 'package:ideascape/features/space/domain/models/objects/node.dart';

class SpaceDataService {
  // A unique ID generator for our nodes to simplify finding them.
  int _uniqueIdCounter = 0;

  int get nextUniqueId => _uniqueIdCounter++;

  Map<int, Node> generateInitialNodes() {
    final Map<int, Node> generatedNodes = {};
    return generatedNodes;
  }
}
