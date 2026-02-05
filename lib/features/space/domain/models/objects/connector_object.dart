import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

part 'connector_object.freezed.dart';

/// Enum indicating which edge of an object a connector attaches to.
enum ConnectorEdge { north, south, east, west }

@freezed
abstract class ConnectorObject extends SpaceObject with _$ConnectorObject {
  factory ConnectorObject({
    int? startObjectId,
    int? endObjectId,
    required Offset startPoint,
    required Offset endPoint,
    required double strokeWidth,
    required int color,
    required int id,
    @Default(0) int zIndex,

    /// Which edge of the start object this connector originates from.
    ConnectorEdge? startLocation,

    /// Which edge of the end object this connector terminates at.
    ConnectorEdge? endLocation,
  }) = _ConnectorObject;

  ConnectorObject._();

  @override
  T accept<T>(SpaceObjectVisitor<T> visitor) => visitor.visitConnector(this);

  @override
  Rect get rect => Rect.fromPoints(startPoint, endPoint).inflate(strokeWidth);
}
