import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/connector_background_gesture_handler.dart';
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

  group('ConnectorBackgroundGestureHandler', () {
    late ConnectorBackgroundGestureHandler handler;
    late MockActiveLayerBloc activeBloc;
    late MockCanvasInteractionMediator mediator;
    late TransformationController controller;

    setUp(() {
      handler = ConnectorBackgroundGestureHandler();
      activeBloc = MockActiveLayerBloc();
      mediator = MockCanvasInteractionMediator();
      controller = TransformationController();
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
      testWidgets('always returns true', (tester) async {
        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(
              const Offset(100, 100),
              GestureType.tapUp,
            );
            expect(handler.canHandle(event, context), true);
          },
        );
      });
    });

    group('doHandle', () {
      testWidgets('deselects connector and clears handle', (tester) async {
        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(
              const Offset(100, 100),
              GestureType.tapUp,
            );
            handler.doHandle(event, context);
          },
        );

        verify(
          () =>
              mediator.selectConnectorAt(const Offset(100, 100), isDrag: false),
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
