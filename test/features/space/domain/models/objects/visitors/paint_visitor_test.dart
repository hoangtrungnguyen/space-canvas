import 'dart:ui';
import 'package:flutter/material.dart'; // For Colors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/objects/visitors/paint_visitor.dart';

class MockCanvas extends Mock implements Canvas {}

void main() {
  group('PaintVisitor', () {
    late MockCanvas canvas;
    late PaintVisitor visitor;

    setUp(() {
      canvas = MockCanvas();
      visitor = PaintVisitor(canvas);
      // Register fallback values if needed for verify
      registerFallbackValue(Paint());
      registerFallbackValue(Path());
      registerFallbackValue(const Offset(0, 0));
      registerFallbackValue(const Rect.fromLTWH(0, 0, 0, 0));
    });

    test('should draw ShapeObject', () {
      final shape = ShapeObject(
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint()..color = Colors.red,
        id: 1,
      );

      shape.accept(visitor);

      verify(() => canvas.drawRect(shape.rect, any())).called(1);
    });

    test('should draw PathObject', () {
      final path = Path();
      path.moveTo(0, 0);
      path.lineTo(10, 10);

      final pathObj = PathObject(path: path, paint: Paint(), id: 2);

      pathObj.accept(visitor);

      verify(() => canvas.drawPath(path, any())).called(1);
    });

    // Note: TextObject drawing relies on TextPainter, which interacts with the engine.
    // Testing purely with mocks is hard because TextPainter.paint calls canvas methods
    // but also does layout which requires engine.
    // flutter_test environment provides a test engine so simpler calls might work,
    // but verifying specific canvas calls from TextPainter is flaky or depends on implementation.
    // We'll skip deep verification of TextPainter inner calls and satisfy with no-crash.
    test('should attempt to draw TextObject', () {
      final text = TextObject(
        text: 'Hello',
        position: const Offset(10, 10),
        fontSize: 20,
        color: 0xFF000000,
        id: 3,
      );

      // This might throw if font loading fails in test env without setup,
      // but usually works for basic text.
      expect(() => text.accept(visitor), returnsNormally);
    });

    test('should draw ConnectorObject', () {
      final connector = ConnectorObject(
        startObjectId: 1,
        endObjectId: 2,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        strokeWidth: 2,
        color: 0xFF000000,
        id: 4,
      );

      connector.accept(visitor);

      // Verify line is drawn
      verify(() => canvas.drawLine(any(), any(), any())).called(1);
      // Verify arrow head (path) is drawn
      verify(() => canvas.drawPath(any(), any())).called(1);
    });

    test('should draw ListOfPointObject', () {
      final points = ListOfPointObject(
        points: const [Offset(0, 0), Offset(100, 100)],
        strokeWidth: 2,
        color: 0xFF000000,
        id: 5,
      );

      points.accept(visitor);

      verify(() => canvas.drawPath(any(), any())).called(1);
    });
  });
}
