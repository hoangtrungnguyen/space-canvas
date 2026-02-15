import 'dart:ui';

import 'package:ideascape/features/space/domain/models/objects/node.dart';

class NodeJsonMapper {
  static Node fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;

    switch (type) {
      case 'shape':
        return _shapeFromJson(json);
      case 'text':
        return _textFromJson(json);
      case 'connector':
        return _connectorFromJson(json);
      case 'image':
        return _imageFromJson(json);
      case 'group':
        return _groupFromJson(json);
      case 'listOfPoint':
        return _listOfPointFromJson(json);
      // case 'path':
      //   return _pathFromJson(json);
      default:
        throw UnimplementedError(
          'Deserialization for type "$type" is not implemented.',
        );
    }
  }

  static ShapeNode _shapeFromJson(Map<String, dynamic> json) {
    return ShapeNode(
      id: json['id'] as int,
      zIndex: json['zIndex'] as int? ?? 0,
      type: ShapeType.values.byName(json['shapeType'] as String),
      rect: _rectFromJson(json['rect'] as Map<String, dynamic>),
      color: json['color'] as int,
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 2.0,
      text: json['text'] as String? ?? '',
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static TextNode _textFromJson(Map<String, dynamic> json) {
    return TextNode(
      id: json['id'] as int,
      zIndex: json['zIndex'] as int? ?? 0,
      text: json['textContent'] as String,
      position: _offsetFromJson(json['position'] as Map<String, dynamic>),
      fontSize: (json['fontSize'] as num).toDouble(),
      color: json['color'] as int,
      fontFamily: json['fontFamily'] as String?,
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static ConnectorNode _connectorFromJson(Map<String, dynamic> json) {
    return ConnectorNode(
      id: json['id'] as int,
      zIndex: json['zIndex'] as int? ?? 0,
      startNodeId: json['startNodeId'] as int,
      endNodeId: json['endNodeId'] as int,
      startPoint: _offsetFromJson(json['startPoint'] as Map<String, dynamic>),
      endPoint: _offsetFromJson(json['endPoint'] as Map<String, dynamic>),
      strokeWidth: (json['strokeWidth'] as num).toDouble(),
      color: json['color'] as int,
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static ImageNode _imageFromJson(Map<String, dynamic> json) {
    return ImageNode(
      id: json['id'] as int,
      zIndex: json['zIndex'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String,
      rect: _rectFromJson(json['rect'] as Map<String, dynamic>),
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static GroupNode _groupFromJson(Map<String, dynamic> json) {
    return GroupNode(
      id: json['id'] as int,
      zIndex: json['zIndex'] as int? ?? 0,
      childrenIds: (json['childrenIds'] as List).cast<int>(),
      rect: _rectFromJson(json['rect'] as Map<String, dynamic>),
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static ListOfPointNode _listOfPointFromJson(Map<String, dynamic> json) {
    return ListOfPointNode(
      id: json['id'] as int,
      zIndex: json['zIndex'] as int? ?? 0,
      points:
          (json['points'] as List)
              .map((e) => _offsetFromJson(e as Map<String, dynamic>))
              .toList(),
      strokeWidth: (json['strokeWidth'] as num).toDouble(),
      color: json['color'] as int,
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // --- Helpers ---

  static Rect _rectFromJson(Map<String, dynamic> json) {
    return Rect.fromLTWH(
      (json['left'] as num).toDouble(),
      (json['top'] as num).toDouble(),
      (json['width'] as num).toDouble(),
      (json['height'] as num).toDouble(),
    );
  }

  static Offset _offsetFromJson(Map<String, dynamic> json) {
    return Offset(
      (json['dx'] as num).toDouble(),
      (json['dy'] as num).toDouble(),
    );
  }
}
