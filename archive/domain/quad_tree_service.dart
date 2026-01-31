import 'dart:math';
import 'package:quadtree_dart/quadtree_dart.dart';

/// A generic service for managing spatial data using a Quadtree.
///
/// This service allows for efficient storage and retrieval of objects based on their
/// 2D spatial coordinates, which is particularly useful for optimizing rendering
/// in large or infinite canvas applications.
///
/// [T] must extend [Rect] from the `quadtree_dart` package.
class QuadTreeService<T extends Rect> {
  late Quadtree<T> _quadtree;
  Rect _currentBounds;
  final List<T> _allItems = [];

  // Configuration
  final int maxObjects;
  final int maxDepth;
  final double expansionPadding;

  /// Creates a [QuadTreeService].
  ///
  /// [initialBounds] defines the starting area of the quadtree.
  /// [maxObjects] is the capacity of a node before it splits.
  /// [maxDepth] is the maximum depth of the tree.
  QuadTreeService({
    Rect? initialBounds,
    this.maxObjects = 10,
    this.maxDepth = 10,
    this.expansionPadding = 1000.0,
  }) : _currentBounds =
           initialBounds ??
           Rect(x: -2000, y: -2000, width: 4000, height: 4000) {
    _initializeQuadtree();
  }

  /// Initializes (or resets) the quadtree with the current bounds.
  void _initializeQuadtree() {
    _quadtree = Quadtree<T>(
      _currentBounds,
      maxObjects: maxObjects,
      maxDepth: maxDepth,
    );
  }

  /// Adds an item to the quadtree.
  ///
  /// If the item is outside the current bounds of the quadtree, the bounds
  /// are automatically expanded and the tree is rebuilt to accommodate the new item.
  void insert(T item) {
    // Check if the new object is valid within current bounds.
    // We check if the item's top-left is strictly within, but ideally we want to ensure
    // the tree covers the item. The simple check from reference is used here basics,
    // but the expand logic calculates full coverage.
    if (!_contains(item)) {
      _expandAndRebuild(item);
    }

    _allItems.add(item);
    _quadtree.insert(item);
  }

  /// Bulk inserts items.
  void insertAll(List<T> items) {
    for (var item in items) {
      insert(item);
    }
  }

  /// Retrieves all objects that intersect with the given [visibleRect].
  List<T> getVisibleObjects(Rect visibleRect) {
    return _quadtree.retrieve(visibleRect);
  }

  /// Returns a read-only list of all objects in the service.
  List<T> getAllObjects() => List.unmodifiable(_allItems);

  /// Clears all objects and resets the quadtree.
  void clear() {
    _allItems.clear();
    _initializeQuadtree();
  }

  /// Checks if the item is substantially within the current bounds.
  /// Using a simple point check for efficiency as per reference implementation logic,
  /// but can be enhanced.
  bool _contains(T item) {
    // Check if the items origin is within the bounds.
    // Note: Rect.x/y/width/height are available.
    return item.x >= _currentBounds.x &&
        item.y >= _currentBounds.y &&
        item.x < _currentBounds.x + _currentBounds.width &&
        item.y < _currentBounds.y + _currentBounds.height;
  }

  /// Expands the quadtree bounds to encompass the new item and rebuilds the tree.
  void _expandAndRebuild(T newItem) {
    final double minX = min(_currentBounds.x, newItem.x);
    final double minY = min(_currentBounds.y, newItem.y);
    final double maxX = max(
      _currentBounds.x + _currentBounds.width,
      newItem.x + newItem.width,
    );
    final double maxY = max(
      _currentBounds.y + _currentBounds.height,
      newItem.y + newItem.height,
    );

    // Update the current bounds with padding
    _currentBounds = Rect(
      x: minX - expansionPadding,
      y: minY - expansionPadding,
      width: (maxX - minX) + (expansionPadding * 2),
      height: (maxY - minY) + (expansionPadding * 2),
    );

    // Re-initialize and re-insert all items
    _initializeQuadtree();
    for (final item in _allItems) {
      _quadtree.insert(item);
    }
  }
}
