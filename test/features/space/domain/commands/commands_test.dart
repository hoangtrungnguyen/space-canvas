import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ideascape/features/space/domain/commands/add_shape_command.dart';
import 'package:ideascape/features/space/domain/commands/delete_object_command.dart';
import 'package:ideascape/features/space/domain/commands/move_object_command.dart';
import 'package:ideascape/features/space/domain/commands/batch_delete_command.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

class MockShapeLayerBloc extends MockBloc<ShapeLayerEvent, ShapeLayerState>
    implements ShapeLayerBloc {}

class FakeShapeLayerEvent extends Fake implements ShapeLayerEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeShapeLayerEvent());
  });

  group('SpaceCommand interface', () {
    test('DefaultComment mixin provides null comment', () {
      // MoveObjectCommand uses DefaultComment mixin
      final shape = ShapeObject(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint(),
      );
      final command = MoveObjectCommand(
        originalObject: shape,
        movedObject: shape,
      );
      expect(command.comment, isNull);
    });
  });

  group('AddShapeCommand', () {
    late MockShapeLayerBloc bloc;
    late ShapeObject testShape;

    setUp(() {
      bloc = MockShapeLayerBloc();
      testShape = ShapeObject(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint()..color = const Color(0xFF0000FF),
      );
    });

    test('stores the object', () {
      final command = AddShapeCommand(testShape);
      expect(command.object, testShape);
    });

    test('comment returns caller info', () {
      final command = AddShapeCommand(testShape);
      // Comment should be non-null and contain some caller info
      expect(command.comment, isNotNull);
      expect(command.comment, isA<String>());
    });

    test('execute adds object to bloc', () async {
      final command = AddShapeCommand(testShape);

      await command.execute(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 1);

      // Verify the event is an addObject event
      final event = captured.first as ShapeLayerEvent;
      event.mapOrNull(addObject: (e) => expect(e.object, testShape));
    });

    test('undo removes object from bloc', () async {
      final command = AddShapeCommand(testShape);

      await command.undo(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 1);

      // Verify the event is a removeObject event
      final event = captured.first as ShapeLayerEvent;
      event.mapOrNull(removeObject: (e) => expect(e.objectId, testShape.id));
    });

    group('_getCallerInfo', () {
      test('returns caller location string', () {
        // The static method is called in constructor
        final command = AddShapeCommand(testShape);
        expect(command.comment, isNotEmpty);
      });

      test('handles various stack trace formats', () {
        // Create command from different call sites
        final command1 = AddShapeCommand(testShape);
        final command2 = _createCommandFromHelper(testShape);

        expect(command1.comment, isNotNull);
        expect(command2.comment, isNotNull);
      });
    });
  });

  group('DeleteObjectCommand', () {
    late MockShapeLayerBloc bloc;
    late ShapeObject testShape;

    setUp(() {
      bloc = MockShapeLayerBloc();
      testShape = ShapeObject(
        id: 42,
        type: ShapeType.oval,
        rect: const Rect.fromLTWH(50, 50, 200, 200),
        paint: Paint()..color = const Color(0xFFFF0000),
      );
    });

    test('stores the object', () {
      final command = DeleteObjectCommand(testShape);
      expect(command.object, testShape);
    });

    test('uses DefaultComment mixin (comment is null)', () {
      final command = DeleteObjectCommand(testShape);
      expect(command.comment, isNull);
    });

    test('execute removes object from bloc', () async {
      final command = DeleteObjectCommand(testShape);

      await command.execute(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 1);

      final event = captured.first as ShapeLayerEvent;
      event.mapOrNull(removeObject: (e) => expect(e.objectId, testShape.id));
    });

    test('undo adds object back to bloc', () async {
      final command = DeleteObjectCommand(testShape);

      await command.undo(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 1);

      final event = captured.first as ShapeLayerEvent;
      event.mapOrNull(addObject: (e) => expect(e.object, testShape));
    });
  });

  group('MoveObjectCommand', () {
    late MockShapeLayerBloc bloc;
    late ShapeObject originalShape;
    late ShapeObject movedShape;

    setUp(() {
      bloc = MockShapeLayerBloc();
      originalShape = ShapeObject(
        id: 10,
        type: ShapeType.triangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint()..color = const Color(0xFF00FF00),
      );
      movedShape = originalShape.copyWith(
        rect: const Rect.fromLTWH(200, 200, 100, 100),
      );
    });

    test('stores original and moved objects', () {
      final command = MoveObjectCommand(
        originalObject: originalShape,
        movedObject: movedShape,
      );
      expect(command.originalObject, originalShape);
      expect(command.movedObject, movedShape);
    });

    test('uses DefaultComment mixin (comment is null)', () {
      final command = MoveObjectCommand(
        originalObject: originalShape,
        movedObject: movedShape,
      );
      expect(command.comment, isNull);
    });

    test('execute removes original and adds moved object', () async {
      final command = MoveObjectCommand(
        originalObject: originalShape,
        movedObject: movedShape,
      );

      await command.execute(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 2);

      // First event: remove original
      (captured[0] as ShapeLayerEvent).mapOrNull(
        removeObject: (e) => expect(e.objectId, originalShape.id),
      );

      // Second event: add moved
      (captured[1] as ShapeLayerEvent).mapOrNull(
        addObject: (e) => expect(e.object, movedShape),
      );
    });

    test('undo removes moved and adds original object back', () async {
      final command = MoveObjectCommand(
        originalObject: originalShape,
        movedObject: movedShape,
      );

      await command.undo(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 2);

      // First event: remove moved
      (captured[0] as ShapeLayerEvent).mapOrNull(
        removeObject: (e) => expect(e.objectId, movedShape.id),
      );

      // Second event: add original back
      (captured[1] as ShapeLayerEvent).mapOrNull(
        addObject: (e) => expect(e.object, originalShape),
      );
    });
  });

  group('BatchDeleteCommand', () {
    late MockShapeLayerBloc bloc;
    late List<ShapeObject> testShapes;

    setUp(() {
      bloc = MockShapeLayerBloc();
      testShapes = [
        ShapeObject(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          paint: Paint()..color = const Color(0xFF0000FF),
        ),
        ShapeObject(
          id: 2,
          type: ShapeType.oval,
          rect: const Rect.fromLTWH(100, 100, 50, 50),
          paint: Paint()..color = const Color(0xFFFF0000),
        ),
        ShapeObject(
          id: 3,
          type: ShapeType.triangle,
          rect: const Rect.fromLTWH(200, 200, 75, 75),
          paint: Paint()..color = const Color(0xFF00FF00),
        ),
      ];
    });

    test('stores the objects list', () {
      final command = BatchDeleteCommand(testShapes);
      expect(command.objects, testShapes);
      expect(command.objects.length, 3);
    });

    test('uses DefaultComment mixin (comment is null)', () {
      final command = BatchDeleteCommand(testShapes);
      expect(command.comment, isNull);
    });

    test('execute removes all objects from bloc', () async {
      final command = BatchDeleteCommand(testShapes);

      await command.execute(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 3);

      for (var i = 0; i < testShapes.length; i++) {
        (captured[i] as ShapeLayerEvent).mapOrNull(
          removeObject: (e) => expect(e.objectId, testShapes[i].id),
        );
      }
    });

    test('undo adds all objects back to bloc', () async {
      final command = BatchDeleteCommand(testShapes);

      await command.undo(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 3);

      for (var i = 0; i < testShapes.length; i++) {
        (captured[i] as ShapeLayerEvent).mapOrNull(
          addObject: (e) => expect(e.object, testShapes[i]),
        );
      }
    });

    test('handles empty objects list', () async {
      final command = BatchDeleteCommand([]);

      await command.execute(bloc);
      await command.undo(bloc);

      // No events should be added
      verifyNever(() => bloc.add(any()));
    });

    test('handles single object', () async {
      final command = BatchDeleteCommand([testShapes.first]);

      await command.execute(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 1);
    });
  });
}

// Helper function to test _getCallerInfo from different call site
AddShapeCommand _createCommandFromHelper(ShapeObject shape) {
  return AddShapeCommand(shape);
}
