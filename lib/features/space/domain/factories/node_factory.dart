import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

/// Factory for creating [Node] instances with consistent defaults.
class NodeFactory {
  /// Creates a standard [ShapeNode].
  static ShapeNode createShape({
    required int id,
    required ShapeType type,
    required Offset center,
    Size size = const Size(100, 100),
    Color color = Colors.blue,
  }) {
    return ShapeNode(
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

  /// Creates a standard [TextNode].
  static TextNode createText({
    required int id,
    required String text,
    required Offset position,
    double fontSize = 20,
    Color color = Colors.black,
  }) {
    return TextNode(
      id: id,
      text: text,
      position: position,
      fontSize: fontSize,
      color: color.toARGB32(),
    );
  }

  /// Creates a standard [PathNode].
  static PathNode createPath({
    required int id,
    required Path path,
    Color color = Colors.black,
    double strokeWidth = 2.0,
  }) {
    return PathNode(
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

  /// Creates a standard [ConnectorNode].
  static ConnectorNode createConnector({
    required int id,
    required int startId,
    required int endId,
    required Offset startPoint,
    required Offset endPoint,
    double strokeWidth = 2.0,
    Color color = Colors.black,
  }) {
    return ConnectorNode(
      id: id,
      startNodeId: startId,
      endNodeId: endId,
      startPoint: startPoint,
      endPoint: endPoint,
      strokeWidth: strokeWidth,
      color: color.toARGB32(),
    );
  }

  /// Creates a standard [ListOfPointNode].
  static ListOfPointNode createListOfPoint({
    required int id,
    required List<Offset> points,
    Color color = Colors.black,
    double strokeWidth = 2.0,
  }) {
    return ListOfPointNode(
      id: id,
      points: points,
      color: color.toARGB32(),
      strokeWidth: strokeWidth,
    );
  }
}
