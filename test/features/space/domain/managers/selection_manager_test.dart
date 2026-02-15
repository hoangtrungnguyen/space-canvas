import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:ideascape/features/space/domain/managers/selection_manager.dart';
import 'package:ideascape/features/space/domain/managers/interaction_state_manager.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

import 'package:ideascape/features/space/domain/models/selection_filter.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';

class MockActiveLayerBloc extends MockBloc<ActiveLayerEvent, ActiveLayerState>
    implements ActiveLayerBloc {}

class MockShapeLayerBloc extends MockBloc<ShapeLayerEvent, ShapeLayerState>
    implements ShapeLayerBloc {}

class MockToolbarBloc extends MockBloc<ToolbarEvent, ToolbarState>
    implements ToolbarBloc {}

class MockInteractionStateManager extends Mock
    implements InteractionStateManager {}

class FakeActiveLayerEvent extends Fake implements ActiveLayerEvent {}

class FakeShapeLayerEvent extends Fake implements ShapeLayerEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeActiveLayerEvent());
    registerFallbackValue(FakeShapeLayerEvent());
    registerFallbackValue(const ToolbarEvent.selected(SpaceTool.select));
  });

  group('SelectionManager', () {
    late SelectionManager manager;
    late MockActiveLayerBloc activeBloc;
    late MockShapeLayerBloc shapeBloc;
    late MockInteractionStateManager interactionManager;
    late MockToolbarBloc toolbarBloc;

    setUp(() {
      activeBloc = MockActiveLayerBloc();
      shapeBloc = MockShapeLayerBloc();
      interactionManager = MockInteractionStateManager();
      toolbarBloc = MockToolbarBloc();
      manager = SelectionManager(
        activeBloc: activeBloc,
        shapeBloc: shapeBloc,
        interactionManager: interactionManager,
        toolbarBloc: toolbarBloc,
      );
    });

    test('selectAt with no active node and hit on shape layer node', () {
      final node = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
        zIndex: 1,
      );

      when(() => activeBloc.state).thenReturn(const ActiveLayerState());
      when(() => shapeBloc.state).thenReturn(
        ShapeLayerState.success(data: ShapeLayerData(nodes: {1: node})),
      );

      // Hit at (50, 50) which is inside the rect
      manager.selectAt(const Offset(50, 50), isDrag: false);

      verify(
        () => activeBloc.add(any(that: isA<ActiveLayerEvent>())),
      ).called(2);
      // originalNodeSet
      // interactionStarted

      verify(
        () => toolbarBloc.add(const ToolbarEvent.selected(SpaceTool.select)),
      ).called(1);
    });

    test('selectAt with active node hit (isDrag=true)', () {
      final node = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
      );

      when(
        () => activeBloc.state,
      ).thenReturn(ActiveLayerState(activeNodes: {1: node}));

      manager.selectAt(const Offset(50, 50), isDrag: true);

      verify(
        () => activeBloc.add(any(that: isA<ActiveLayerEvent>())),
      ).called(2);
      // originalNodeSet
      // interactionStarted

      verifyNever(() => interactionManager.commitAndDeactivate());
    });

    test('selectAt with active node NOT hit (deselects)', () {
      final node = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
      );

      when(
        () => activeBloc.state,
      ).thenReturn(ActiveLayerState(activeNodes: {1: node}));
      when(() => shapeBloc.state).thenReturn(
        ShapeLayerState.success(data: const ShapeLayerData(nodes: {})),
      );

      // Hit outside
      manager.selectAt(const Offset(200, 200), isDrag: false);

      verify(() => interactionManager.commitAndDeactivate()).called(1);
    });

    test('selects topmost node based on z-index', () {
      final node1 = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
        zIndex: 1,
      );
      final node2 = ShapeNode(
        id: 2,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
        zIndex: 2,
      );

      when(() => activeBloc.state).thenReturn(const ActiveLayerState());
      when(() => shapeBloc.state).thenReturn(
        ShapeLayerState.success(
          data: ShapeLayerData(nodes: {1: node1, 2: node2}),
        ),
      );

      manager.selectAt(const Offset(50, 50), isDrag: false);

      // Should select obj2 because higher zIndex
      final captured = verify(() => activeBloc.add(captureAny())).captured;
      // Filter for interactionStarted
      final event = captured.firstWhere(
        (e) =>
            e is ActiveLayerEvent &&
            e.maybeMap(interactionStarted: (_) => true, orElse: () => false),
      );

      (event as ActiveLayerEvent).maybeMap(
        interactionStarted: (e) {
          expect(e.node.id, 2);
        },
        orElse: () => fail('Expected interactionStarted event'),
      );
    });
    test('selectAt with excludeConnectors filter should ignore connectors', () {
      final connector = ConnectorNode(
        id: 3,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        strokeWidth: 10.0,
        color: 0xFF000000,
      );

      when(() => activeBloc.state).thenReturn(const ActiveLayerState());
      when(() => shapeBloc.state).thenReturn(
        ShapeLayerState.success(data: ShapeLayerData(nodes: {3: connector})),
      );

      // Hit the connector
      manager.selectAt(
        const Offset(50, 50),
        isDrag: false,
        filter: SelectionFilter.excludeConnectors,
      );

      // Should NOT select, but should reset selection
      verifyNever(() => interactionManager.commitAndDeactivate());
      verify(
        () => activeBloc.add(const ActiveLayerEvent.originalNodeSet(null)),
      ).called(1);
      verify(
        () => shapeBloc.add(const ShapeLayerEvent.nodeSelected(null)),
      ).called(1);
    });

    test('selectAt with connectorsOnly filter should ignore shapes', () {
      final shape = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
      );

      when(() => activeBloc.state).thenReturn(const ActiveLayerState());
      when(() => shapeBloc.state).thenReturn(
        ShapeLayerState.success(data: ShapeLayerData(nodes: {1: shape})),
      );

      // Hit the shape
      manager.selectAt(
        const Offset(50, 50),
        isDrag: false,
        filter: SelectionFilter.connectorsOnly,
      );

      // Should NOT select, but should reset selection
      verifyNever(() => interactionManager.commitAndDeactivate());
      verify(
        () => activeBloc.add(const ActiveLayerEvent.originalNodeSet(null)),
      ).called(1);
      verify(
        () => shapeBloc.add(const ShapeLayerEvent.nodeSelected(null)),
      ).called(1);
    });

    test('selectAt with connectorsOnly filter should select connectors', () {
      final connector = ConnectorNode(
        id: 3,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        strokeWidth: 10.0,
        color: 0xFF000000,
      );

      when(() => activeBloc.state).thenReturn(const ActiveLayerState());
      when(() => shapeBloc.state).thenReturn(
        ShapeLayerState.success(data: ShapeLayerData(nodes: {3: connector})),
      );

      // Hit the connector
      manager.selectAt(
        const Offset(50, 50),
        isDrag: false,
        filter: SelectionFilter.connectorsOnly,
      );

      // Should select
      verify(
        () => activeBloc.add(
          ActiveLayerEvent.interactionStarted(
            node: connector,
            point: const Offset(50, 50),
          ),
        ),
      ).called(1);
    });

    test('selectConnectorAt delegates with connectorsOnly filter', () {
      final connector = ConnectorNode(
        id: 3,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        strokeWidth: 10.0,
        color: 0xFF000000,
      );

      when(() => activeBloc.state).thenReturn(const ActiveLayerState());
      when(() => shapeBloc.state).thenReturn(
        ShapeLayerState.success(data: ShapeLayerData(nodes: {3: connector})),
      );

      // Hit the connector using selectConnectorAt
      manager.selectConnectorAt(const Offset(50, 50), isDrag: false);

      // Should select
      verify(
        () => activeBloc.add(
          ActiveLayerEvent.interactionStarted(
            node: connector,
            point: const Offset(50, 50),
          ),
        ),
      ).called(1);
    });

    group('hitTest', () {
      test('returns active node if hit', () {
        final node = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          color: 0xFF000000,
        );

        when(
          () => activeBloc.state,
        ).thenReturn(ActiveLayerState(activeNodes: {1: node}));

        final result = manager.hitTest(const Offset(50, 50));
        expect(result, node);
      });

      test('returns active node if hit (connectorsOnly)', () {
        final node = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          color: 0xFF000000,
        );

        when(
          () => activeBloc.state,
        ).thenReturn(ActiveLayerState(activeNodes: {1: node}));
        when(() => shapeBloc.state).thenReturn(
          ShapeLayerState.success(data: const ShapeLayerData(nodes: {})),
        );

        final result = manager.hitTest(
          const Offset(50, 50),
          filter: SelectionFilter.connectorsOnly,
        );
        expect(result, isNull);
      });

      test('returns shape layer node if hit', () {
        final node = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          color: 0xFF000000,
        );

        when(() => activeBloc.state).thenReturn(const ActiveLayerState());
        when(() => shapeBloc.state).thenReturn(
          ShapeLayerState.success(data: ShapeLayerData(nodes: {1: node})),
        );

        final result = manager.hitTest(const Offset(50, 50));
        expect(result, node);
      });

      test('returns topmost shape layer node if multiple hit', () {
        final node1 = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          color: 0xFF000000,
          zIndex: 1,
        );
        final node2 = ShapeNode(
          id: 2,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          color: 0xFF000000,
          zIndex: 2,
        );

        when(() => activeBloc.state).thenReturn(const ActiveLayerState());
        when(() => shapeBloc.state).thenReturn(
          ShapeLayerState.success(
            data: ShapeLayerData(nodes: {1: node1, 2: node2}),
          ),
        );

        final result = manager.hitTest(const Offset(50, 50));
        expect(result, node2);
      });

      test('returns null if nothing hit', () {
        when(() => activeBloc.state).thenReturn(const ActiveLayerState());
        when(() => shapeBloc.state).thenReturn(
          ShapeLayerState.success(data: const ShapeLayerData(nodes: {})),
        );

        final result = manager.hitTest(const Offset(50, 50));
        expect(result, isNull);
      });
    });
  });
}
