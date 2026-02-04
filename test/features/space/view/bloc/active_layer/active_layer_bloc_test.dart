import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';

void main() {
  group('ActiveLayerBloc', () {
    late ActiveLayerBloc bloc;
    late ShapeObject testShape;
    late ShapeObject testShape2;

    setUp(() {
      bloc = ActiveLayerBloc();
      testShape = ShapeObject(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 100, 100),
        paint: Paint()..color = const Color(0xFF0000FF),
      );
      testShape2 = ShapeObject(
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
      expect(bloc.state.activeObjects, isEmpty);
      expect(bloc.state.dragStartPoint, isNull);
      expect(bloc.state.originalObject, isNull);
      expect(bloc.state.activeHandle, isNull);
    });

    group('started event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'does nothing (no state change)',
        build: () => ActiveLayerBloc(),
        act: (bloc) => bloc.add(const ActiveLayerEvent.started()),
        expect: () => [],
      );
    });

    group('objectActivated event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'adds object to activeObjects',
        build: () => ActiveLayerBloc(),
        act: (bloc) => bloc.add(ActiveLayerEvent.objectActivated(testShape)),
        expect:
            () => [
              ActiveLayerState(activeObjects: {testShape.id: testShape}),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'adds multiple objects to activeObjects',
        build: () => ActiveLayerBloc(),
        act: (bloc) {
          bloc.add(ActiveLayerEvent.objectActivated(testShape));
          bloc.add(ActiveLayerEvent.objectActivated(testShape2));
        },
        expect:
            () => [
              ActiveLayerState(activeObjects: {testShape.id: testShape}),
              ActiveLayerState(
                activeObjects: {
                  testShape.id: testShape,
                  testShape2.id: testShape2,
                },
              ),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'replaces existing object with same id',
        build: () => ActiveLayerBloc(),
        seed: () => ActiveLayerState(activeObjects: {testShape.id: testShape}),
        act: (bloc) {
          final updatedShape = testShape.copyWith(
            rect: const Rect.fromLTWH(150, 150, 200, 200),
          );
          bloc.add(ActiveLayerEvent.objectActivated(updatedShape));
        },
        expect:
            () => [
              isA<ActiveLayerState>().having(
                (s) => s.activeObjects[testShape.id]?.rect,
                'updated rect',
                const Rect.fromLTWH(150, 150, 200, 200),
              ),
            ],
      );
    });

    group('objectChanged event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'updates existing object in activeObjects',
        build: () => ActiveLayerBloc(),
        seed: () => ActiveLayerState(activeObjects: {testShape.id: testShape}),
        act: (bloc) {
          final updatedShape = testShape.copyWith(
            rect: const Rect.fromLTWH(200, 200, 150, 150),
          );
          bloc.add(ActiveLayerEvent.objectChanged(updatedShape));
        },
        expect:
            () => [
              isA<ActiveLayerState>().having(
                (s) => s.activeObjects[testShape.id]?.rect,
                'updated rect',
                const Rect.fromLTWH(200, 200, 150, 150),
              ),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'does nothing if object id not in activeObjects',
        build: () => ActiveLayerBloc(),
        seed: () => ActiveLayerState(activeObjects: {testShape.id: testShape}),
        act: (bloc) => bloc.add(ActiveLayerEvent.objectChanged(testShape2)),
        expect: () => [],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'does nothing on empty activeObjects',
        build: () => ActiveLayerBloc(),
        act: (bloc) => bloc.add(ActiveLayerEvent.objectChanged(testShape)),
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
                object: testShape,
                point: const Offset(100, 100),
              ),
            ),
        expect:
            () => [
              ActiveLayerState(
                activeObjects: {testShape.id: testShape},
                dragStartPoint: const Offset(100, 100),
              ),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'updates dragStartPoint on subsequent interactions',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeObjects: {testShape.id: testShape},
              dragStartPoint: const Offset(50, 50),
            ),
        act:
            (bloc) => bloc.add(
              ActiveLayerEvent.interactionStarted(
                object: testShape,
                point: const Offset(200, 200),
              ),
            ),
        expect:
            () => [
              ActiveLayerState(
                activeObjects: {testShape.id: testShape},
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
              activeObjects: {testShape.id: testShape},
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
                    (s) => s.activeObjects[testShape.id]?.rect,
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
              ActiveLayerState(activeObjects: {testShape.id: testShape}),
            ],
      );
    });

    group('objectDeactivated event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'removes object and clears dragStartPoint and originalObject',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeObjects: {testShape.id: testShape},
              dragStartPoint: const Offset(100, 100),
              originalObject: testShape,
            ),
        act:
            (bloc) =>
                bloc.add(ActiveLayerEvent.objectDeactivated(testShape.id)),
        expect:
            () => [
              const ActiveLayerState(
                activeObjects: {},
                dragStartPoint: null,
                originalObject: null,
              ),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'removes only specified object, keeps others',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeObjects: {
                testShape.id: testShape,
                testShape2.id: testShape2,
              },
            ),
        act:
            (bloc) =>
                bloc.add(ActiveLayerEvent.objectDeactivated(testShape.id)),
        expect:
            () => [
              ActiveLayerState(
                activeObjects: {testShape2.id: testShape2},
                dragStartPoint: null,
                originalObject: null,
              ),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'does nothing if object id not present and state unchanged',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeObjects: {testShape.id: testShape},
              dragStartPoint: null,
              originalObject: null,
            ),
        act: (bloc) => bloc.add(const ActiveLayerEvent.objectDeactivated(999)),
        expect: () => [],
      );
    });

    group('originalObjectSet event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'sets originalObject',
        build: () => ActiveLayerBloc(),
        act: (bloc) => bloc.add(ActiveLayerEvent.originalObjectSet(testShape)),
        expect: () => [ActiveLayerState(originalObject: testShape)],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'clears originalObject when set to null',
        build: () => ActiveLayerBloc(),
        seed: () => ActiveLayerState(originalObject: testShape),
        act: (bloc) => bloc.add(const ActiveLayerEvent.originalObjectSet(null)),
        expect: () => [const ActiveLayerState(originalObject: null)],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'preserves other state when setting originalObject',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeObjects: {testShape.id: testShape},
              dragStartPoint: const Offset(50, 50),
              activeHandle: ResizeHandle.topLeft,
            ),
        act: (bloc) => bloc.add(ActiveLayerEvent.originalObjectSet(testShape2)),
        expect:
            () => [
              ActiveLayerState(
                activeObjects: {testShape.id: testShape},
                dragStartPoint: const Offset(50, 50),
                activeHandle: ResizeHandle.topLeft,
                originalObject: testShape2,
              ),
            ],
      );
    });

    group('clear event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'clears activeObjects, dragStartPoint, and originalObject',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeObjects: {
                testShape.id: testShape,
                testShape2.id: testShape2,
              },
              dragStartPoint: const Offset(100, 100),
              originalObject: testShape,
              activeHandle: ResizeHandle.bottomRight,
            ),
        act: (bloc) => bloc.add(const ActiveLayerEvent.clear()),
        expect:
            () => [
              // Note: clear does NOT modify activeHandle based on implementation
              const ActiveLayerState(
                activeObjects: {},
                dragStartPoint: null,
                originalObject: null,
              ).copyWith(activeHandle: ResizeHandle.bottomRight),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'emits state on already empty activeObjects',
        build: () => ActiveLayerBloc(),
        act: (bloc) => bloc.add(const ActiveLayerEvent.clear()),
        expect:
            () => [
              const ActiveLayerState(
                activeObjects: {},
                dragStartPoint: null,
                originalObject: null,
              ),
            ],
      );
    });

    group('handleChanged event', () {
      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'sets activeHandle',
        build: () => ActiveLayerBloc(),
        act:
            (bloc) => bloc.add(
              const ActiveLayerEvent.handleChanged(ResizeHandle.topLeft),
            ),
        expect:
            () => [const ActiveLayerState(activeHandle: ResizeHandle.topLeft)],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'clears activeHandle when set to null',
        build: () => ActiveLayerBloc(),
        seed:
            () =>
                const ActiveLayerState(activeHandle: ResizeHandle.bottomRight),
        act: (bloc) => bloc.add(const ActiveLayerEvent.handleChanged(null)),
        expect: () => [const ActiveLayerState(activeHandle: null)],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'changes activeHandle from one to another',
        build: () => ActiveLayerBloc(),
        seed: () => const ActiveLayerState(activeHandle: ResizeHandle.topLeft),
        act:
            (bloc) => bloc.add(
              const ActiveLayerEvent.handleChanged(ResizeHandle.centerRight),
            ),
        expect:
            () => [
              const ActiveLayerState(activeHandle: ResizeHandle.centerRight),
            ],
      );

      blocTest<ActiveLayerBloc, ActiveLayerState>(
        'preserves other state when changing handle',
        build: () => ActiveLayerBloc(),
        seed:
            () => ActiveLayerState(
              activeObjects: {testShape.id: testShape},
              dragStartPoint: const Offset(150, 150),
              originalObject: testShape,
            ),
        act:
            (bloc) => bloc.add(
              const ActiveLayerEvent.handleChanged(ResizeHandle.topCenter),
            ),
        expect:
            () => [
              ActiveLayerState(
                activeObjects: {testShape.id: testShape},
                dragStartPoint: const Offset(150, 150),
                originalObject: testShape,
                activeHandle: ResizeHandle.topCenter,
              ),
            ],
      );
    });
  });
}
