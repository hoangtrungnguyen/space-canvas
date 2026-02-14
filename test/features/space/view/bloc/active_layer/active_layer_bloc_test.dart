import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';

void main() {
  group('ActiveLayerBloc', () {
    late ActiveLayerBloc bloc;
    late ShapeNode testShape;
    late ShapeNode testShape2;

    setUp(() {
      bloc = ActiveLayerBloc();
      testShape = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 100, 100),
        paint: Paint()..color = const Color(0xFF0000FF),
      );
      testShape2 = ShapeNode(
        id: 2,
        type: ShapeType.oval,
        rect: const Rect.fromLTWH(200, 200, 50, 50),
        paint: Paint()..color = const Color(0xFFFF0000),
      );
    });

    tearDown(() {
      bloc.close();
    });

    test('constructor creates bloc with empty initial state', () {
      expect(bloc.state, const ActiveLayerState());
      expect(bloc.state.activeNodes, isEmpty);
      expect(bloc.state.dragStartPoint, isNull);
      expect(bloc.state.originalNode, isNull);
      expect(bloc.state.resizeHandle, isNull);
    });

    group('started event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'does nothing (no state change)',
        build: () => ActiveLayerBloc(),
        act: (bloc) => bloc.add(const ActiveLayerEvent.started()),
        expect: () => [],
      );
    });

    group('nodeActivated event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'adds object to activeNodes',
        build: () => ActiveLayerBloc(),
        act: (bloc) => bloc.add(ActiveLayerEvent.nodeActivated(testShape)),
        expect:
            () => [
              ActiveLayerState(activeNodes: {testShape.id: testShape}),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'adds multiple objects to activeNodes',
        build: () => ActiveLayerBloc(),
        act: (bloc) {
          bloc.add(ActiveLayerEvent.nodeActivated(testShape));
          bloc.add(ActiveLayerEvent.nodeActivated(testShape2));
        },
        expect:
            () => [
              ActiveLayerState(activeNodes: {testShape.id: testShape}),
              ActiveLayerState(
                activeNodes: {
                  testShape.id: testShape,
                  testShape2.id: testShape2,
                },
              ),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'replaces existing object with same id',
        build: () => ActiveLayerBloc(),
        seed: () => ActiveLayerState(activeNodes: {testShape.id: testShape}),
        act: (bloc) {
          final updatedShape = testShape.copyWith(
            rect: const Rect.fromLTWH(150, 150, 200, 200),
          );
          bloc.add(ActiveLayerEvent.nodeActivated(updatedShape));
        },
        expect:
            () => [
              isA<ActiveLayerState>().having(
                (s) => s.activeNodes[testShape.id]?.rect,
                'updated rect',
                const Rect.fromLTWH(150, 150, 200, 200),
              ),
            ],
      );
    });

    group('nodeChanged event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'updates existing object in activeNodes',
        build: () => ActiveLayerBloc(),
        seed: () => ActiveLayerState(activeNodes: {testShape.id: testShape}),
        act: (bloc) {
          final updatedShape = testShape.copyWith(
            rect: const Rect.fromLTWH(200, 200, 150, 150),
          );
          bloc.add(ActiveLayerEvent.nodeChanged(updatedShape));
        },
        expect:
            () => [
              isA<ActiveLayerState>().having(
                (s) => s.activeNodes[testShape.id]?.rect,
                'updated rect',
                const Rect.fromLTWH(200, 200, 150, 150),
              ),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'does nothing if object id not in activeNodes',
        build: () => ActiveLayerBloc(),
        seed: () => ActiveLayerState(activeNodes: {testShape.id: testShape}),
        act: (bloc) => bloc.add(ActiveLayerEvent.nodeChanged(testShape2)),
        expect: () => [],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'does nothing on empty activeNodes',
        build: () => ActiveLayerBloc(),
        act: (bloc) => bloc.add(ActiveLayerEvent.nodeChanged(testShape)),
        expect: () => [],
      );
    });

    group('interactionStarted event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'adds object and sets dragStartPoint',
        build: () => ActiveLayerBloc(),
        act:
            (bloc) => bloc.add(
              ActiveLayerEvent.interactionStarted(
                node: testShape,
                point: const Offset(100, 100),
              ),
            ),
        expect:
            () => [
              ActiveLayerState(
                activeNodes: {testShape.id: testShape},
                dragStartPoint: const Offset(100, 100),
              ),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'updates dragStartPoint on subsequent interactions',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeNodes: {testShape.id: testShape},
              dragStartPoint: const Offset(50, 50),
            ),
        act:
            (bloc) => bloc.add(
              ActiveLayerEvent.interactionStarted(
                node: testShape,
                point: const Offset(200, 200),
              ),
            ),
        expect:
            () => [
              ActiveLayerState(
                activeNodes: {testShape.id: testShape},
                dragStartPoint: const Offset(200, 200),
              ),
            ],
      );
    });

    group('shapeUpdated event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'updates shape without changing dragStartPoint',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeNodes: {testShape.id: testShape},
              dragStartPoint: const Offset(100, 100),
            ),
        act: (bloc) {
          final updatedShape = testShape.copyWith(
            rect: const Rect.fromLTWH(100, 100, 200, 200),
          );
          bloc.add(ActiveLayerEvent.shapeUpdated(updatedShape));
        },
        expect:
            () => [
              isA<ActiveLayerState>()
                  .having(
                    (s) => s.activeNodes[testShape.id]?.rect,
                    'updated rect',
                    const Rect.fromLTWH(100, 100, 200, 200),
                  )
                  .having(
                    (s) => s.dragStartPoint,
                    'dragStartPoint preserved',
                    const Offset(100, 100),
                  ),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'adds new object if not present',
        build: () => ActiveLayerBloc(),
        act: (bloc) => bloc.add(ActiveLayerEvent.shapeUpdated(testShape)),
        expect:
            () => [
              ActiveLayerState(activeNodes: {testShape.id: testShape}),
            ],
      );
    });

    group('nodeDeactivated event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'removes object and clears dragStartPoint and originalNode',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeNodes: {testShape.id: testShape},
              dragStartPoint: const Offset(100, 100),
              originalNode: testShape,
            ),
        act: (bloc) => bloc.add(ActiveLayerEvent.nodeDeactivated(testShape.id)),
        expect:
            () => [
              const ActiveLayerState(
                activeNodes: {},
                dragStartPoint: null,
                originalNode: null,
              ),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'removes only specified object, keeps others',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeNodes: {testShape.id: testShape, testShape2.id: testShape2},
            ),
        act: (bloc) => bloc.add(ActiveLayerEvent.nodeDeactivated(testShape.id)),
        expect:
            () => [
              ActiveLayerState(
                activeNodes: {testShape2.id: testShape2},
                dragStartPoint: null,
                originalNode: null,
              ),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'does nothing if object id not present and state unchanged',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeNodes: {testShape.id: testShape},
              dragStartPoint: null,
              originalNode: null,
            ),
        act: (bloc) => bloc.add(const ActiveLayerEvent.nodeDeactivated(999)),
        expect: () => [],
      );
    });

    group('originalNodeSet event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'sets originalNode',
        build: () => ActiveLayerBloc(),
        act: (bloc) => bloc.add(ActiveLayerEvent.originalNodeSet(testShape)),
        expect: () => [ActiveLayerState(originalNode: testShape)],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'clears originalNode when set to null',
        build: () => ActiveLayerBloc(),
        seed: () => ActiveLayerState(originalNode: testShape),
        act: (bloc) => bloc.add(const ActiveLayerEvent.originalNodeSet(null)),
        expect: () => [const ActiveLayerState(originalNode: null)],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'preserves other state when setting originalNode',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeNodes: {testShape.id: testShape},
              dragStartPoint: const Offset(50, 50),
              resizeHandle: ResizeHandle.topLeft,
            ),
        act: (bloc) => bloc.add(ActiveLayerEvent.originalNodeSet(testShape2)),
        expect:
            () => [
              ActiveLayerState(
                activeNodes: {testShape.id: testShape},
                dragStartPoint: const Offset(50, 50),
                resizeHandle: ResizeHandle.topLeft,
                originalNode: testShape2,
              ),
            ],
      );
    });

    group('clear event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'clears activeNodes, dragStartPoint, and originalNode',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeNodes: {testShape.id: testShape, testShape2.id: testShape2},
              dragStartPoint: const Offset(100, 100),
              originalNode: testShape,
              resizeHandle: ResizeHandle.bottomRight,
            ),
        act: (bloc) => bloc.add(const ActiveLayerEvent.clear()),
        expect:
            () => [
              // Note: clear does NOT modify resizeHandle based on implementation
              const ActiveLayerState(
                activeNodes: {},
                dragStartPoint: null,
                originalNode: null,
              ).copyWith(resizeHandle: ResizeHandle.bottomRight),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'emits state on already empty activeNodes',
        build: () => ActiveLayerBloc(),
        act: (bloc) => bloc.add(const ActiveLayerEvent.clear()),
        expect:
            () => [
              const ActiveLayerState(
                activeNodes: {},
                dragStartPoint: null,
                originalNode: null,
              ),
            ],
      );
    });

    group('handleChanged event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'sets resizeHandle',
        build: () => ActiveLayerBloc(),
        act:
            (bloc) => bloc.add(
              const ActiveLayerEvent.handleChanged(ResizeHandle.topLeft),
            ),
        expect:
            () => [const ActiveLayerState(resizeHandle: ResizeHandle.topLeft)],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'clears resizeHandle when set to null',
        build: () => ActiveLayerBloc(),
        seed:
            () =>
                const ActiveLayerState(resizeHandle: ResizeHandle.bottomRight),
        act: (bloc) => bloc.add(const ActiveLayerEvent.handleChanged(null)),
        expect: () => [const ActiveLayerState(resizeHandle: null)],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'changes resizeHandle from one to another',
        build: () => ActiveLayerBloc(),
        seed: () => const ActiveLayerState(resizeHandle: ResizeHandle.topLeft),
        act:
            (bloc) => bloc.add(
              const ActiveLayerEvent.handleChanged(ResizeHandle.centerRight),
            ),
        expect:
            () => [
              const ActiveLayerState(resizeHandle: ResizeHandle.centerRight),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'preserves other state when changing handle',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeNodes: {testShape.id: testShape},
              dragStartPoint: const Offset(150, 150),
              originalNode: testShape,
            ),
        act:
            (bloc) => bloc.add(
              const ActiveLayerEvent.handleChanged(ResizeHandle.topCenter),
            ),
        expect:
            () => [
              ActiveLayerState(
                activeNodes: {testShape.id: testShape},
                dragStartPoint: const Offset(150, 150),
                originalNode: testShape,
                resizeHandle: ResizeHandle.topCenter,
              ),
            ],
      );
    });
  });
}
