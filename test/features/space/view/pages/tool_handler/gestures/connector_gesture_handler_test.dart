import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/connector_gesture_handler.dart';

class MockActiveLayerBloc extends MockBloc<ActiveLayerEvent, ActiveLayerState>
    implements ActiveLayerBloc {}

class MockToolbarBloc extends MockBloc<ToolbarEvent, ToolbarState>
    implements ToolbarBloc {}

class MockCanvasInteractionMediator extends Mock
    implements CanvasInteractionMediator {}

class FakeActiveLayerEvent extends Fake implements ActiveLayerEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeActiveLayerEvent());
    registerFallbackValue(const ToolbarEvent.toDefault());
    registerFallbackValue(const Offset(0, 0));
  });

  group('ConnectorGestureHandler', () {
    late ConnectorGestureHandler handler;
    late MockActiveLayerBloc activeBloc;
    late MockToolbarBloc toolbarBloc;
    late MockCanvasInteractionMediator mediator;
    late TransformationController controller;
    late ConnectorNode testConnector;

    setUp(() {
      handler = ConnectorGestureHandler();
      activeBloc = MockActiveLayerBloc();
      toolbarBloc = MockToolbarBloc();
      mediator = MockCanvasInteractionMediator();
      controller = TransformationController();

      testConnector = ConnectorNode(
        id: 2,
        startPoint: const Offset(300, 300),
        endPoint: const Offset(400, 400),
        strokeWidth: 2,
        color: 0xFF000000,
      );
    });

    tearDown(() {
      controller.dispose();
    });

    GestureEvent createEvent(
      Offset worldPoint, {
      GestureType type = GestureType.tapUp,
    }) {
      return GestureEvent(
        worldPoint: worldPoint,
        localPosition: worldPoint,
        controller: controller,
        type: type,
      );
    }

    Future<void> pumpTestWidget(
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
                BlocProvider<ToolbarBloc>.value(value: toolbarBloc),
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

    group('canHandle', () {
      testWidgets('returns true when hitTest returns a ConnectorNode', (
        tester,
      ) async {
        when(() => mediator.hitTest(any())).thenReturn(testConnector);

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(350, 350));
            expect(handler.canHandle(event, context), true);
          },
        );
      });

      testWidgets('returns false when hitTest returns a ShapeNode', (
        tester,
      ) async {
        final shape = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(100, 100, 100, 100),
          color: 0xFF0000FF,
        );
        when(() => mediator.hitTest(any())).thenReturn(shape);

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(150, 150));
            expect(handler.canHandle(event, context), false);
          },
        );
      });

      testWidgets('returns false when hitTest returns null', (tester) async {
        when(() => mediator.hitTest(any())).thenReturn(null);

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(500, 500));
            expect(handler.canHandle(event, context), false);
          },
        );
      });
    });

    group('doHandle', () {
      testWidgets('switches to selectConnector tool on tap', (tester) async {
        when(() => mediator.hitTest(any())).thenReturn(testConnector);

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(350, 350));
            handler.doHandle(event, context);
          },
        );

        verify(
          () => toolbarBloc.add(
            const ToolbarEvent.selected(SpaceTool.selectConnector),
          ),
        ).called(1);

        verify(
          () =>
              mediator.selectConnectorAt(const Offset(350, 350), isDrag: false),
        ).called(1);

        verify(
          () => activeBloc.add(const ActiveLayerEvent.handleChanged(null)),
        ).called(1);
      });

      testWidgets('uses isDrag: true for panStart events', (tester) async {
        when(() => mediator.hitTest(any())).thenReturn(testConnector);

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(
              const Offset(350, 350),
              type: GestureType.panStart,
            );
            handler.doHandle(event, context);
          },
        );

        verify(
          () =>
              mediator.selectConnectorAt(const Offset(350, 350), isDrag: true),
        ).called(1);
      });
    });
  });
}
