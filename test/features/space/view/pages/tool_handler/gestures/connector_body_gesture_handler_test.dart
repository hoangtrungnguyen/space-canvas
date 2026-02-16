import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/connector_body_gesture_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';

class MockActiveLayerBloc extends MockBloc<ActiveLayerEvent, ActiveLayerState>
    implements ActiveLayerBloc {}

class MockCanvasInteractionMediator extends Mock
    implements CanvasInteractionMediator {}

class FakeActiveLayerEvent extends Fake implements ActiveLayerEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeActiveLayerEvent());
    registerFallbackValue(Offset.zero);
    registerFallbackValue(SelectionFilter.all);
  });

  group('ConnectorBodyGestureHandler', () {
    late ConnectorBodyGestureHandler handler;
    late MockActiveLayerBloc activeBloc;
    late MockCanvasInteractionMediator mediator;
    late TransformationController controller;
    late ConnectorNode testConnector;

    setUp(() {
      handler = ConnectorBodyGestureHandler();
      activeBloc = MockActiveLayerBloc();
      mediator = MockCanvasInteractionMediator();
      controller = TransformationController();

      testConnector = ConnectorNode(
        id: 1,
        startPoint: const Offset(100, 100),
        endPoint: const Offset(200, 200),
        color: 0xFF000000,
        strokeWidth: 1.0,
      );
    });

    tearDown(() {
      controller.dispose();
    });

    GestureEvent createEvent(Offset worldPoint, GestureType type) {
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
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ActiveLayerBloc>.value(value: activeBloc),
              Provider<CanvasInteractionMediator>.value(value: mediator),
            ],
            child: Builder(
              builder: (context) {
                callback(context);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    }

    group('canHandle', () {
      testWidgets('returns true when connector is hit', (tester) async {
        when(
          () => mediator.hitTest(any(), filter: any(named: 'filter')),
        ).thenReturn(testConnector);

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(
              const Offset(150, 150),
              GestureType.tapUp,
            );
            expect(handler.canHandle(event, context), true);
          },
        );
      });

      testWidgets('returns false when nothing is hit', (tester) async {
        when(
          () => mediator.hitTest(any(), filter: any(named: 'filter')),
        ).thenReturn(null);

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(
              const Offset(100, 100),
              GestureType.tapUp,
            );
            expect(handler.canHandle(event, context), false);
          },
        );
      });
    });

    group('doHandle', () {
      testWidgets('selects connector and clears handle on tap', (tester) async {
        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(
              const Offset(150, 150),
              GestureType.tapUp,
            );
            handler.doHandle(event, context);
          },
        );

        verify(
          () =>
              mediator.selectConnectorAt(const Offset(150, 150), isDrag: false),
        ).called(1);

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        expect(captured.length, 1);
        expect(
          captured[0],
          isA<ActiveLayerEvent>().having(
            (e) => (e as dynamic).handle,
            'handle',
            isNull,
          ),
        );
      });

      testWidgets('selects connector and clears handle on pan start', (
        tester,
      ) async {
        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(
              const Offset(150, 150),
              GestureType.panStart,
            );
            handler.doHandle(event, context);
          },
        );

        verify(
          () =>
              mediator.selectConnectorAt(const Offset(150, 150), isDrag: true),
        ).called(1);

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        expect(captured.length, 1);
        expect(
          captured[0],
          isA<ActiveLayerEvent>().having(
            (e) => (e as dynamic).handle,
            'handle',
            isNull,
          ),
        );
      });
    });
  });
}
