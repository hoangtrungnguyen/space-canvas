import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/domain/commands/space_command.dart';
import 'package:ideascape/features/space/domain/commands/add_node_command.dart';
import 'package:ideascape/features/space/domain/commands/delete_node_command.dart';
import 'package:ideascape/features/space/domain/commands/move_node_command.dart';
import 'package:ideascape/features/space/domain/commands/batch_delete_command.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

class MockShapeLayerBloc extends MockBloc<ShapeLayerEvent, ShapeLayerState>
    implements ShapeLayerBloc {}

class FakeShapeLayerEvent extends Fake implements ShapeLayerEvent {}

/// A simple mock command for testing basic execute/undo flow
class MockCommand extends SpaceCommand {
  bool executed = false;
  bool undone = false;
  final String? _comment;

  MockCommand({String? comment}) : _comment = comment;

  @override
  String? get comment => _comment;

  @override
  Future<void> execute(ShapeLayerBloc bloc) async {
    executed = true;
  }

  @override
  Future<void> undo(ShapeLayerBloc bloc) async {
    undone = true;
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeShapeLayerEvent());
  });

  group('HistoryManager', () {
    late MockShapeLayerBloc bloc;
    late HistoryManager historyManager;
    late ShapeNode testShape;

    setUp(() {
      bloc = MockShapeLayerBloc();
      historyManager = HistoryManager(bloc);
      testShape = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        paint: Paint()..color = const Color(0xFF0000FF),
      );
    });

    tearDown(() {
      historyManager.dispose();
    });

    group('constructor', () {
      test('creates manager with empty stacks', () {
        expect(historyManager.canUndo, isFalse);
        expect(historyManager.canRedo, isFalse);
      });
    });

    group('updateShapeLayerBloc', () {
      test('updates the internal bloc reference', () async {
        final newBloc = MockShapeLayerBloc();
        final command = MockCommand();

        historyManager.updateShapeLayerBloc(newBloc);
        await historyManager.execute(command);

        expect(command.executed, isTrue);
      });

      test('does nothing when same bloc is passed', () {
        historyManager.updateShapeLayerBloc(bloc);
        expect(historyManager.canUndo, isFalse);
      });
    });

    group('execute', () {
      test('executes the command', () async {
        final command = MockCommand();

        await historyManager.execute(command);

        expect(command.executed, isTrue);
      });

      test('adds command to undo stack', () async {
        final command = MockCommand();

        await historyManager.execute(command);

        expect(historyManager.canUndo, isTrue);
      });

      test('clears redo stack on execute', () async {
        final command1 = MockCommand();
        final command2 = MockCommand();

        await historyManager.execute(command1);
        await historyManager.undo();
        expect(historyManager.canRedo, isTrue);

        await historyManager.execute(command2);
        expect(historyManager.canRedo, isFalse);
      });

      test('notifies listeners', () async {
        var notified = false;
        historyManager.addListener(() => notified = true);

        await historyManager.execute(MockCommand());

        expect(notified, isTrue);
      });
    });

    group('undo', () {
      test('does nothing when undo stack is empty', () async {
        await historyManager.undo();
        expect(historyManager.canRedo, isFalse);
      });

      test('undoes the last command', () async {
        final command = MockCommand();
        await historyManager.execute(command);

        await historyManager.undo();

        expect(command.undone, isTrue);
      });

      test('moves command to redo stack', () async {
        await historyManager.execute(MockCommand());

        await historyManager.undo();

        expect(historyManager.canUndo, isFalse);
        expect(historyManager.canRedo, isTrue);
      });

      test('notifies listeners', () async {
        await historyManager.execute(MockCommand());

        var notified = false;
        historyManager.addListener(() => notified = true);
        await historyManager.undo();

        expect(notified, isTrue);
      });
    });

    group('redo', () {
      test('does nothing when redo stack is empty', () async {
        await historyManager.redo();
        expect(historyManager.canUndo, isFalse);
      });

      test('re-executes the undone command', () async {
        final command = MockCommand();
        await historyManager.execute(command);
        await historyManager.undo();
        command.executed = false;

        await historyManager.redo();

        expect(command.executed, isTrue);
      });

      test('moves command back to undo stack', () async {
        await historyManager.execute(MockCommand());
        await historyManager.undo();

        await historyManager.redo();

        expect(historyManager.canUndo, isTrue);
        expect(historyManager.canRedo, isFalse);
      });

      test('notifies listeners', () async {
        await historyManager.execute(MockCommand());
        await historyManager.undo();

        var notified = false;
        historyManager.addListener(() => notified = true);
        await historyManager.redo();

        expect(notified, isTrue);
      });
    });

    group('canUndo', () {
      test('returns false when undo stack is empty', () {
        expect(historyManager.canUndo, isFalse);
      });

      test('returns true when undo stack has commands', () async {
        await historyManager.execute(MockCommand());
        expect(historyManager.canUndo, isTrue);
      });
    });

    group('canRedo', () {
      test('returns false when redo stack is empty', () {
        expect(historyManager.canRedo, isFalse);
      });

      test('returns true when redo stack has commands', () async {
        await historyManager.execute(MockCommand());
        await historyManager.undo();
        expect(historyManager.canRedo, isTrue);
      });
    });

    group('clear', () {
      test('clears both undo and redo stacks', () async {
        await historyManager.execute(MockCommand());
        await historyManager.execute(MockCommand());
        await historyManager.undo();

        historyManager.clear();

        expect(historyManager.canUndo, isFalse);
        expect(historyManager.canRedo, isFalse);
      });

      test('notifies listeners', () async {
        await historyManager.execute(MockCommand());

        var notified = false;
        historyManager.addListener(() => notified = true);
        historyManager.clear();

        expect(notified, isTrue);
      });
    });

    group('_formatCommand and _getObjectInfo (via logging)', () {
      test('handles AddNodeCommand', () async {
        final command = AddNodeCommand(testShape);
        await historyManager.execute(command);
        expect(historyManager.canUndo, isTrue);
      });

      test('handles DeleteNodeCommand', () async {
        final command = DeleteNodeCommand(testShape);
        await historyManager.execute(command);
        expect(historyManager.canUndo, isTrue);
      });

      test('handles MoveNodeCommand', () async {
        final movedShape = testShape.copyWith(
          rect: const Rect.fromLTWH(50, 50, 100, 100),
        );
        final command = MoveNodeCommand(
          originalNode: testShape,
          movedNode: movedShape,
        );
        await historyManager.execute(command);
        expect(historyManager.canUndo, isTrue);
      });

      test('handles BatchDeleteCommand', () async {
        final shape2 = ShapeNode(
          id: 2,
          type: ShapeType.oval,
          rect: const Rect.fromLTWH(100, 100, 50, 50),
          paint: Paint()..color = const Color(0xFFFF0000),
        );
        final command = BatchDeleteCommand([testShape, shape2]);
        await historyManager.execute(command);
        expect(historyManager.canUndo, isTrue);
      });

      test('handles command with comment', () async {
        final command = MockCommand(comment: 'Test comment');
        await historyManager.execute(command);
        expect(historyManager.canUndo, isTrue);
      });

      test('handles command without comment', () async {
        final command = MockCommand();
        await historyManager.execute(command);
        expect(historyManager.canUndo, isTrue);
      });

      test('handles unknown command type', () async {
        final command = MockCommand();
        await historyManager.execute(command);
        await historyManager.undo();
        await historyManager.redo();
        expect(historyManager.canUndo, isTrue);
      });
    });

    group('multiple operations sequence', () {
      test('handles execute-undo-redo-undo-redo sequence', () async {
        final command1 = MockCommand();
        final command2 = MockCommand();

        await historyManager.execute(command1);
        await historyManager.execute(command2);
        expect(historyManager.canUndo, isTrue);
        expect(historyManager.canRedo, isFalse);

        await historyManager.undo();
        expect(historyManager.canUndo, isTrue);
        expect(historyManager.canRedo, isTrue);

        await historyManager.undo();
        expect(historyManager.canUndo, isFalse);
        expect(historyManager.canRedo, isTrue);

        await historyManager.redo();
        expect(historyManager.canUndo, isTrue);
        expect(historyManager.canRedo, isTrue);

        await historyManager.redo();
        expect(historyManager.canUndo, isTrue);
        expect(historyManager.canRedo, isFalse);
      });

      test('new execute after undo clears redo history', () async {
        final command1 = MockCommand();
        final command2 = MockCommand();
        final command3 = MockCommand();

        await historyManager.execute(command1);
        await historyManager.execute(command2);
        await historyManager.undo();
        expect(historyManager.canRedo, isTrue);

        await historyManager.execute(command3);
        expect(historyManager.canRedo, isFalse);
        expect(historyManager.canUndo, isTrue);
      });
    });
  });
}
