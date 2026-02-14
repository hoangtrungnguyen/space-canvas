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
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/resize_tool_handler.dart';

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

  group('ResizeToolHandler', () {
    late MockActiveLayerBloc activeBloc;
    late MockShapeLayerBloc shapeBloc;
    late MockCanvasInteractionMediator mediator;
    late TransformationController controller;
    late ShapeNode testShape;

    setUp(() {
      activeBloc = MockActiveLayerBloc();
      shapeBloc = MockShapeLayerBloc();
      mediator = MockCanvasInteractionMediator();
      controller = TransformationController();

      testShape = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 100, 100),
        paint: Paint()..color = const Color(0xFF0000FF),
      );
    });

    Future<void> pumpResizeHandlerWidget(
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

    group('constructor', () {
      test('can be instantiated', () {
        final handler = ResizeToolHandler();
        expect(handler, isA<ResizeToolHandler>());
      });
    });

    group('onTapUp', () {
      testWidgets('should do nothing (no crash)', (tester) async {
        await pumpResizeHandlerWidget(
          tester,
          callback: (context) {
            const ResizeToolHandler().onTapUp(
              TapUpDetails(kind: PointerDeviceKind.touch),
              context,
              controller,
            );
          },
        );
        // Verify no interactions with blocs/mediator
        verifyZeroInteractions(activeBloc);
        verifyZeroInteractions(shapeBloc);
        verifyZeroInteractions(mediator);
      });
    });

    group('onPanStart', () {
      testWidgets('should do nothing (no crash)', (tester) async {
        await pumpResizeHandlerWidget(
          tester,
          callback: (context) {
            const ResizeToolHandler().onPanStart(
              DragStartDetails(),
              context,
              controller,
            );
          },
        );
        verifyZeroInteractions(activeBloc);
        verifyZeroInteractions(shapeBloc);
        verifyZeroInteractions(mediator);
      });
    });

    group('onPanUpdate', () {
      testWidgets('should resize object when handle and startPoint are set', (
        tester,
      ) async {
        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(
            activeNodes: {testShape.id: testShape},
            resizeHandle: ResizeHandle.bottomRight,
            dragStartPoint: const Offset(200, 200),
            originalNode: testShape,
          ),
        );

        await pumpResizeHandlerWidget(
          tester,
          callback: (context) {
            const ResizeToolHandler().onPanUpdate(
              DragUpdateDetails(
                globalPosition: const Offset(220, 220),
                localPosition: const Offset(220, 220),
              ),
              context,
              controller,
            );
          },
        );

        final captured =
            verify(
              () => activeBloc.add(captureAny(that: isA<ActiveLayerEvent>())),
            ).captured;

        expect(captured.last, isA<ActiveLayerEvent>());
      });

      testWidgets('should not resize when no active handle', (tester) async {
        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(
            activeNodes: {testShape.id: testShape},
            resizeHandle: null,
            dragStartPoint: const Offset(200, 200),
            originalNode: testShape,
          ),
        );

        await pumpResizeHandlerWidget(
          tester,
          callback: (context) {
            const ResizeToolHandler().onPanUpdate(
              DragUpdateDetails(
                globalPosition: const Offset(220, 220),
                localPosition: const Offset(220, 220),
              ),
              context,
              controller,
            );
          },
        );

        verifyNever(() => activeBloc.add(any(that: isA<ActiveLayerEvent>())));
      });

      testWidgets('should not resize when no active objects', (tester) async {
        when(() => activeBloc.state).thenReturn(
          const ActiveLayerState(
            activeNodes: {},
            resizeHandle: ResizeHandle.bottomRight,
            dragStartPoint: Offset(200, 200),
            originalNode: null,
          ),
        );

        await pumpResizeHandlerWidget(
          tester,
          callback: (context) {
            const ResizeToolHandler().onPanUpdate(
              DragUpdateDetails(
                globalPosition: const Offset(220, 220),
                localPosition: const Offset(220, 220),
              ),
              context,
              controller,
            );
          },
        );

        verifyNever(() => activeBloc.add(any(that: isA<ActiveLayerEvent>())));
      });

      testWidgets(
        'should not resize if original object is missing or id mismatch',
        (tester) async {
          // Case 1: originalNode is null
          when(() => activeBloc.state).thenReturn(
            ActiveLayerState(
              activeNodes: {testShape.id: testShape},
              resizeHandle: ResizeHandle.bottomRight,
              dragStartPoint: const Offset(200, 200),
              originalNode: null,
            ),
          );

          await pumpResizeHandlerWidget(
            tester,
            callback: (context) {
              const ResizeToolHandler().onPanUpdate(
                DragUpdateDetails(globalPosition: const Offset(220, 220)),
                context,
                controller,
              );
            },
          );

          verifyNever(() => activeBloc.add(any(that: isA<ActiveLayerEvent>())));

          // Case 2: ID mismatch
          final otherShape = testShape.copyWith(id: 999);
          when(() => activeBloc.state).thenReturn(
            ActiveLayerState(
              activeNodes: {testShape.id: testShape},
              resizeHandle: ResizeHandle.bottomRight,
              dragStartPoint: const Offset(200, 200),
              originalNode: otherShape,
            ),
          );

          await pumpResizeHandlerWidget(
            tester,
            callback: (context) {
              const ResizeToolHandler().onPanUpdate(
                DragUpdateDetails(globalPosition: const Offset(220, 220)),
                context,
                controller,
              );
            },
          );

          verifyNever(() => activeBloc.add(any(that: isA<ActiveLayerEvent>())));
        },
      );

      // This is the new test for null dragStartPoint
      testWidgets('should not resize when dragStartPoint is null', (
        tester,
      ) async {
        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(
            activeNodes: {testShape.id: testShape},
            resizeHandle: ResizeHandle.bottomRight,
            dragStartPoint: null,
            originalNode: testShape,
          ),
        );

        await pumpResizeHandlerWidget(
          tester,
          callback: (context) {
            const ResizeToolHandler().onPanUpdate(
              DragUpdateDetails(
                globalPosition: const Offset(220, 220),
                localPosition: const Offset(220, 220),
              ),
              context,
              controller,
            );
          },
        );

        verifyNever(() => activeBloc.add(any(that: isA<ActiveLayerEvent>())));
      });
    });

    group('onPanEnd', () {
      testWidgets('should finalize interaction and clear handle', (
        tester,
      ) async {
        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(
            activeNodes: {testShape.id: testShape},
            resizeHandle: ResizeHandle.bottomRight,
            dragStartPoint: const Offset(200, 200),
            originalNode: testShape,
          ),
        );
        when(
          () => shapeBloc.state,
        ).thenReturn(ShapeLayerState.success(data: ShapeLayerData(nodes: {})));

        await pumpResizeHandlerWidget(
          tester,
          callback: (context) {
            const ResizeToolHandler().onPanEnd(
              DragEndDetails(),
              context,
              controller,
            );
          },
        );

        verify(() => mediator.finalizeInteraction()).called(1);
        verify(
          () => shapeBloc.add(ShapeLayerEvent.removeNode(testShape.id)),
        ).called(1);
        verify(
          () => activeBloc.add(const ActiveLayerEvent.handleChanged(null)),
        ).called(1);
      });

      testWidgets('should set originalNode for continuous interaction', (
        tester,
      ) async {
        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(
            activeNodes: {testShape.id: testShape},
            resizeHandle: ResizeHandle.bottomRight,
            dragStartPoint: const Offset(200, 200),
            originalNode: testShape,
          ),
        );
        when(
          () => shapeBloc.state,
        ).thenReturn(ShapeLayerState.success(data: ShapeLayerData(nodes: {})));

        await pumpResizeHandlerWidget(
          tester,
          callback: (context) {
            const ResizeToolHandler().onPanEnd(
              DragEndDetails(),
              context,
              controller,
            );
          },
        );

        verify(
          () => activeBloc.add(ActiveLayerEvent.originalNodeSet(testShape)),
        ).called(1);
      });

      testWidgets('should finalize but skip updates if activeNodes is empty', (
        tester,
      ) async {
        when(() => activeBloc.state).thenReturn(
          const ActiveLayerState(
            activeNodes: {},
            resizeHandle: ResizeHandle.bottomRight,
            dragStartPoint: Offset(200, 200),
            originalNode: null,
          ),
        );

        await pumpResizeHandlerWidget(
          tester,
          callback: (context) {
            const ResizeToolHandler().onPanEnd(
              DragEndDetails(),
              context,
              controller,
            );
          },
        );

        verify(() => mediator.finalizeInteraction()).called(1);
        // Ensure no events sent to shapeBloc or activeBloc (logic inside 'isNotEmpty' blocks)
        verifyNever(() => shapeBloc.add(any(that: isA<ShapeLayerEvent>())));
        // originalNodeSet should NOT be called
        final captured = verify(() => activeBloc.add(captureAny())).captured;
        final originalSetEvents = captured.where(
          (e) =>
              (e as ActiveLayerEvent).mapOrNull(originalNodeSet: (_) => true) ??
              false,
        );
        expect(originalSetEvents, isEmpty);

        // Only handleChanged(null) is called at the very end
        expect(
          (captured.last as ActiveLayerEvent).mapOrNull(
                handleChanged: (e) => e.handle == null,
              ) ??
              false,
          isTrue,
        );
      });
    });
  });
}
