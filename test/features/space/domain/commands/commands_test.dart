import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ideascape/features/space/domain/commands/add_node_command.dart';
import 'package:ideascape/features/space/domain/commands/delete_node_command.dart';
import 'package:ideascape/features/space/domain/commands/modify_node_command.dart';
import 'package:ideascape/features/space/domain/commands/batch_delete_command.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/interfaces/space_editor.dart';

class MockSpaceEditor extends Mock implements SpaceEditor {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      ShapeNode(id: 0, type: ShapeType.rectangle, rect: Rect.zero, color: 0),
    );
  });

  group('SpaceCommand interface', () {
    test('DefaultComment mixin provides null comment', () {
      // ModifyNodeCommand uses DefaultComment mixin
      final shape = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
      );
      final command = ModifyNodeCommand(
        originalNode: shape,
        modifiedNode: shape,
      );
      expect(command.comment, isNull);
    });
  });

  group('AddNodeCommand', () {
    late MockSpaceEditor editor;
    late ShapeNode testShape;

    setUp(() {
      editor = MockSpaceEditor();
      testShape = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF0000FF,
      );
      when(() => editor.addNode(any())).thenAnswer((_) async {});
      when(() => editor.removeNode(any())).thenAnswer((_) async {});
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

    test('execute adds node to editor', () async {
      final command = AddNodeCommand(testShape);

      await command.execute(editor);

      verify(() => editor.addNode(testShape)).called(1);
    });

    test('undo removes node from editor', () async {
      final command = AddNodeCommand(testShape);

      await command.undo(editor);

      verify(() => editor.removeNode(testShape.id)).called(1);
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
    late MockSpaceEditor editor;
    late ShapeNode testShape;

    setUp(() {
      editor = MockSpaceEditor();
      testShape = ShapeNode(
        id: 42,
        type: ShapeType.oval,
        rect: const Rect.fromLTWH(50, 50, 200, 200),
        color: 0xFFFF0000,
      );
      when(() => editor.removeNode(any())).thenAnswer((_) async {});
      when(() => editor.addNode(any())).thenAnswer((_) async {});
    });

    test('stores the node', () {
      final command = DeleteNodeCommand(testShape);
      expect(command.node, testShape);
    });

    test('uses DefaultComment mixin (comment is null)', () {
      final command = DeleteNodeCommand(testShape);
      expect(command.comment, isNull);
    });

    test('execute removes node from editor', () async {
      final command = DeleteNodeCommand(testShape);

      await command.execute(editor);

      verify(() => editor.removeNode(testShape.id)).called(1);
    });

    test('undo adds node back to editor', () async {
      final command = DeleteNodeCommand(testShape);

      await command.undo(editor);

      verify(() => editor.addNode(testShape)).called(1);
    });
  });

  group('ModifyNodeCommand', () {
    late MockSpaceEditor editor;
    late ShapeNode originalShape;
    late ShapeNode modifiedShape;

    setUp(() {
      editor = MockSpaceEditor();
      originalShape = ShapeNode(
        id: 10,
        type: ShapeType.triangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF00FF00,
      );
      modifiedShape = originalShape.copyWith(
        rect: const Rect.fromLTWH(200, 200, 100, 100),
      );
      when(() => editor.updateNode(any())).thenAnswer((_) async {});
    });

    test('stores original and modified nodes', () {
      final command = ModifyNodeCommand(
        originalNode: originalShape,
        modifiedNode: modifiedShape,
      );
      expect(command.originalNode, originalShape);
      expect(command.modifiedNode, modifiedShape);
    });

    test('uses DefaultComment mixin (comment is null)', () {
      final command = ModifyNodeCommand(
        originalNode: originalShape,
        modifiedNode: modifiedShape,
      );
      expect(command.comment, isNull);
    });

    test('execute updates node to modified state', () async {
      final command = ModifyNodeCommand(
        originalNode: originalShape,
        modifiedNode: modifiedShape,
      );

      await command.execute(editor);

      verify(() => editor.updateNode(modifiedShape)).called(1);
    });

    test('undo updates node back to original state', () async {
      final command = ModifyNodeCommand(
        originalNode: originalShape,
        modifiedNode: modifiedShape,
      );

      await command.undo(editor);

      verify(() => editor.updateNode(originalShape)).called(1);
    });
  });

  group('BatchDeleteCommand', () {
    late MockSpaceEditor editor;
    late List<ShapeNode> testShapes;

    setUp(() {
      editor = MockSpaceEditor();
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
      when(() => editor.removeNode(any())).thenAnswer((_) async {});
      when(() => editor.addNode(any())).thenAnswer((_) async {});
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

    test('execute removes all nodes from editor', () async {
      final command = BatchDeleteCommand(testShapes);

      await command.execute(editor);

      for (var shape in testShapes) {
        verify(() => editor.removeNode(shape.id)).called(1);
      }
    });

    test('undo adds all nodes back to editor', () async {
      final command = BatchDeleteCommand(testShapes);

      await command.undo(editor);

      for (var shape in testShapes) {
        verify(() => editor.addNode(shape)).called(1);
      }
    });

    test('handles empty nodes list', () async {
      final command = BatchDeleteCommand([]);

      await command.execute(editor);
      await command.undo(editor);

      verifyNever(() => editor.addNode(any()));
      verifyNever(() => editor.removeNode(any()));
    });

    test('handles single node', () async {
      final command = BatchDeleteCommand([testShapes.first]);

      await command.execute(editor);

      verify(() => editor.removeNode(testShapes.first.id)).called(1);
    });
  });
}

// Helper function to test _getCallerInfo from different call site
AddNodeCommand _createCommandFromHelper(ShapeNode shape) {
  return AddNodeCommand(shape);
}
