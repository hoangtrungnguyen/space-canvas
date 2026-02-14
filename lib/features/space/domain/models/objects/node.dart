import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';

export 'package:ideascape/features/space/domain/models/objects/connector_node.dart';

part 'node.freezed.dart';

enum ShapeType {
  rectangle,
  oval,
  triangle,
  diamond,
  parallelogram,
  database,
  server,
  cloud,
}

abstract class Node {
  int get id;
  int get zIndex;
  Rect get rect;
  T accept<T>(NodeVisitor<T> visitor);

  bool intersects(Node other) {
    return rect.overlaps(other.rect);
  }
}

abstract class NodeVisitor<T> {
  T visitPath(PathNode node);
  T visitShape(ShapeNode node);
  T visitText(TextNode node);
  T visitImage(ImageNode node);
  T visitConnector(ConnectorNode node);
  T visitGroup(GroupNode node);
  T visitListOfPoint(ListOfPointNode node);
}

// Represents a freehand drawing.
@freezed
abstract class PathNode extends Node with _$PathNode {
  factory PathNode({
    required Path path,
    required Paint paint,
    required int id,
    @Default(0) int zIndex,
  }) = _PathNode;

  PathNode._() : super();

  @override
  Rect get rect => path.getBounds();

  @override
  T accept<T>(NodeVisitor<T> visitor) => visitor.visitPath(this);
}

@freezed
abstract class ShapeNode extends Node with _$ShapeNode {
  factory ShapeNode({
    required ShapeType type,
    required Rect rect,
    required Paint paint,
    required int id,
    @Default('') String text,
    @Default(0) int zIndex,
  }) = _ShapeNode;

  ShapeNode._();

  @override
  T accept<T>(NodeVisitor<T> visitor) => visitor.visitShape(this);
}

@freezed
abstract class TextNode extends Node with _$TextNode {
  factory TextNode({
    required String text,
    required Offset position,
    required double fontSize,
    required int color, // ARGB
    required int id,
    @Default(0) int zIndex,
    String? fontFamily,
  }) = _TextNode;

  TextNode._();

  @override
  T accept<T>(NodeVisitor<T> visitor) => visitor.visitText(this);

  @override
  Rect get rect {
    // simplified rect calculation, ideally requires TextPainter layout
    // Assuming strict estimation for now
    return Rect.fromLTWH(
      position.dx,
      position.dy,
      text.length * fontSize * 0.6,
      fontSize,
    );
  }
}

@freezed
abstract class ImageNode extends Node with _$ImageNode {
  factory ImageNode({
    required String imageUrl, // or local path / bytes identifier
    required Rect rect,
    required int id,
    @Default(0) int zIndex,
  }) = _ImageNode;

  ImageNode._();

  @override
  T accept<T>(NodeVisitor<T> visitor) => visitor.visitImage(this);
}

@freezed
abstract class GroupNode extends Node with _$GroupNode {
  factory GroupNode({
    required List<int> childrenIds,
    required Rect rect,
    required int id,
    @Default(0) int zIndex,
  }) = _GroupNode;

  GroupNode._();

  @override
  T accept<T>(NodeVisitor<T> visitor) => visitor.visitGroup(this);
}

@freezed
abstract class ListOfPointNode extends Node with _$ListOfPointNode {
  factory ListOfPointNode({
    required List<Offset> points,
    required double strokeWidth,
    required int color,
    required int id,
    @Default(0) int zIndex,
  }) = _ListOfPointNode;

  ListOfPointNode._() : super();

  @override
  T accept<T>(NodeVisitor<T> visitor) => visitor.visitListOfPoint(this);

  @override
  Rect get rect {
    if (points.isEmpty) return Rect.zero;
    double minX = points.first.dx;
    double minY = points.first.dy;
    double maxX = points.first.dx;
    double maxY = points.first.dy;

    for (final p in points) {
      if (p.dx < minX) minX = p.dx;
      if (p.dx > maxX) maxX = p.dx;
      if (p.dy < minY) minY = p.dy;
      if (p.dy > maxY) maxY = p.dy;
    }

    return Rect.fromLTRB(minX, minY, maxX, maxY).inflate(strokeWidth / 2);
  }
}
