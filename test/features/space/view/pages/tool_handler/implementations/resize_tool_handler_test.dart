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
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
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

    group('onPanUpdate', () {
      testWidgets('should resize object when handle and startPoint are set', (
        tester,
      ) async {
        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(
            activeObjects: {testShape.id: testShape},
            activeHandle: ResizeHandle.bottomRight,
            dragStartPoint: const Offset(200, 200),
            originalObject: testShape,
          ),
        );

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
                    // Directly call onPanUpdate
                    const ResizeToolHandler().onPanUpdate(
                      DragUpdateDetails(
                        globalPosition: const Offset(220, 220),
                        localPosition: const Offset(220, 220),
                      ),
                      context,
                      controller,
                    );
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        );

        verify(
          () => activeBloc.add(any(that: isA<ActiveLayerEvent>())),
        ).called(1);
      });

      testWidgets('should not resize when no active handle', (tester) async {
        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(
            activeObjects: {testShape.id: testShape},
            activeHandle: null,
            dragStartPoint: const Offset(200, 200),
            originalObject: testShape,
          ),
        );

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
                    const ResizeToolHandler().onPanUpdate(
                      DragUpdateDetails(
                        globalPosition: const Offset(220, 220),
                        localPosition: const Offset(220, 220),
                      ),
                      context,
                      controller,
                    );
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        );

        verifyNever(() => activeBloc.add(any(that: isA<ActiveLayerEvent>())));
      });

      testWidgets('should not resize when no active objects', (tester) async {
        when(() => activeBloc.state).thenReturn(
          const ActiveLayerState(
            activeObjects: {},
            activeHandle: ResizeHandle.bottomRight,
            dragStartPoint: Offset(200, 200),
            originalObject: null,
          ),
        );

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
                    const ResizeToolHandler().onPanUpdate(
                      DragUpdateDetails(
                        globalPosition: const Offset(220, 220),
                        localPosition: const Offset(220, 220),
                      ),
                      context,
                      controller,
                    );
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
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
            activeObjects: {testShape.id: testShape},
            activeHandle: ResizeHandle.bottomRight,
            dragStartPoint: const Offset(200, 200),
            originalObject: testShape,
          ),
        );
        when(() => shapeBloc.state).thenReturn(
          ShapeLayerState.success(data: ShapeLayerData(objects: {})),
        );

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
                    const ResizeToolHandler().onPanEnd(
                      DragEndDetails(),
                      context,
                      controller,
                    );
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        );

        verify(() => mediator.finalizeInteraction()).called(1);
        verify(
          () => shapeBloc.add(ShapeLayerEvent.removeObject(testShape.id)),
        ).called(1);
        verify(
          () => activeBloc.add(const ActiveLayerEvent.handleChanged(null)),
        ).called(1);
      });

      testWidgets('should set originalObject for continuous interaction', (
        tester,
      ) async {
        when(() => activeBloc.state).thenReturn(
          ActiveLayerState(
            activeObjects: {testShape.id: testShape},
            activeHandle: ResizeHandle.bottomRight,
            dragStartPoint: const Offset(200, 200),
            originalObject: testShape,
          ),
        );
        when(() => shapeBloc.state).thenReturn(
          ShapeLayerState.success(data: ShapeLayerData(objects: {})),
        );

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
                    const ResizeToolHandler().onPanEnd(
                      DragEndDetails(),
                      context,
                      controller,
                    );
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        );

        verify(
          () => activeBloc.add(ActiveLayerEvent.originalObjectSet(testShape)),
        ).called(1);
      });
    });
  });
}
