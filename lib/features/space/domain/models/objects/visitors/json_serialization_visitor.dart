import 'dart:ui';

import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

class JsonSerializationVisitor
    implements SpaceObjectVisitor<Map<String, dynamic>> {
  const JsonSerializationVisitor();

  @override
  Map<String, dynamic> visitConnector(ConnectorObject object) {
    return {
      'type': 'connector',
      'id': object.id,
      'zIndex': object.zIndex,
      'startObjectId': object.startObjectId,
      'endObjectId': object.endObjectId,
      'startPoint': _offsetToJson(object.startPoint),
      'endPoint': _offsetToJson(object.endPoint),
      'strokeWidth': object.strokeWidth,
      'color': object.color,
    };
  }

  @override
  Map<String, dynamic> visitGroup(GroupObject object) {
    return {
      'type': 'group',
      'id': object.id,
      'zIndex': object.zIndex,
      'childrenIds': object.childrenIds,
      'rect': _rectToJson(object.rect),
    };
  }

  @override
  Map<String, dynamic> visitImage(ImageObject object) {
    return {
      'type': 'image',
      'id': object.id,
      'zIndex': object.zIndex,
      'imageUrl': object.imageUrl,
      'rect': _rectToJson(object.rect),
    };
  }

  @override
  Map<String, dynamic> visitListOfPoint(ListOfPointObject object) {
    return {
      'type': 'listOfPoint',
      'id': object.id,
      'zIndex': object.zIndex,
      'points': object.points.map(_offsetToJson).toList(),
      'strokeWidth': object.strokeWidth,
      'color': object.color,
    };
  }

  @override
  Map<String, dynamic> visitPath(PathObject object) {
    // PathObject based on dart:ui Path cannot be easily serialized.
    // Ideally, we should use ListOfPointObject for user drawings.
    // We will return a basic representation but reconstruction might be impossible
    // without the source data.
    return {
      'type': 'path',
      'id': object.id,
      'zIndex': object.zIndex,
      // 'path': 'serializing raw Path is not supported',
      // We might want to warn or handle this differently.
    };
  }

  @override
  Map<String, dynamic> visitShape(ShapeObject object) {
    return {
      'type': 'shape',
      'id': object.id,
      'zIndex': object.zIndex,
      'shapeType': object.type.name,
      'rect': _rectToJson(object.rect),
      'paint': _paintToJson(object.paint),
      'text': object.text,
    };
  }

  @override
  Map<String, dynamic> visitText(TextObject object) {
    return {
      'type': 'text',
      'id': object.id,
      'zIndex': object.zIndex,
      'textContent': object.text,
      'position': _offsetToJson(object.position),
      'fontSize': object.fontSize,
      'color': object.color,
      'fontFamily': object.fontFamily,
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

  Map<String, dynamic> _paintToJson(Paint paint) {
    return {
      'color': paint.color.toARGB32(),
      'strokeWidth': paint.strokeWidth,
      'style': paint.style.name, // PaintStyle.fill or PaintStyle.stroke
      'strokeCap': paint.strokeCap.name,
      'strokeJoin': paint.strokeJoin.name,
    };
  }
}
