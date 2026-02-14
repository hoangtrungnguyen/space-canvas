import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/select_connector_tool_handler.dart';

class MockActiveLayerBloc extends MockBloc<ActiveLayerEvent, ActiveLayerState>
    implements ActiveLayerBloc {}

class MockShapeLayerBloc extends MockBloc<ShapeLayerEvent, ShapeLayerState>
    implements ShapeLayerBloc {}

class MockCanvasInteractionMediator extends Mock
    implements CanvasInteractionMediator {}

class FakeActiveLayerEvent extends Fake implements ActiveLayerEvent {}

class FakeShapeLayerEvent extends Fake implements ShapeLayerEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeActiveLayerEvent());
    registerFallbackValue(FakeShapeLayerEvent());
    registerFallbackValue(const Offset(0, 0));
  });

  group('SelectConnectorToolHandler', () {
    late MockActiveLayerBloc activeBloc;
    late MockShapeLayerBloc shapeBloc;
    late MockCanvasInteractionMediator mediator;
    late TransformationController controller;
    late ConnectorNode testConnector;

    setUp(() {
      activeBloc = MockActiveLayerBloc();
      shapeBloc = MockShapeLayerBloc();
      mediator = MockCanvasInteractionMediator();
      controller = TransformationController();

      testConnector = ConnectorNode(
        id: 1,
        startPoint: const Offset(100, 100),
        endPoint: const Offset(200, 200),
        strokeWidth: 2,
        color: 0xFF000000,
      );
    });

    tearDown(() {
      controller.dispose();
    });

    void setupActiveState({
      Map<int, Node>? objects,
      ResizeHandle? handle,
      Offset? startPoint,
      Node? originalNode,
    }) {
      when(() => activeBloc.state).thenReturn(
        ActiveLayerState(
          activeNodes: objects ?? {testConnector.id: testConnector},
          resizeHandle: handle,
          dragStartPoint: startPoint,
          originalNode: originalNode ?? testConnector,
        ),
      );
    }

    void setupShapeState() {
      when(
        () => shapeBloc.state,
      ).thenReturn(ShapeLayerState.initialize(data: const ShapeLayerData()));
    }

    Future<void> pumpHandlerWidget(
      WidgetTester tester, {
      required void Function(BuildContext) callback,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<CanvasInteractionMediator>.value(
                value: mediator,
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider<ActiveLayerBloc>.value(value: activeBloc),
                BlocProvider<ShapeLayerBloc>.value(value: shapeBloc),
              ],
              child: Builder(
                builder: (context) {
                  callback(context);
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('onTapUp calls mediator.selectAt with connectorsOnly', (
      tester,
    ) async {
      setupActiveState();
      setupShapeState();

      await pumpHandlerWidget(
        tester,
        callback: (context) {
          const SelectConnectorToolHandler().onTapUp(
            TapUpDetails(
              globalPosition: const Offset(100, 100),
              localPosition: const Offset(100, 100),
              kind: PointerDeviceKind.touch,
            ),
            context,
            controller,
          );
        },
      );

      verify(
        () => mediator.selectConnectorAt(const Offset(100, 100), isDrag: false),
      ).called(1);
    });

    testWidgets('onPanStart calls mediator.selectAt with connectorsOnly', (
      tester,
    ) async {
      setupActiveState();
      setupShapeState();

      await pumpHandlerWidget(
        tester,
        callback: (context) {
          const SelectConnectorToolHandler().onPanStart(
            DragStartDetails(
              globalPosition: const Offset(100, 100),
              localPosition: const Offset(100, 100),
            ),
            context,
            controller,
          );
        },
      );

      // Assuming clicking on existing selected object doesn't trigger handle logic for connectors yet
      // In implementation, we loop through activeNodes.
      // But verify call logic depends on what happened.

      // If we clicked on something, it might select or drag.
      // But let's verify selectAt is called if no handle is hit (Connectors usually don't have handles in current imp).

      // My implementation of `onPanStart` checks handles first.
      // `_getHitHandle` currently checks standard 8 handles.
      // `ConnectorNode` bounds (rect) might be small or large depending on implementation.
      // But since we didn't implement specialized handles for connectors in `onPanStart`,
      // it might fall through to `selectAt` unless we hit a standard handle.

      // Let's verify `selectAt` is called with correct filter.
      verify(
        () => mediator.selectConnectorAt(const Offset(100, 100), isDrag: true),
      ).called(1);
    });

    testWidgets(
      'onPanUpdate calls mediator.dragActiveConnector when dragging',
      (tester) async {
        const startPoint = Offset(100, 100);
        setupActiveState(
          objects: {testConnector.id: testConnector},
          startPoint: startPoint,
        );
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            const SelectConnectorToolHandler().onPanUpdate(
              DragUpdateDetails(
                globalPosition: const Offset(110, 110),
                localPosition: const Offset(110, 110),
                delta: const Offset(10, 10),
              ),
              context,
              controller,
            );
          },
        );

        verify(
          () => mediator.dragActiveConnector(
            const Offset(110, 110),
            const Offset(10, 10),
          ),
        ).called(1);
      },
    );
  });
}
