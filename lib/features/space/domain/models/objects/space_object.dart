import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_object.freezed.dart';

enum ShapeType {
  rectangle,
  oval,
  triangle,
  diamond,
  parallelogram,
  database,
  server,
  cloud
}

abstract class SpaceObject {
  int get id;

  int get zIndex => 0;

  Rect get rect;

  bool intersects(SpaceObject other) {
    return rect.overlaps(other.rect);
  }
}

// Represents a freehand drawing.
@freezed
abstract class PathObject extends SpaceObject with _$PathObject {
  factory PathObject({
    required Path path,
    required Paint paint,
    required int id,
    @Default(0) int zIndex,
  }) = _PathObject;

  PathObject._() : super();

  @override
  Rect get rect => path.getBounds();
}

@freezed
abstract class ShapeObject extends SpaceObject with _$ShapeObject {
  factory ShapeObject({
    required ShapeType type,
    required Rect rect,
    required Paint paint,
    required int id,
    @Default('') String text,
    @Default(0) int zIndex,
  }) = _ShapeObject;

  ShapeObject._();
}

@freezed
abstract class TextObject extends SpaceObject with _$TextObject {
  factory TextObject({
    required String text,
    required Offset position,
    required double fontSize,
    required int color, // ARGB
    required int id,
    @Default(0) int zIndex,
    String? fontFamily,
  }) = _TextObject;

  TextObject._();

  @override
  Rect get rect {
    // simplified rect calculation, ideally requires TextPainter layout
    // Assuming strict estimation for now
    return Rect.fromLTWH(position.dx, position.dy, text.length * fontSize * 0.6, fontSize);
  }
}

@freezed
abstract class ImageObject extends SpaceObject with _$ImageObject {
  factory ImageObject({
    required String imageUrl, // or local path / bytes identifier
    required Rect rect,
    required int id,
    @Default(0) int zIndex,
  }) = _ImageObject;

  ImageObject._();
}

@freezed
abstract class ConnectorObject extends SpaceObject with _$ConnectorObject {
  factory ConnectorObject({
    required int startObjectId,
    required int endObjectId,
    required Offset startPoint,
    required Offset endPoint,
    required double strokeWidth,
    required int color,
    required int id,
    @Default(0) int zIndex,
  }) = _ConnectorObject;

  ConnectorObject._();

  @override
  Rect get rect => Rect.fromPoints(startPoint, endPoint).inflate(strokeWidth);
}

@freezed
abstract class GroupObject extends SpaceObject with _$GroupObject {
  factory GroupObject({
    required List<int> childrenIds,
    required Rect rect,
    required int id,
    @Default(0) int zIndex,
  }) = _GroupObject;

  GroupObject._();
}
