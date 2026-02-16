import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_event.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/gestures/gesture_chain_builder.dart';

/// A test handler that always accepts events.
class AcceptingHandler extends GestureHandler {
  int handleCount = 0;
  GestureEvent? lastEvent;

  @override
  bool canHandle(GestureEvent event, BuildContext context) => true;

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    handleCount++;
    lastEvent = event;
  }
}

/// A test handler that always rejects events.
class RejectingHandler extends GestureHandler {
  int canHandleCount = 0;

  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    canHandleCount++;
    return false;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    fail('doHandle should not be called on a rejecting handler');
  }
}

/// A handler that accepts only panStart events.
class PanStartOnlyHandler extends GestureHandler {
  int handleCount = 0;

  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    return event.type == GestureType.panStart;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    handleCount++;
  }
}

void main() {
  late TransformationController controller;

  setUp(() {
    controller = TransformationController();
  });

  tearDown(() {
    controller.dispose();
  });

  GestureEvent createEvent({GestureType type = GestureType.tapUp}) {
    return GestureEvent(
      worldPoint: const Offset(100, 100),
      localPosition: const Offset(100, 100),
      controller: controller,
      type: type,
    );
  }

  group('GestureHandler', () {
    testWidgets('handle returns true when handler accepts', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final handler = AcceptingHandler();
              final result = handler.handle(createEvent(), context);
              expect(result, true);
              expect(handler.handleCount, 1);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('handle returns false when handler rejects and no next', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final handler = RejectingHandler();
              final result = handler.handle(createEvent(), context);
              expect(result, false);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('handle delegates to next handler when rejected', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final first = RejectingHandler();
              final second = AcceptingHandler();
              first.setNext(second);

              final result = first.handle(createEvent(), context);

              expect(result, true);
              expect(first.canHandleCount, 1);
              expect(second.handleCount, 1);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('handle stops at first accepting handler', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final first = AcceptingHandler();
              final second = AcceptingHandler();
              first.setNext(second);

              first.handle(createEvent(), context);

              expect(first.handleCount, 1);
              expect(second.handleCount, 0); // Should NOT be reached
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('chain of rejecting handlers returns false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final first = RejectingHandler();
              final second = RejectingHandler();
              final third = RejectingHandler();
              first.setNext(second);
              second.setNext(third);

              final result = first.handle(createEvent(), context);
              expect(result, false);
              expect(first.canHandleCount, 1);
              expect(second.canHandleCount, 1);
              expect(third.canHandleCount, 1);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('conditional handler processes correct event type', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final panHandler = PanStartOnlyHandler();
              final fallback = AcceptingHandler();
              panHandler.setNext(fallback);

              // PanStart should be handled by panHandler
              panHandler.handle(
                createEvent(type: GestureType.panStart),
                context,
              );
              expect(panHandler.handleCount, 1);
              expect(fallback.handleCount, 0);

              // TapUp should fall through to fallback
              panHandler.handle(createEvent(type: GestureType.tapUp), context);
              expect(panHandler.handleCount, 1); // Unchanged
              expect(fallback.handleCount, 1);
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });

  group('GestureChainBuilder', () {
    test('throws StateError when building empty chain', () {
      expect(() => GestureChainBuilder().build(), throwsStateError);
    });

    testWidgets('builds chain with correct order', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final rejecting1 = RejectingHandler();
              final rejecting2 = RejectingHandler();
              final accepting = AcceptingHandler();

              final chain =
                  GestureChainBuilder()
                      .addHandler(rejecting1)
                      .addHandler(rejecting2)
                      .addHandler(accepting)
                      .build();

              chain.handle(createEvent(), context);

              expect(rejecting1.canHandleCount, 1);
              expect(rejecting2.canHandleCount, 1);
              expect(accepting.handleCount, 1);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('single handler chain works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final accepting = AcceptingHandler();
              final chain = GestureChainBuilder().addHandler(accepting).build();

              final result = chain.handle(createEvent(), context);

              expect(result, true);
              expect(accepting.handleCount, 1);
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });

  group('GestureEvent', () {
    test('tapUp factory creates event with correct type', () {
      final details = TapUpDetails(
        globalPosition: const Offset(200, 200),
        localPosition: const Offset(100, 100),
        kind: PointerDeviceKind.touch,
      );
      final event = GestureEvent.tapUp(details, controller);

      expect(event.type, GestureType.tapUp);
      expect(event.localPosition, const Offset(100, 100));
    });

    test('panStart factory creates event with correct type', () {
      final details = DragStartDetails(
        globalPosition: Offset(200, 200),
        localPosition: Offset(100, 100),
      );
      final event = GestureEvent.panStart(details, controller);

      expect(event.type, GestureType.panStart);
      expect(event.localPosition, const Offset(100, 100));
    });

    test('panEnd factory creates event with zero positions', () {
      final details = DragEndDetails();
      final event = GestureEvent.panEnd(details, controller);

      expect(event.type, GestureType.panEnd);
      expect(event.worldPoint, Offset.zero);
      expect(event.localPosition, Offset.zero);
    });

    test('scale returns canvas zoom level', () {
      controller.value = Matrix4.diagonal3Values(2.5, 2.5, 1.0);
      final event = GestureEvent(
        worldPoint: Offset.zero,
        localPosition: Offset.zero,
        controller: controller,
        type: GestureType.tapUp,
      );

      expect(event.scale, 2.5);
    });
  });
}
