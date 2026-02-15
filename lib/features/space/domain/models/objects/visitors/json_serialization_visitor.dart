import 'dart:ui';

import 'package:ideascape/features/space/domain/models/objects/node.dart';

class JsonSerializationVisitor implements NodeVisitor<Map<String, dynamic>> {
  const JsonSerializationVisitor();

  @override
  Map<String, dynamic> visitConnector(ConnectorNode object) {
    return {
      'type': 'connector',
      'id': object.id,
      'zIndex': object.zIndex,
      'startNodeId': object.startNodeId,
      'endNodeId': object.endNodeId,
      'startPoint': _offsetToJson(object.startPoint),
      'endPoint': _offsetToJson(object.endPoint),
      'strokeWidth': object.strokeWidth,
      'color': object.color,
      'rotation': object.rotation,
    };
  }

  @override
  Map<String, dynamic> visitGroup(GroupNode object) {
    return {
      'type': 'group',
      'id': object.id,
      'zIndex': object.zIndex,
      'childrenIds': object.childrenIds,
      'rect': _rectToJson(object.rect),
      'rotation': object.rotation,
    };
  }

  @override
  Map<String, dynamic> visitImage(ImageNode object) {
    return {
      'type': 'image',
      'id': object.id,
      'zIndex': object.zIndex,
      'imageUrl': object.imageUrl,
      'rect': _rectToJson(object.rect),
      'rotation': object.rotation,
    };
  }

  @override
  Map<String, dynamic> visitListOfPoint(ListOfPointNode object) {
    return {
      'type': 'listOfPoint',
      'id': object.id,
      'zIndex': object.zIndex,
      'points': object.points.map(_offsetToJson).toList(),
      'strokeWidth': object.strokeWidth,
      'color': object.color,
      'rotation': object.rotation,
    };
  }

  @override
  Map<String, dynamic> visitShape(ShapeNode object) {
    return {
      'type': 'shape',
      'id': object.id,
      'zIndex': object.zIndex,
      'shapeType': object.type.name,
      'rect': _rectToJson(object.rect),
      'color': object.color,
      'strokeWidth': object.strokeWidth,
      'text': object.text,
      'rotation': object.rotation,
    };
  }

  @override
  Map<String, dynamic> visitText(TextNode object) {
    return {
      'type': 'text',
      'id': object.id,
      'zIndex': object.zIndex,
      'textContent': object.text,
      'position': _offsetToJson(object.position),
      'fontSize': object.fontSize,
      'color': object.color,
      'fontFamily': object.fontFamily,
      'rotation': object.rotation,
    };
  }

  // --- Helpers ---

  Map<String, dynamic> _rectToJson(Rect rect) {
    return {
      'left': rect.left,
      'top': rect.top,
      'width': rect.width,
      'height': rect.height,
    };
  }

  Map<String, dynamic> _offsetToJson(Offset offset) {
    return {'dx': offset.dx, 'dy': offset.dy};
  }
}
