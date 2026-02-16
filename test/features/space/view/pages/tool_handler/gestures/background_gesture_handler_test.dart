import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/background_gesture_handler.dart';

class MockActiveLayerBloc extends MockBloc<ActiveLayerEvent, ActiveLayerState>
    implements ActiveLayerBloc {}

class MockCanvasInteractionMediator extends Mock
    implements CanvasInteractionMediator {}

class FakeActiveLayerEvent extends Fake implements ActiveLayerEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeActiveLayerEvent());
    registerFallbackValue(const Offset(0, 0));
    registerFallbackValue(SelectionFilter.all);
  });

  group('BackgroundGestureHandler', () {
    late BackgroundGestureHandler handler;
    late MockActiveLayerBloc activeBloc;
    late MockCanvasInteractionMediator mediator;
    late TransformationController controller;

    setUp(() {
      handler = BackgroundGestureHandler();
      activeBloc = MockActiveLayerBloc();
      mediator = MockCanvasInteractionMediator();
      controller = TransformationController();
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
      testWidgets('always returns true', (tester) async {
        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(0, 0));
            expect(handler.canHandle(event, context), true);
          },
        );
      });

      testWidgets('returns true for any point', (tester) async {
        await pumpTestWidget(
          tester,
          callback: (context) {
            expect(
              handler.canHandle(createEvent(const Offset(999, 999)), context),
              true,
            );
            expect(
              handler.canHandle(createEvent(const Offset(-100, -100)), context),
              true,
            );
          },
        );
      });
    });

    group('doHandle', () {
      testWidgets('calls selectAt with isDrag false for tap', (tester) async {
        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(500, 500));
            handler.doHandle(event, context);
          },
        );

        verify(
          () => mediator.selectAt(
            const Offset(500, 500),
            isDrag: false,
            filter: SelectionFilter.excludeConnectors,
          ),
        ).called(1);

        verify(
          () => activeBloc.add(const ActiveLayerEvent.handleChanged(null)),
        ).called(1);
      });

      testWidgets('calls selectAt with isDrag true for panStart', (
        tester,
      ) async {
        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(
              const Offset(500, 500),
              type: GestureType.panStart,
            );
            handler.doHandle(event, context);
          },
        );

        verify(
          () => mediator.selectAt(
            const Offset(500, 500),
            isDrag: true,
            filter: SelectionFilter.excludeConnectors,
          ),
        ).called(1);
      });

      testWidgets('clears resize handle', (tester) async {
        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(0, 0));
            handler.doHandle(event, context);
          },
        );

        verify(
          () => activeBloc.add(const ActiveLayerEvent.handleChanged(null)),
        ).called(1);
      });
    });
  });
}
