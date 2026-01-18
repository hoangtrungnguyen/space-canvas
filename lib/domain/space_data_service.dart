import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

class SpaceDataService {
  // A unique ID generator for our objects to simplify finding them.
  int _uniqueIdCounter = 0;

  int get nextUniqueId => _uniqueIdCounter++;

  Map<int, ShapeObject> generateInitialObjects() {
    final Map<int, ShapeObject> generatedObjects = {};
    return generatedObjects;
  }
}
