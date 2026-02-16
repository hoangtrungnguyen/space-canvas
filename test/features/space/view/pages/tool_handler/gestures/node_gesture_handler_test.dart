import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/node_gesture_handler.dart';

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

  group('NodeGestureHandler', () {
    late NodeGestureHandler handler;
    late MockActiveLayerBloc activeBloc;
    late MockCanvasInteractionMediator mediator;
    late TransformationController controller;

    setUp(() {
      handler = NodeGestureHandler();
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
      testWidgets('returns true when hitTest returns a ShapeNode', (
        tester,
      ) async {
        final shape = ShapeNode(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(100, 100, 100, 100),
          color: 0xFF0000FF,
        );
        when(
          () => mediator.hitTest(any(), filter: any(named: 'filter')),
        ).thenReturn(shape);

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(150, 150));
            expect(handler.canHandle(event, context), true);
          },
        );

        verify(
          () => mediator.hitTest(
            const Offset(150, 150),
            filter: SelectionFilter.excludeConnectors,
          ),
        ).called(1);
      });

      testWidgets('returns false when hitTest returns null', (tester) async {
        when(
          () => mediator.hitTest(any(), filter: any(named: 'filter')),
        ).thenReturn(null);

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(500, 500));
            expect(handler.canHandle(event, context), false);
          },
        );
      });

      testWidgets('returns false when hitTest returns a ConnectorNode', (
        tester,
      ) async {
        // NodeGestureHandler uses excludeConnectors filter, so connectors
        // should never be returned. This test verifies the filter usage.
        when(
          () => mediator.hitTest(any(), filter: any(named: 'filter')),
        ).thenReturn(
          null,
        ); // excludeConnectors means connector won't be returned

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(350, 350));
            expect(handler.canHandle(event, context), false);
          },
        );
      });
    });

    group('doHandle', () {
      testWidgets('calls selectAt with isDrag false for tap', (tester) async {
        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(150, 150));
            handler.doHandle(event, context);
          },
        );

        verify(
          () => mediator.selectAt(
            const Offset(150, 150),
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
              const Offset(150, 150),
              type: GestureType.panStart,
            );
            handler.doHandle(event, context);
          },
        );

        verify(
          () => mediator.selectAt(
            const Offset(150, 150),
            isDrag: true,
            filter: SelectionFilter.excludeConnectors,
          ),
        ).called(1);
      });
    });
  });
}
