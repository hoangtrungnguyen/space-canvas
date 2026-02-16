import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/resize_handle_gesture_handler.dart';

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
  });

  group('ResizeHandleGestureHandler', () {
    late ResizeHandleGestureHandler handler;
    late MockActiveLayerBloc activeBloc;
    late MockShapeLayerBloc shapeBloc;
    late TransformationController controller;
    late ShapeNode testShape;

    setUp(() {
      handler = ResizeHandleGestureHandler();
      activeBloc = MockActiveLayerBloc();
      shapeBloc = MockShapeLayerBloc();
      controller = TransformationController();

      testShape = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 100, 100),
        color: 0xFF0000FF,
      );
    });

    tearDown(() {
      controller.dispose();
    });

    GestureEvent createEvent(Offset worldPoint) {
      return GestureEvent(
        worldPoint: worldPoint,
        localPosition: worldPoint,
        controller: controller,
        type: GestureType.panStart,
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
      );
    }

    group('canHandle', () {
      testWidgets('returns false when no active nodes', (tester) async {
        when(
          () => activeBloc.state,
        ).thenReturn(const ActiveLayerState(activeNodes: {}));

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(100, 100));
            expect(handler.canHandle(event, context), false);
          },
        );
      });

      testWidgets('returns true when point is near topLeft handle', (
        tester,
      ) async {
        when(
          () => activeBloc.state,
        ).thenReturn(ActiveLayerState(activeNodes: {testShape.id: testShape}));

        await pumpTestWidget(
          tester,
          callback: (context) {
            // topLeft of rect.inflate(4) is (96, 96)
            final event = createEvent(const Offset(100, 100));
            expect(handler.canHandle(event, context), true);
          },
        );
      });

      testWidgets('returns true when point is near bottomRight handle', (
        tester,
      ) async {
        when(
          () => activeBloc.state,
        ).thenReturn(ActiveLayerState(activeNodes: {testShape.id: testShape}));

        await pumpTestWidget(
          tester,
          callback: (context) {
            // bottomRight of rect.inflate(4) is (204, 204)
            final event = createEvent(const Offset(200, 200));
            expect(handler.canHandle(event, context), true);
          },
        );
      });

      testWidgets('returns false when point is in center of node', (
        tester,
      ) async {
        when(
          () => activeBloc.state,
        ).thenReturn(ActiveLayerState(activeNodes: {testShape.id: testShape}));

        await pumpTestWidget(
          tester,
          callback: (context) {
            // Center of rect is (150, 150), far from all handles
            final event = createEvent(const Offset(150, 150));
            expect(handler.canHandle(event, context), false);
          },
        );
      });

      testWidgets('returns false when point is far from all handles', (
        tester,
      ) async {
        when(
          () => activeBloc.state,
        ).thenReturn(ActiveLayerState(activeNodes: {testShape.id: testShape}));

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(500, 500));
            expect(handler.canHandle(event, context), false);
          },
        );
      });

      testWidgets('scales hit radius with canvas zoom', (tester) async {
        // 2x zoom → hit radius = 20.0 / 2.0 = 10.0
        controller.value = Matrix4.diagonal3Values(2.0, 2.0, 1.0);
        when(
          () => activeBloc.state,
        ).thenReturn(ActiveLayerState(activeNodes: {testShape.id: testShape}));

        await pumpTestWidget(
          tester,
          callback: (context) {
            // Point at (115, 100) is ~19 away from topLeft (96, 96)
            // With hit radius of 10, this should NOT hit
            final event = createEvent(const Offset(115, 100));
            expect(handler.canHandle(event, context), false);
          },
        );
      });
    });

    group('doHandle', () {
      testWidgets('sets resize handle and starts interaction', (tester) async {
        when(
          () => activeBloc.state,
        ).thenReturn(ActiveLayerState(activeNodes: {testShape.id: testShape}));

        await pumpTestWidget(
          tester,
          callback: (context) {
            final event = createEvent(const Offset(100, 100));
            handler.doHandle(event, context);
          },
        );

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        expect(captured.length, 2);

        // First event: handleChanged with topLeft
        (captured[0] as ActiveLayerEvent).mapOrNull(
          handleChanged: (e) => expect(e.handle, ResizeHandle.topLeft),
        );

        // Second event: interactionStarted
        (captured[1] as ActiveLayerEvent).mapOrNull(
          interactionStarted: (e) {
            expect(e.node, testShape);
            expect(e.point, const Offset(100, 100));
          },
        );

        // Also verify shapeBloc.removeNode was called
        verify(
          () => shapeBloc.add(any(that: isA<ShapeLayerEvent>())),
        ).called(1);
      });
    });
  });
}
