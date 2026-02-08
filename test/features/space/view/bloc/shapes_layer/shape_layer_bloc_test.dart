import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/failure.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceDataService extends Mock implements SpaceDataService {}

void main() {
  late MockSpaceDataService mockSpaceDataService;

  setUpAll(() {
    // Register mock in GetIt
    mockSpaceDataService = MockSpaceDataService();
    if (getIt.isRegistered<SpaceDataService>()) {
      getIt.unregister<SpaceDataService>();
    }
    getIt.registerSingleton<SpaceDataService>(mockSpaceDataService);
  });

  tearDownAll(() {
    if (getIt.isRegistered<SpaceDataService>()) {
      getIt.unregister<SpaceDataService>();
    }
  });

  group('ShapeLayerBloc', () {
    late ShapeObject testShape1;
    late ShapeObject testShape2;
    late ShapeObject testShape3;

    setUp(() {
      testShape1 = ShapeObject(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 50, 50),
        paint: Paint()..color = const Color(0xFF0000FF),
        zIndex: 1,
      );

      testShape2 = ShapeObject(
        id: 2,
        type: ShapeType.oval,
        rect: const Rect.fromLTWH(200, 200, 50, 50),
        paint: Paint()..color = const Color(0xFFFF0000),
        zIndex: 2,
      );

      testShape3 = ShapeObject(
        id: 3,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(
          100,
          100,
          100,
          100,
        ), // Overlaps with testShape1
        paint: Paint()..color = const Color(0xFF00FF00),
        zIndex: 3, // Higher zIndex
      );

      // Reset mock behavior
      reset(mockSpaceDataService);
    });

    // =========================================================================
    // Initial State
    // =========================================================================
    group('initial state', () {
      test('should have initialize state with empty objects', () {
        final bloc = ShapeLayerBloc('test-id');

        expect(bloc.state, isA<ShapeLayerStateInitialize>());
        expect(bloc.state.data.objects, isEmpty);
        expect(bloc.state.data.selectedObjectId, isNull);

        bloc.close();
      });
    });

    // =========================================================================
    // Initialize Event
    // =========================================================================
    group('initialize event', () {
      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'emits [loading, success] when initialize succeeds',
        setUp: () {
          when(
            () => mockSpaceDataService.generateInitialObjects(),
          ).thenReturn({testShape1.id: testShape1, testShape2.id: testShape2});
        },
        build: () => ShapeLayerBloc('test-id'),
        act: (bloc) => bloc.add(const ShapeLayerEvent.initialize()),
        expect:
            () => [
              isA<ShapeLayerStateLoading>(),
              isA<ShapeLayerStateSuccess>().having(
                (s) => s.data.objects.length,
                'objects count',
                2,
              ),
            ],
        verify: (_) {
          verify(() => mockSpaceDataService.generateInitialObjects()).called(1);
        },
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'emits [loading, failure] when initialize throws exception',
        setUp: () {
          when(
            () => mockSpaceDataService.generateInitialObjects(),
          ).thenThrow(Exception('Failed to load'));
        },
        build: () => ShapeLayerBloc('test-id'),
        act: (bloc) => bloc.add(const ShapeLayerEvent.initialize()),
        expect:
            () => [
              isA<ShapeLayerStateLoading>(),
              isA<ShapeLayerStateFailure>().having(
                (s) => (s.failure as Failure).message,
                'failure message',
                contains('Failed to load'),
              ),
            ],
      );
    });

    // =========================================================================
    // AddObject Event
    // =========================================================================
    group('addObject event', () {
      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should add object to state',
        build: () => ShapeLayerBloc('test-id'),
        act: (bloc) => bloc.add(ShapeLayerEvent.addObject(testShape1)),
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.objects.containsKey(testShape1.id),
                'contains object',
                true,
              ),
            ],
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should add multiple objects',
        build: () => ShapeLayerBloc('test-id'),
        act: (bloc) {
          bloc.add(ShapeLayerEvent.addObject(testShape1));
          bloc.add(ShapeLayerEvent.addObject(testShape2));
        },
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.objects.length,
                'objects count',
                1,
              ),
              isA<ShapeLayerState>().having(
                (s) => s.data.objects.length,
                'objects count',
                2,
              ),
            ],
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should replace object with same id',
        build: () => ShapeLayerBloc('test-id'),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(objects: {testShape1.id: testShape1}),
            ),
        act: (bloc) {
          final updatedShape = testShape1.copyWith(
            rect: const Rect.fromLTWH(300, 300, 50, 50),
          );
          bloc.add(ShapeLayerEvent.addObject(updatedShape));
        },
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.objects[testShape1.id]?.rect.left,
                'updated left',
                300.0,
              ),
            ],
      );
    });

    // =========================================================================
    // RemoveObject Event
    // =========================================================================
    group('removeObject event', () {
      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should remove object from state',
        build: () => ShapeLayerBloc('test-id'),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(objects: {testShape1.id: testShape1}),
            ),
        act: (bloc) => bloc.add(ShapeLayerEvent.removeObject(testShape1.id)),
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.objects.containsKey(testShape1.id),
                'contains object',
                false,
              ),
            ],
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should handle removing non-existent object gracefully',
        build: () => ShapeLayerBloc('test-id'),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(objects: {testShape1.id: testShape1}),
            ),
        act: (bloc) => bloc.add(const ShapeLayerEvent.removeObject(999)),
        // No state change emitted since the objects map is unchanged (freezed equality)
        expect: () => [],
        verify: (bloc) {
          // Verify original object still exists
          expect(bloc.state.data.objects.containsKey(testShape1.id), isTrue);
        },
      );
    });

    // =========================================================================
    // ObjectSelected Event
    // =========================================================================
    group('objectSelected event', () {
      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should set selectedObjectId',
        build: () => ShapeLayerBloc('test-id'),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(objects: {testShape1.id: testShape1}),
            ),
        act: (bloc) => bloc.add(ShapeLayerEvent.objectSelected(testShape1.id)),
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.selectedObjectId,
                'selectedObjectId',
                testShape1.id,
              ),
            ],
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should clear selection with null',
        build: () => ShapeLayerBloc('test-id'),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(
                objects: {testShape1.id: testShape1},
                selectedObjectId: testShape1.id,
              ),
            ),
        act: (bloc) => bloc.add(const ShapeLayerEvent.objectSelected(null)),
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.selectedObjectId,
                'selectedObjectId',
                isNull,
              ),
            ],
      );
    });

    // =========================================================================
    // SelectAtPoint Event
    // =========================================================================
    group('selectAtPoint event', () {
      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should select object when point hits',
        build: () => ShapeLayerBloc('test-id'),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(objects: {testShape1.id: testShape1}),
            ),
        act:
            (bloc) => bloc.add(
              // Point inside testShape1 (100-150, 100-150)
              const ShapeLayerEvent.selectAtPoint(Offset(125, 125)),
            ),
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.selectedObjectId,
                'selectedObjectId',
                testShape1.id,
              ),
            ],
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should clear selection when point misses all objects',
        build: () => ShapeLayerBloc('test-id'),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(
                objects: {testShape1.id: testShape1},
                selectedObjectId: testShape1.id,
              ),
            ),
        act:
            (bloc) => bloc.add(
              // Point outside all shapes
              const ShapeLayerEvent.selectAtPoint(Offset(500, 500)),
            ),
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.selectedObjectId,
                'selectedObjectId',
                isNull,
              ),
            ],
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should select object with highest zIndex when multiple overlap',
        build: () => ShapeLayerBloc('test-id'),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(
                objects: {
                  testShape1.id: testShape1, // zIndex 1, rect (100,100,50,50)
                  testShape3.id:
                      testShape3, // zIndex 3, rect (100,100,100,100) - overlaps
                },
              ),
            ),
        act:
            (bloc) => bloc.add(
              // Point hits both shapes
              const ShapeLayerEvent.selectAtPoint(Offset(125, 125)),
            ),
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.selectedObjectId,
                'selectedObjectId',
                testShape3.id, // Higher zIndex wins
              ),
            ],
      );
    });

    // =========================================================================
    // ObjectDragged Event (currently no-op)
    // =========================================================================
    group('objectDragged event', () {
      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should not emit any state (no-op handler)',
        build: () => ShapeLayerBloc('test-id'),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(objects: {testShape1.id: testShape1}),
            ),
        act:
            (bloc) => bloc.add(
              ShapeLayerEvent.objectDragged(
                objectId: testShape1.id,
                delta: const Offset(10, 10),
              ),
            ),
        expect: () => [], // No state changes
      );
    });

    // =========================================================================
    // UpdateObjects Event
    // =========================================================================
    group('updateObjects event', () {
      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should update multiple objects in state',
        build: () => ShapeLayerBloc('test-id'),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(
                objects: {testShape1.id: testShape1, testShape2.id: testShape2},
              ),
            ),
        act: (bloc) {
          final updatedShape1 = testShape1.copyWith(
            rect: const Rect.fromLTWH(150, 150, 50, 50),
          );
          final updatedShape2 = testShape2.copyWith(
            rect: const Rect.fromLTWH(250, 250, 50, 50),
          );
          bloc.add(
            ShapeLayerEvent.updateObjects([updatedShape1, updatedShape2]),
          );
        },
        expect:
            () => [
              isA<ShapeLayerState>()
                  .having(
                    (s) => s.data.objects[testShape1.id]?.rect.left,
                    'updated shape1 left',
                    150.0,
                  )
                  .having(
                    (s) => s.data.objects[testShape2.id]?.rect.left,
                    'updated shape2 left',
                    250.0,
                  ),
            ],
      );
    });
  });
}
