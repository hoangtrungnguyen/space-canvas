import 'dart:ui';

import '../objects/space_object.dart';

class QuadTree {
  static const int defaultCapacity = 4;

  final Rect boundary;
  final int capacity; // How many objects a node can hold before it splits

  List<SpaceObject> objects = [];
  bool isDivided = false;

  List<QuadTree> children = [];

  QuadTree(this.boundary, [this.capacity = defaultCapacity]);
}
