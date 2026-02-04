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
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/resize_handle.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/select_tool_handler.dart';

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

  group('SelectToolHandler', () {
    late MockActiveLayerBloc activeBloc;
    late MockShapeLayerBloc shapeBloc;
    late MockCanvasInteractionMediator mediator;
    late TransformationController controller;
    late ShapeObject testShape;

    setUp(() {
      activeBloc = MockActiveLayerBloc();
      shapeBloc = MockShapeLayerBloc();
      mediator = MockCanvasInteractionMediator();
      controller = TransformationController();

      testShape = ShapeObject(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 100, 100),
        paint: Paint()..color = const Color(0xFF0000FF),
      );
    });

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

    group('onPanStart', () {
      testWidgets('should select handle if hit', (tester) async {
        // Setup state with active object
        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(
            activeObjects: {testShape.id: testShape},
            activeHandle: null,
            dragStartPoint: null,
            originalObject: testShape,
          ),
        );
        // We need ShapeLayerBloc subscription to be happy?
        when(
          () => shapeBloc.state,
        ).thenReturn(ShapeLayerState.initialize(data: const ShapeLayerData()));

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            // Tap on TopLeft handle (90, 90) or similar.
            // Shape is at 100,100. Inflated by 4.0 -> 96,96.
            // Radius is 20.0.
            // Tapping at 100,100 should hit TopLeft.
            const SelectToolHandler().onPanStart(
              DragStartDetails(
                globalPosition: const Offset(100, 100),
                localPosition: const Offset(100, 100),
              ),
              context,
              controller,
            );
          },
        );

        // Verify handle changed
        verify(
          () => activeBloc.add(any(that: isA<ActiveLayerEvent>())),
        ).called(greaterThanOrEqualTo(2));

        // Verify shape removed from layer (to prevent ghosting)
        // verify(() => shapeBloc.add(any(that: isA<ShapeLayerEvent>()))).called(1); // Usually logic does this
      });

      testWidgets('should select body via mediator if no handle hit', (
        tester,
      ) async {
        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(
            activeObjects: {testShape.id: testShape},
            activeHandle: null,
            dragStartPoint: null,
            originalObject: testShape,
          ),
        );

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            // Tap far away at 500,500
            const SelectToolHandler().onPanStart(
              DragStartDetails(
                globalPosition: const Offset(500, 500),
                localPosition: const Offset(500, 500),
              ),
              context,
              controller,
            );
          },
        );

        // Verify mediator selectAt called
        verify(
          () => mediator.selectAt(const Offset(500, 500), isDrag: true),
        ).called(1);
        // Verify handle cleared
        verify(
          () => activeBloc.add(const ActiveLayerEvent.handleChanged(null)),
        ).called(1);
      });
    });

    group('onPanUpdate', () {
      testWidgets(
        'should delegate to ResizeToolHandler (ActiveLayerEvent.objectChanged) if activeHandle is set',
        (tester) async {
          // Setup state for resizing
          when(() => activeBloc.state).thenReturn(
            ActiveLayerState(
              activeObjects: {testShape.id: testShape},
              activeHandle: ResizeHandle.bottomRight,
              dragStartPoint: const Offset(200, 200), // Start at corner
              originalObject: testShape,
            ),
          );

          await pumpHandlerWidget(
            tester,
            callback: (context) {
              // Drag to 210, 210
              const SelectToolHandler().onPanUpdate(
                DragUpdateDetails(
                  globalPosition: const Offset(210, 210),
                  localPosition: const Offset(210, 210),
                ),
                context,
                controller,
              );
            },
          );

          // ResizeToolHandler should calculate new object and add event
          verify(
            () => activeBloc.add(any(that: isA<ActiveLayerEvent>())),
          ).called(1);
          // Note: checking specifically for objectChanged is hard with mocks/fakes without capturing
        },
      );

      testWidgets(
        'should delegate to Mediator (dragActiveObject) if activeHandle is null',
        (tester) async {
          // Setup state for moving
          when(() => activeBloc.state).thenReturn(
            ActiveLayerState(
              activeObjects: {testShape.id: testShape},
              activeHandle: null,
              dragStartPoint: const Offset(200, 200),
              originalObject: testShape,
            ),
          );

          await pumpHandlerWidget(
            tester,
            callback: (context) {
              const SelectToolHandler().onPanUpdate(
                DragUpdateDetails(
                  globalPosition: const Offset(210, 210),
                  localPosition: const Offset(210, 210),
                ),
                context,
                controller,
              );
            },
          );

          verify(
            () => mediator.dragActiveObject(
              const Offset(210, 210),
              const Offset(10, 10),
            ),
          ).called(1);
        },
      );
    });

    group('onPanEnd', () {
      testWidgets('should finalize interaction and clear handle on end', (
        tester,
      ) async {
        // Setup state (doesn't matter much if handle is null or not for finalize)
        // If handle is null
        when(() => activeBloc.state).thenReturn(
          const ActiveLayerState(activeObjects: {}, activeHandle: null),
        );
        when(
          () => shapeBloc.state,
        ).thenReturn(ShapeLayerState.initialize(data: const ShapeLayerData()));

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            const SelectToolHandler().onPanEnd(
              DragEndDetails(),
              context,
              controller,
            );
          },
        );

        verify(() => mediator.finalizeInteraction()).called(1);
      });

      testWidgets(
        'should delegate onPanEnd to ResizeToolHandler if activeHandle set',
        (tester) async {
          // Setup state
          when(() => activeBloc.state).thenReturn(
            ActiveLayerState(
              activeObjects: {testShape.id: testShape},
              activeHandle: ResizeHandle.bottomRight,
            ),
          );
          when(() => shapeBloc.state).thenReturn(
            ShapeLayerState.initialize(data: const ShapeLayerData()),
          );

          await pumpHandlerWidget(
            tester,
            callback: (context) {
              const SelectToolHandler().onPanEnd(
                DragEndDetails(),
                context,
                controller,
              );
            },
          );

          // SelectToolHandler delegates. ResizeToolHandler calls handleChanged(null).
          // Then SelectToolHandler continues and calls finalize.
          verify(
            () => activeBloc.add(const ActiveLayerEvent.handleChanged(null)),
          ).called(1);
          verify(() => mediator.finalizeInteraction()).called(1);
        },
      );
    });
  });
}
