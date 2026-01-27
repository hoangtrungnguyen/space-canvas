import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

/// Factory for creating [SpaceObject] instances with consistent defaults.
class SpaceObjectFactory {
  /// Creates a standard [ShapeObject].
  static ShapeObject createShape({
    required int id,
    required ShapeType type,
    required Offset center,
    Size size = const Size(100, 100),
    Color color = Colors.blue,
  }) {
    return ShapeObject(
      id: id,
      type: type,
      rect: Rect.fromCenter(
        center: center,
        width: size.width,
        height: size.height,
      ),
      paint:
          Paint()
            ..color = color
            ..style = PaintingStyle.fill,
    );
  }

  /// Creates a standard [TextObject].
  static TextObject createText({
    required int id,
    required String text,
    required Offset position,
    double fontSize = 20,
    Color color = Colors.black,
  }) {
    return TextObject(
      id: id,
      text: text,
      position: position,
      fontSize: fontSize,
      color: color.toARGB32(),
    );
  }

  /// Creates a standard [PathObject].
  static PathObject createPath({
    required int id,
    required Path path,
    Color color = Colors.black,
    double strokeWidth = 2.0,
  }) {
    return PathObject(
      id: id,
      path: path,
      paint:
          Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..strokeCap = StrokeCap.round,
    );
  }
}
