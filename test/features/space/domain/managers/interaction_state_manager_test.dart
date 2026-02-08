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
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/commands/add_shape_command.dart';
import 'package:ideascape/features/space/domain/commands/delete_object_command.dart';
import 'package:ideascape/features/space/domain/commands/move_object_command.dart';
import 'package:ideascape/features/space/domain/commands/batch_delete_command.dart';
import 'package:ideascape/features/space/domain/commands/add_connector_command.dart';

class MockActiveLayerBloc extends MockBloc<ActiveLayerEvent, ActiveLayerState>
    implements ActiveLayerBloc {}

class MockShapeLayerBloc extends MockBloc<ShapeLayerEvent, ShapeLayerState>
    implements ShapeLayerBloc {}

class MockHistoryManager extends Mock implements HistoryManager {}

class FakeActiveLayerEvent extends Fake implements ActiveLayerEvent {}

class FakeShapeLayerEvent extends Fake implements ShapeLayerEvent {}

class FakeSpaceObject extends Fake implements SpaceObject {
  final int _id;
  FakeSpaceObject(this._id);
  @override
  int get id => _id;
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeActiveLayerEvent());
    registerFallbackValue(FakeShapeLayerEvent());
    registerFallbackValue(AddShapeCommand(FakeSpaceObject(1)));
    registerFallbackValue(DeleteObjectCommand(FakeSpaceObject(1)));
    registerFallbackValue(
      MoveObjectCommand(
        originalObject: FakeSpaceObject(1),
        movedObject: FakeSpaceObject(1),
      ),
    );
    registerFallbackValue(BatchDeleteCommand([]));
    registerFallbackValue(
      AddConnectorCommand(
        ConnectorObject(
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
      test('should execute MoveObjectCommand if object moved', () {
        final original = ShapeObject(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          paint: Paint(),
        );
        final moved = original.copyWith(
          rect: const Rect.fromLTWH(10, 10, 100, 100),
        );

        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(activeObjects: {1: moved}, originalObject: original),
        );

        manager.finalizeInteraction();

        verify(
          () => historyManager.execute(any(that: isA<MoveObjectCommand>())),
        ).called(1);
        verify(
          () => activeBloc.add(ActiveLayerEvent.objectActivated(moved)),
        ).called(1);
      });

      test('should NOT execute MoveObjectCommand if object NOT moved', () {
        final original = ShapeObject(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          paint: Paint(),
        );
        // Same object
        final current = original.copyWith();

        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(
            activeObjects: {1: current},
            originalObject: original,
          ),
        );

        manager.finalizeInteraction();

        verifyNever(
          () => historyManager.execute(any(that: isA<MoveObjectCommand>())),
        );
        verify(
          () => activeBloc.add(ActiveLayerEvent.objectActivated(current)),
        ).called(1);
      });
    });

    group('commitAndDeactivate', () {
      test('should add new object via History if not in ShapeLayer', () {
        final obj = ShapeObject(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          paint: Paint(),
        );

        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(activeObjects: {1: obj}, originalObject: null),
        );
        when(() => shapeBloc.state).thenReturn(
          ShapeLayerState.success(data: const ShapeLayerData(objects: {})),
        );

        manager.commitAndDeactivate();

        verify(
          () => historyManager.execute(any(that: isA<AddShapeCommand>())),
        ).called(1);
        verify(
          () => activeBloc.add(ActiveLayerEvent.objectDeactivated(1)),
        ).called(1);
      });

      test(
        'should restore existing object directly if id matches original',
        () {
          final obj = ShapeObject(
            id: 1,
            type: ShapeType.rectangle,
            rect: const Rect.fromLTWH(0, 0, 100, 100),
            paint: Paint(),
          );

          when(() => activeBloc.state).thenReturn(
            ActiveLayerState(activeObjects: {1: obj}, originalObject: obj),
          );
          // Not in shape layer currently (because it was moved to active layer)
          when(() => shapeBloc.state).thenReturn(
            ShapeLayerState.success(data: const ShapeLayerData(objects: {})),
          );

          manager.commitAndDeactivate();

          // Should NOT add history command
          verifyNever(
            () => historyManager.execute(any(that: isA<AddShapeCommand>())),
          );
          // Should simply add back to shape layer
          verify(() => shapeBloc.add(ShapeLayerEvent.addObject(obj))).called(1);
          verify(
            () => activeBloc.add(ActiveLayerEvent.objectDeactivated(1)),
          ).called(1);
        },
      );
    });

    group('deleteObject', () {
      test('should execute DeleteObjectCommand', () {
        final obj = ShapeObject(
          id: 1,
          type: ShapeType.rectangle,
          rect: Rect.zero,
          paint: Paint(),
        );
        manager.deleteObject(obj);
        verify(
          () => historyManager.execute(any(that: isA<DeleteObjectCommand>())),
        ).called(1);
      });
    });

    group('deleteObjects', () {
      test('should execute DeleteObjectCommand for single object', () {
        final obj = ShapeObject(
          id: 1,
          type: ShapeType.rectangle,
          rect: Rect.zero,
          paint: Paint(),
        );
        manager.deleteObjects([obj]);
        verify(
          () => historyManager.execute(any(that: isA<DeleteObjectCommand>())),
        ).called(1);
      });

      test('should execute BatchDeleteCommand for multiple objects', () {
        final obj1 = ShapeObject(
          id: 1,
          type: ShapeType.rectangle,
          rect: Rect.zero,
          paint: Paint(),
        );
        final obj2 = ShapeObject(
          id: 2,
          type: ShapeType.rectangle,
          rect: Rect.zero,
          paint: Paint(),
        );
        manager.deleteObjects([obj1, obj2]);
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
        final obj = ShapeObject(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          paint: Paint(),
        );

        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(
            activeObjects: {1: obj},
            dragStartPoint: Offset.zero,
          ),
        );

        final delta = const Offset(10, 10);
        manager.dragActiveObject(Offset.zero, delta);

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        expect(captured.length, 1);

        final event = captured.first as ActiveLayerEvent;
        event.maybeMap(
          interactionStarted: (e) {
            expect(e.object.rect.left, 10.0);
            expect(e.object.rect.top, 10.0);
          },
          orElse: () => fail('Expected interactionStarted event'),
        );
      });
    });
  });
}
