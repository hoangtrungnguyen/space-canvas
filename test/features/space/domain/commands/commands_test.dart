import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ideascape/features/space/domain/commands/add_node_command.dart';
import 'package:ideascape/features/space/domain/commands/delete_node_command.dart';
import 'package:ideascape/features/space/domain/commands/move_node_command.dart';
import 'package:ideascape/features/space/domain/commands/batch_delete_command.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
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
      // MoveNodeCommand uses DefaultComment mixin
      final shape = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
      );
      final command = MoveNodeCommand(originalNode: shape, movedNode: shape);
      expect(command.comment, isNull);
    });
  });

  group('AddNodeCommand', () {
    late MockShapeLayerBloc bloc;
    late ShapeNode testShape;

    setUp(() {
      bloc = MockShapeLayerBloc();
      testShape = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF0000FF,
      );
    });

    test('stores the node', () {
      final command = AddNodeCommand(testShape);
      expect(command.node, testShape);
    });

    test('comment returns caller info', () {
      final command = AddNodeCommand(testShape);
      // Comment should be non-null and contain some caller info
      expect(command.comment, isNotNull);
      expect(command.comment, isA<String>());
    });

    test('execute adds node to bloc', () async {
      final command = AddNodeCommand(testShape);

      await command.execute(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 1);

      // Verify the event is an addNode event
      final event = captured.first as ShapeLayerEvent;
      event.mapOrNull(addNode: (e) => expect(e.node, testShape));
    });

    test('undo removes node from bloc', () async {
      final command = AddNodeCommand(testShape);

      await command.undo(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 1);

      // Verify the event is a removeNode event
      final event = captured.first as ShapeLayerEvent;
      event.mapOrNull(removeNode: (e) => expect(e.nodeId, testShape.id));
    });

    group('_getCallerInfo', () {
      test('returns caller location string', () {
        // The static method is called in constructor
        final command = AddNodeCommand(testShape);
        expect(command.comment, isNotEmpty);
      });

      test('handles various stack trace formats', () {
        // Create command from different call sites
        final command1 = AddNodeCommand(testShape);
        final command2 = _createCommandFromHelper(testShape);

        expect(command1.comment, isNotNull);
        expect(command2.comment, isNotNull);
      });
    });
  });

  group('DeleteNodeCommand', () {
    late MockShapeLayerBloc bloc;
    late ShapeNode testShape;

    setUp(() {
      bloc = MockShapeLayerBloc();
      testShape = ShapeNode(
        id: 42,
        type: ShapeType.oval,
        rect: const Rect.fromLTWH(50, 50, 200, 200),
        color: 0xFFFF0000,
      );
    });

    test('stores the node', () {
      final command = DeleteNodeCommand(testShape);
      expect(command.node, testShape);
    });

    test('uses DefaultComment mixin (comment is null)', () {
      final command = DeleteNodeCommand(testShape);
      expect(command.comment, isNull);
    });

    test('execute removes node from bloc', () async {
      final command = DeleteNodeCommand(testShape);

      await command.execute(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 1);

      final event = captured.first as ShapeLayerEvent;
      event.mapOrNull(removeNode: (e) => expect(e.nodeId, testShape.id));
    });

    test('undo adds node back to bloc', () async {
      final command = DeleteNodeCommand(testShape);

      await command.undo(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 1);

      final event = captured.first as ShapeLayerEvent;
      event.mapOrNull(addNode: (e) => expect(e.node, testShape));
    });
  });

  group('MoveNodeCommand', () {
    late MockShapeLayerBloc bloc;
    late ShapeNode originalShape;
    late ShapeNode movedShape;

    setUp(() {
      bloc = MockShapeLayerBloc();
      originalShape = ShapeNode(
        id: 10,
        type: ShapeType.triangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF00FF00,
      );
      movedShape = originalShape.copyWith(
        rect: const Rect.fromLTWH(200, 200, 100, 100),
      );
    });

    test('stores original and moved nodes', () {
      final command = MoveNodeCommand(
        originalNode: originalShape,
        movedNode: movedShape,
      );
      expect(command.originalNode, originalShape);
      expect(command.movedNode, movedShape);
    });

    test('uses DefaultComment mixin (comment is null)', () {
      final command = MoveNodeCommand(
        originalNode: originalShape,
        movedNode: movedShape,
      );
      expect(command.comment, isNull);
    });

    test('execute removes original and adds moved node', () async {
      final command = MoveNodeCommand(
        originalNode: originalShape,
        movedNode: movedShape,
      );

      await command.execute(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 2);

      // First event: remove original
      (captured[0] as ShapeLayerEvent).mapOrNull(
        removeNode: (e) => expect(e.nodeId, originalShape.id),
      );

      // Second event: add moved
      (captured[1] as ShapeLayerEvent).mapOrNull(
        addNode: (e) => expect(e.node, movedShape),
      );
    });

    test('undo removes moved and adds original node back', () async {
      final command = MoveNodeCommand(
        originalNode: originalShape,
        movedNode: movedShape,
      );

      await command.undo(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 2);

      // First event: remove moved
      (captured[0] as ShapeLayerEvent).mapOrNull(
        removeNode: (e) => expect(e.nodeId, movedShape.id),
      );

      // Second event: add original back
      (captured[1] as ShapeLayerEvent).mapOrNull(
        addNode: (e) => expect(e.node, originalShape),
      );
    });
  });

  group('BatchDeleteCommand', () {
    late MockShapeLayerBloc bloc;
    late List<ShapeNode> testShapes;

    setUp(() {
      bloc = MockShapeLayerBloc();
      testShapes = [
        ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          color: 0xFF0000FF,
        ),
        ShapeNode(
          id: 2,
          type: ShapeType.oval,
          rect: const Rect.fromLTWH(100, 100, 50, 50),
          color: 0xFFFF0000,
        ),
        ShapeNode(
          id: 3,
          type: ShapeType.triangle,
          rect: const Rect.fromLTWH(200, 200, 75, 75),
          color: 0xFF00FF00,
        ),
      ];
    });

    test('stores the nodes list', () {
      final command = BatchDeleteCommand(testShapes);
      expect(command.nodes, testShapes);
      expect(command.nodes.length, 3);
    });

    test('uses DefaultComment mixin (comment is null)', () {
      final command = BatchDeleteCommand(testShapes);
      expect(command.comment, isNull);
    });

    test('execute removes all nodes from bloc', () async {
      final command = BatchDeleteCommand(testShapes);

      await command.execute(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 3);

      for (var i = 0; i < testShapes.length; i++) {
        (captured[i] as ShapeLayerEvent).mapOrNull(
          removeNode: (e) => expect(e.nodeId, testShapes[i].id),
        );
      }
    });

    test('undo adds all nodes back to bloc', () async {
      final command = BatchDeleteCommand(testShapes);

      await command.undo(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 3);

      for (var i = 0; i < testShapes.length; i++) {
        (captured[i] as ShapeLayerEvent).mapOrNull(
          addNode: (e) => expect(e.node, testShapes[i]),
        );
      }
    });

    test('handles empty nodes list', () async {
      final command = BatchDeleteCommand([]);

      await command.execute(bloc);
      await command.undo(bloc);

      // No events should be added
      verifyNever(() => bloc.add(any()));
    });

    test('handles single node', () async {
      final command = BatchDeleteCommand([testShapes.first]);

      await command.execute(bloc);

      final captured = verify(() => bloc.add(captureAny())).captured;
      expect(captured.length, 1);
    });
  });
}

// Helper function to test _getCallerInfo from different call site
AddNodeCommand _createCommandFromHelper(ShapeNode shape) {
  return AddNodeCommand(shape);
}
