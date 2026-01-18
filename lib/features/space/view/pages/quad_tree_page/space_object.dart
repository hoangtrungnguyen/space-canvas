import 'package:flutter/material.dart';
import 'package:quadtree_dart/quadtree_dart.dart';
import 'package:uuid/uuid.dart';

// A unique ID generator
const uuid = Uuid();

class SpaceObject extends Rect {
  final String id;
  final Paint paint;

  SpaceObject({
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required Color color,
  }) : id = uuid.v4(),
       paint = Paint()..color = color;

  // Override equality and hashCode to ensure objects are uniquely identified by their ID.
  // This is crucial for collections like Set or for removing objects from a list.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpaceObject &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
