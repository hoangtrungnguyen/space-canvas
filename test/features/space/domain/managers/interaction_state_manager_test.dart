import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:ideascape/features/space/domain/managers/interaction_state_manager.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/commands/add_node_command.dart';
import 'package:ideascape/features/space/domain/commands/delete_node_command.dart';
import 'package:ideascape/features/space/domain/commands/modify_node_command.dart';
import 'package:ideascape/features/space/domain/commands/batch_delete_command.dart';
import 'package:ideascape/features/space/domain/commands/add_connector_command.dart';

class MockActiveLayerBloc extends MockBloc<ActiveLayerEvent, ActiveLayerState>
    implements ActiveLayerBloc {}

class MockShapeLayerBloc extends MockBloc<ShapeLayerEvent, ShapeLayerState>
    implements ShapeLayerBloc {}

class MockHistoryManager extends Mock implements HistoryManager {}

class FakeActiveLayerEvent extends Fake implements ActiveLayerEvent {}

class FakeShapeLayerEvent extends Fake implements ShapeLayerEvent {}

class FakeNode extends Fake implements Node {
  final int _id;
  FakeNode(this._id);
  @override
  int get id => _id;
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeActiveLayerEvent());
    registerFallbackValue(FakeShapeLayerEvent());
    registerFallbackValue(AddNodeCommand(FakeNode(1)));
    registerFallbackValue(DeleteNodeCommand(FakeNode(1)));
    registerFallbackValue(
      ModifyNodeCommand(originalNode: FakeNode(1), modifiedNode: FakeNode(1)),
    );
    registerFallbackValue(BatchDeleteCommand([]));
    registerFallbackValue(
      AddConnectorCommand(
        ConnectorNode(
          id: 0,
          startPoint: Offset.zero,
          endPoint: Offset.zero,
          strokeWidth: 1,
          color: 0,
        ),
      ),
    );
  });

  group('InteractionStateManager', () {
    late InteractionStateManager manager;
    late MockActiveLayerBloc activeBloc;
    late MockShapeLayerBloc shapeBloc;
    late MockHistoryManager historyManager;

    setUp(() {
      activeBloc = MockActiveLayerBloc();
      shapeBloc = MockShapeLayerBloc();
      historyManager = MockHistoryManager();

      when(() => historyManager.execute(any())).thenAnswer((_) async {});

      manager = InteractionStateManager(
        activeBloc: activeBloc,
        shapeBloc: shapeBloc,
        history: historyManager,
      );
    });

    group('finalizeInteraction', () {
      test('should execute MoveNodeCommand if object moved', () {
        final original = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          color: 0xFF000000,
        );
        final moved = original.copyWith(
          rect: const Rect.fromLTWH(10, 10, 100, 100),
        );

        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(activeNodes: {1: moved}, originalNode: original),
        );

        manager.finalizeInteraction();

        verify(
          () => historyManager.execute(any(that: isA<ModifyNodeCommand>())),
        ).called(1);
        verify(
          () => activeBloc.add(ActiveLayerEvent.nodeActivated(moved)),
        ).called(1);
      });

      test('should NOT execute ModifyNodeCommand if object NOT moved', () {
        final original = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          color: 0xFF000000,
        );
        // Same object
        final current = original.copyWith();

        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(activeNodes: {1: current}, originalNode: original),
        );

        manager.finalizeInteraction();

        verifyNever(
          () => historyManager.execute(any(that: isA<ModifyNodeCommand>())),
        );
        verify(
          () => activeBloc.add(ActiveLayerEvent.nodeActivated(current)),
        ).called(1);
      });
    });

    group('commitAndDeactivate', () {
      test('should add new object via History if not in ShapeLayer', () {
        final obj = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          color: 0xFF000000,
        );

        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(activeNodes: {1: obj}, originalNode: null),
        );
        when(() => shapeBloc.state).thenReturn(
          ShapeLayerState.success(data: const ShapeLayerData(nodes: {})),
        );

        manager.commitAndDeactivate();

        verify(
          () => historyManager.execute(any(that: isA<AddNodeCommand>())),
        ).called(1);
        verify(
          () => activeBloc.add(ActiveLayerEvent.nodeDeactivated(1)),
        ).called(1);
      });

      test(
        'should restore existing object directly if id matches original',
        () {
          final obj = ShapeNode(
            id: 1,
            type: ShapeType.rectangle,
            rect: const Rect.fromLTWH(0, 0, 100, 100),
            color: 0xFF000000,
          );

          when(() => activeBloc.state).thenReturn(
            ActiveLayerState(activeNodes: {1: obj}, originalNode: obj),
          );
          // Not in shape layer currently (because it was moved to active layer)
          when(() => shapeBloc.state).thenReturn(
            ShapeLayerState.success(data: const ShapeLayerData(nodes: {})),
          );

          manager.commitAndDeactivate();

          // Should NOT add history command
          verifyNever(
            () => historyManager.execute(any(that: isA<AddNodeCommand>())),
          );
          // Should simply add back to shape layer
          verify(() => shapeBloc.add(ShapeLayerEvent.addNode(obj))).called(1);
          verify(
            () => activeBloc.add(ActiveLayerEvent.nodeDeactivated(1)),
          ).called(1);
        },
      );
    });

    group('deleteNode', () {
      test('should execute DeleteNodeCommand', () {
        final obj = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: Rect.zero,
          color: 0xFF000000,
        );
        manager.deleteNode(obj);
        verify(
          () => historyManager.execute(any(that: isA<DeleteNodeCommand>())),
        ).called(1);
      });
    });

    group('deleteNodes', () {
      test('should execute DeleteNodeCommand for single object', () {
        final obj = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: Rect.zero,
          color: 0xFF000000,
        );
        manager.deleteNodes([obj]);
        verify(
          () => historyManager.execute(any(that: isA<DeleteNodeCommand>())),
        ).called(1);
      });

      test('should execute BatchDeleteCommand for multiple objects', () {
        final obj1 = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: Rect.zero,
          color: 0xFF000000,
        );
        final obj2 = ShapeNode(
          id: 2,
          type: ShapeType.rectangle,
          rect: Rect.zero,
          color: 0xFF000000,
        );
        manager.deleteNodes([obj1, obj2]);
        verify(
          () => historyManager.execute(any(that: isA<BatchDeleteCommand>())),
        ).called(1);
      });
    });

    group('createConnector', () {
      test('should execute AddConnectorCommand', () {
        manager.createConnector(
          startPoint: Offset.zero,
          endPoint: const Offset(10, 10),
        );
        verify(
          () => historyManager.execute(any(that: isA<AddConnectorCommand>())),
        ).called(1);
      });
    });
    group('dragActiveObject', () {
      test('should move object and emit interactionStarted', () {
        final obj = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          color: 0xFF000000,
        );

        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(activeNodes: {1: obj}, dragStartPoint: Offset.zero),
        );

        manager.dragActiveNode(const Offset(10, 10), const Offset(10, 10));

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        expect(captured.length, 1);

        final event = captured.first as ActiveLayerEvent;
        event.maybeMap(
          interactionStarted: (e) {
            expect(e.node.rect.left, 10.0);
            expect(e.node.rect.top, 10.0);
          },
          orElse: () => fail('Expected interactionStarted event'),
        );
      });
    });
  });
}
