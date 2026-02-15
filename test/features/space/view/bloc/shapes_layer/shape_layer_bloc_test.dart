import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/failure.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
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
    late ShapeNode testShape1;
    late ShapeNode testShape2;
    late ShapeNode testShape3;

    setUp(() {
      testShape1 = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 50, 50),
        color: 0xFF0000FF,
        zIndex: 1,
      );

      testShape2 = ShapeNode(
        id: 2,
        type: ShapeType.oval,
        rect: const Rect.fromLTWH(200, 200, 50, 50),
        color: 0xFFFF0000,
        zIndex: 2,
      );

      testShape3 = ShapeNode(
        id: 3,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(
          100,
          100,
          100,
          100,
        ), // Overlaps with testShape1
        color: 0xFF00FF00,
        zIndex: 3, // Higher zIndex
      );

      // Reset mock behavior
      reset(mockSpaceDataService);
    });

    // =========================================================================
    // Initial State
    // =========================================================================
    group('initial state', () {
      test('should have initialize state with empty nodes', () {
        final bloc = ShapeLayerBloc(
          id: 'test-id',
          spaceDataService: mockSpaceDataService,
        );

        expect(bloc.state, isA<ShapeLayerStateInitialize>());
        expect(bloc.state.data.nodes, isEmpty);
        expect(bloc.state.data.selectedNodeId, isNull);

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
            () => mockSpaceDataService.generateInitialNodes(),
          ).thenReturn({testShape1.id: testShape1, testShape2.id: testShape2});
        },
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        act: (bloc) => bloc.add(const ShapeLayerEvent.initialize()),
        expect:
            () => [
              isA<ShapeLayerStateLoading>(),
              isA<ShapeLayerStateSuccess>().having(
                (s) => s.data.nodes.length,
                'nodes count',
                2,
              ),
            ],
        verify: (_) {
          verify(() => mockSpaceDataService.generateInitialNodes()).called(1);
        },
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'emits [loading, failure] when initialize throws exception',
        setUp: () {
          when(
            () => mockSpaceDataService.generateInitialNodes(),
          ).thenThrow(Exception('Failed to load'));
        },
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
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
    group('addNode event', () {
      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should add node to state',
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        act: (bloc) => bloc.add(ShapeLayerEvent.addNode(testShape1)),
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.nodes.containsKey(testShape1.id),
                'contains node',
                true,
              ),
            ],
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should add multiple nodes',
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        act: (bloc) {
          bloc.add(ShapeLayerEvent.addNode(testShape1));
          bloc.add(ShapeLayerEvent.addNode(testShape2));
        },
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.nodes.length,
                'nodes count',
                1,
              ),
              isA<ShapeLayerState>().having(
                (s) => s.data.nodes.length,
                'nodes count',
                2,
              ),
            ],
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should replace node with same id',
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(nodes: {testShape1.id: testShape1}),
            ),
        act: (bloc) {
          final updatedShape = testShape1.copyWith(
            rect: const Rect.fromLTWH(300, 300, 50, 50),
          );
          bloc.add(ShapeLayerEvent.addNode(updatedShape));
        },
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.nodes[testShape1.id]?.rect.left,
                'updated left',
                300.0,
              ),
            ],
      );
    });

    // =========================================================================
    // RemoveObject Event
    // =========================================================================
    group('removeNode event', () {
      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should remove node from state',
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(nodes: {testShape1.id: testShape1}),
            ),
        act: (bloc) => bloc.add(ShapeLayerEvent.removeNode(testShape1.id)),
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.nodes.containsKey(testShape1.id),
                'contains node',
                false,
              ),
            ],
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should handle removing non-existent object gracefully',
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(nodes: {testShape1.id: testShape1}),
            ),
        act: (bloc) => bloc.add(const ShapeLayerEvent.removeNode(999)),
        // No state change emitted since the nodes map is unchanged (freezed equality)
        expect: () => [],
        verify: (bloc) {
          // Verify original node still exists
          expect(bloc.state.data.nodes.containsKey(testShape1.id), isTrue);
        },
      );
    });

    // =========================================================================
    // ObjectSelected Event
    // =========================================================================
    group('nodeSelected event', () {
      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should set selectedNodeId',
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(nodes: {testShape1.id: testShape1}),
            ),
        act: (bloc) => bloc.add(ShapeLayerEvent.nodeSelected(testShape1.id)),
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.selectedNodeId,
                'selectedNodeId',
                testShape1.id,
              ),
            ],
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should clear selection with null',
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(
                nodes: {testShape1.id: testShape1},
                selectedNodeId: testShape1.id,
              ),
            ),
        act: (bloc) => bloc.add(const ShapeLayerEvent.nodeSelected(null)),
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.selectedNodeId,
                'selectedNodeId',
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
        'should select node when point hits',
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(nodes: {testShape1.id: testShape1}),
            ),
        act:
            (bloc) => bloc.add(
              // Point inside testShape1 (100-150, 100-150)
              const ShapeLayerEvent.selectAtPoint(Offset(125, 125)),
            ),
        expect:
            () => [
              isA<ShapeLayerState>().having(
                (s) => s.data.selectedNodeId,
                'selectedNodeId',
                testShape1.id,
              ),
            ],
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should clear selection when point misses all nodes',
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(
                nodes: {testShape1.id: testShape1},
                selectedNodeId: testShape1.id,
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
                (s) => s.data.selectedNodeId,
                'selectedNodeId',
                isNull,
              ),
            ],
      );

      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should select node with highest zIndex when multiple overlap',
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(
                nodes: {
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
                (s) => s.data.selectedNodeId,
                'selectedNodeId',
                testShape3.id, // Higher zIndex wins
              ),
            ],
      );
    });

    // =========================================================================
    // ObjectDragged Event (currently no-op)
    // =========================================================================
    group('nodeDragged event', () {
      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should not emit any state (no-op handler)',
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(nodes: {testShape1.id: testShape1}),
            ),
        act:
            (bloc) => bloc.add(
              ShapeLayerEvent.nodeDragged(
                nodeId: testShape1.id,
                delta: const Offset(10, 10),
              ),
            ),
        expect: () => [], // No state changes
      );
    });

    // =========================================================================
    // UpdateObjects Event
    // =========================================================================
    group('updateNodes event', () {
      blocTest<ShapeLayerBloc, ShapeLayerState>(
        'should update multiple nodes in state',
        build:
            () => ShapeLayerBloc(
              id: 'test-id',
              spaceDataService: mockSpaceDataService,
            ),
        seed:
            () => ShapeLayerState.success(
              data: ShapeLayerData(
                nodes: {testShape1.id: testShape1, testShape2.id: testShape2},
              ),
            ),
        act: (bloc) {
          final updatedShape1 = testShape1.copyWith(
            rect: const Rect.fromLTWH(150, 150, 50, 50),
          );
          final updatedShape2 = testShape2.copyWith(
            rect: const Rect.fromLTWH(250, 250, 50, 50),
          );
          bloc.add(ShapeLayerEvent.updateNodes([updatedShape1, updatedShape2]));
        },
        expect:
            () => [
              isA<ShapeLayerState>()
                  .having(
                    (s) => s.data.nodes[testShape1.id]?.rect.left,
                    'updated node1 left',
                    150.0,
                  )
                  .having(
                    (s) => s.data.nodes[testShape2.id]?.rect.left,
                    'updated node2 left',
                    250.0,
                  ),
            ],
      );
    });
  });
}
