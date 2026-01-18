import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ideascape/features/space/view/pages/quad_tree_page/rect_extension.dart';
import 'package:quadtree_dart/quadtree_dart.dart';

import 'space_object.dart';

class WhiteboardState extends ChangeNotifier {
  // The core data structures
  late Quadtree<SpaceObject> _quadtree;
  final List<SpaceObject> _allObjects = [];
  Rect _currentBounds;

  // State properties
  bool isDebugMode = false;
  int visibleObjectCount = 0;

  // Getter for all objects
  List<SpaceObject> get allObjects => _allObjects;
  Quadtree<SpaceObject> get quadtree => _quadtree;

  WhiteboardState()
    : _currentBounds = Rect(x: -500, y: -500, width: 1000, height: 1000) {
    _initializeQuadtree();
  }

  /// Initializes the quadtree with the current bounds.
  void _initializeQuadtree() {
    _quadtree = Quadtree<SpaceObject>(
      _currentBounds,
      maxObjects: 4, // Node capacity before splitting
      maxDepth: 8, // Max recursion depth
    );
  }

  /// Toggles the debug visualization mode.
  void toggleDebugMode() {
    isDebugMode = !isDebugMode;
    notifyListeners();
  }

  /// Adds a new object to the whiteboard.
  void addObject(SpaceObject object) {
    // --- Infinite Canvas Logic ---
    // Check if the new object is outside the current quadtree bounds.
    if (!_currentBounds.contains(Offset(object.x, object.y))) {
      _expandAndRebuildQuadtree(object);
    }

    _allObjects.add(object);
    _quadtree.insert(object); // Add to the (potentially new) quadtree
    notifyListeners();
  }

  /// Adds a randomly positioned and colored object.
  void addRandomObject() {
    final random = Random();
    // Generate within a larger area to test expansion
    final x = (random.nextDouble() * 4000) - 2000;
    final y = (random.nextDouble() * 4000) - 2000;
    final size = random.nextDouble() * 40 + 10;
    final color = Colors.primaries[random.nextInt(Colors.primaries.length)];

    final newObject = SpaceObject(
      x: x,
      y: y,
      width: size,
      height: size,
      color: color,
    );
    addObject(newObject);
  }

  /// Expands the quadtree bounds to encompass a new object and rebuilds the tree.
  void _expandAndRebuildQuadtree(SpaceObject newObject) {
    // Determine the new required bounds.
    final double minX = min(_currentBounds.x, newObject.x);
    final double minY = min(_currentBounds.y, newObject.y);
    final double maxX = max(
      _currentBounds.x + _currentBounds.width,
      newObject.x + newObject.width,
    );
    final double maxY = max(
      _currentBounds.y + _currentBounds.height,
      newObject.y + newObject.height,
    );

    // Update the current bounds, adding some padding.
    _currentBounds = Rect(
      x: minX - 100,
      y: minY - 100,
      width: (maxX - minX) + 200,
      height: (maxY - minY) + 200,
    );

    // Re-initialize the quadtree with the new, larger bounds.
    _initializeQuadtree();

    // Re-insert all existing objects into the new tree.
    for (final obj in _allObjects) {
      _quadtree.insert(obj);
    }

    // print("Quadtree expanded. New bounds: $_currentBounds");
  }

  /// Queries the quadtree to get only the objects visible within a given rectangle.
  List<SpaceObject> getVisibleObjects(Rect visibleRect) {
    final visible = _quadtree.retrieve(visibleRect);
    // Update count for debug purposes
    visibleObjectCount = visible.length;
    return visible;
  }
}
