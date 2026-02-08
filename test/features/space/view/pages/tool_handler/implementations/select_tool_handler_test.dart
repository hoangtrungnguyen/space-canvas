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
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/select_tool_handler.dart';
import 'package:ideascape/features/space/domain/models/selection_filter.dart';

import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';

class MockActiveLayerBloc extends MockBloc<ActiveLayerEvent, ActiveLayerState>
    implements ActiveLayerBloc {}

class MockShapeLayerBloc extends MockBloc<ShapeLayerEvent, ShapeLayerState>
    implements ShapeLayerBloc {}

class MockToolbarBloc extends MockBloc<ToolbarEvent, ToolbarState>
    implements ToolbarBloc {}

class MockCanvasInteractionMediator extends Mock
    implements CanvasInteractionMediator {}

class FakeActiveLayerEvent extends Fake implements ActiveLayerEvent {}

class FakeShapeLayerEvent extends Fake implements ShapeLayerEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeActiveLayerEvent());
    registerFallbackValue(FakeShapeLayerEvent());
    registerFallbackValue(const ToolbarEvent.toDefault());
    registerFallbackValue(const Offset(0, 0));
  });

  group('SelectToolHandler', () {
    late MockActiveLayerBloc activeBloc;
    late MockShapeLayerBloc shapeBloc;
    late MockToolbarBloc toolbarBloc;
    late MockCanvasInteractionMediator mediator;
    late TransformationController controller;
    late ShapeObject testShape;
    late ConnectorObject testConnector;

    setUp(() {
      activeBloc = MockActiveLayerBloc();
      shapeBloc = MockShapeLayerBloc();
      toolbarBloc = MockToolbarBloc();
      mediator = MockCanvasInteractionMediator();
      controller = TransformationController();

      testShape = ShapeObject(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(100, 100, 100, 100),
        paint: Paint()..color = const Color(0xFF0000FF),
      );

      testConnector = ConnectorObject(
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

    void setupActiveState({
      Map<int, SpaceObject>? objects,
      ResizeHandle? handle,
      Offset? startPoint,
      SpaceObject? originalObject,
    }) {
      when(() => activeBloc.state).thenReturn(
        ActiveLayerState(
          activeObjects: objects ?? {testShape.id: testShape},
          resizeHandle: handle,
          dragStartPoint: startPoint,
          originalObject: originalObject ?? testShape,
        ),
      );
    }

    void setupShapeState() {
      when(
        () => shapeBloc.state,
      ).thenReturn(ShapeLayerState.initialize(data: const ShapeLayerData()));
    }

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

    // =========================================================================
    // onTapUp Tests
    // =========================================================================
    group('onTapUp', () {
      testWidgets('should call mediator.selectAt with correct point', (
        tester,
      ) async {
        setupActiveState();
        setupShapeState();

        when(() => mediator.hitTest(any())).thenReturn(null);

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            const SelectToolHandler().onTapUp(
              TapUpDetails(
                globalPosition: const Offset(100, 100),
                localPosition: const Offset(100, 100),
                kind: PointerDeviceKind.touch,
              ),
              context,
              controller,
            );
          },
        );

        verify(
          () => mediator.selectAt(
            const Offset(100, 100),
            isDrag: false,
            filter: SelectionFilter.excludeConnectors,
          ),
        ).called(1);
      });

      testWidgets(
        'should switch tool and call selectConnectorAt when hitting connector',
        (tester) async {
          setupActiveState();
          setupShapeState();

          when(() => mediator.hitTest(any())).thenReturn(testConnector);

          await pumpHandlerWidget(
            tester,
            callback: (context) {
              const SelectToolHandler().onTapUp(
                TapUpDetails(
                  globalPosition: const Offset(300, 300),
                  localPosition: const Offset(300, 300),
                  kind: PointerDeviceKind.touch,
                ),
                context,
                controller,
              );
            },
          );

          verify(
            () => toolbarBloc.add(
              const ToolbarEvent.selected(SpaceTool.selectConnector),
            ),
          ).called(1);

          verify(
            () => mediator.selectConnectorAt(
              const Offset(300, 300),
              isDrag: false,
            ),
          ).called(1);
        },
      );

      testWidgets('should handle zoomed canvas', (tester) async {
        controller.value = Matrix4.identity()..scale(2.0, 2.0, 1.0);
        setupActiveState();
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            const SelectToolHandler().onTapUp(
              TapUpDetails(
                globalPosition: const Offset(200, 200),
                localPosition: const Offset(200, 200),
                kind: PointerDeviceKind.touch,
              ),
              context,
              controller,
            );
          },
        );

        verify(
          () => mediator.selectAt(
            const Offset(100, 100),
            isDrag: false,
            filter: SelectionFilter.excludeConnectors,
          ),
        ).called(1);
      });
    });

    // =========================================================================
    // onPanStart Tests
    // =========================================================================
    group('onPanStart', () {
      testWidgets('should select topLeft handle when hit', (tester) async {
        setupActiveState();
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            when(() => mediator.hitTest(any())).thenReturn(null);
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

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        final handleEvents = captured.where(
          (e) =>
              (e as ActiveLayerEvent).mapOrNull(handleChanged: (_) => true) ??
              false,
        );
        expect(handleEvents, isNotEmpty);
        (handleEvents.first as ActiveLayerEvent).mapOrNull(
          handleChanged: (e) => expect(e.handle, ResizeHandle.topLeft),
        );
      });

      testWidgets('should select topRight handle when hit', (tester) async {
        setupActiveState();
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            when(() => mediator.hitTest(any())).thenReturn(null);
            const SelectToolHandler().onPanStart(
              DragStartDetails(
                globalPosition: const Offset(200, 100),
                localPosition: const Offset(200, 100),
              ),
              context,
              controller,
            );
          },
        );

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        final handleEvents = captured.where(
          (e) =>
              (e as ActiveLayerEvent).mapOrNull(handleChanged: (_) => true) ??
              false,
        );
        (handleEvents.first as ActiveLayerEvent).mapOrNull(
          handleChanged: (e) => expect(e.handle, ResizeHandle.topRight),
        );
      });

      testWidgets('should select bottomLeft handle when hit', (tester) async {
        setupActiveState();
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            when(() => mediator.hitTest(any())).thenReturn(null);
            const SelectToolHandler().onPanStart(
              DragStartDetails(
                globalPosition: const Offset(100, 200),
                localPosition: const Offset(100, 200),
              ),
              context,
              controller,
            );
          },
        );

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        final handleEvents = captured.where(
          (e) =>
              (e as ActiveLayerEvent).mapOrNull(handleChanged: (_) => true) ??
              false,
        );
        (handleEvents.first as ActiveLayerEvent).mapOrNull(
          handleChanged: (e) => expect(e.handle, ResizeHandle.bottomLeft),
        );
      });

      testWidgets('should select bottomRight handle when hit', (tester) async {
        setupActiveState();
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            when(() => mediator.hitTest(any())).thenReturn(null);
            const SelectToolHandler().onPanStart(
              DragStartDetails(
                globalPosition: const Offset(200, 200),
                localPosition: const Offset(200, 200),
              ),
              context,
              controller,
            );
          },
        );

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        final handleEvents = captured.where(
          (e) =>
              (e as ActiveLayerEvent).mapOrNull(handleChanged: (_) => true) ??
              false,
        );
        (handleEvents.first as ActiveLayerEvent).mapOrNull(
          handleChanged: (e) => expect(e.handle, ResizeHandle.bottomRight),
        );
      });

      testWidgets('should select topCenter handle when hit', (tester) async {
        setupActiveState();
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            when(() => mediator.hitTest(any())).thenReturn(null);
            const SelectToolHandler().onPanStart(
              DragStartDetails(
                globalPosition: const Offset(150, 96),
                localPosition: const Offset(150, 96),
              ),
              context,
              controller,
            );
          },
        );

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        final handleEvents = captured.where(
          (e) =>
              (e as ActiveLayerEvent).mapOrNull(handleChanged: (_) => true) ??
              false,
        );
        (handleEvents.first as ActiveLayerEvent).mapOrNull(
          handleChanged: (e) => expect(e.handle, ResizeHandle.topCenter),
        );
      });

      testWidgets('should select bottomCenter handle when hit', (tester) async {
        setupActiveState();
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            when(() => mediator.hitTest(any())).thenReturn(null);
            const SelectToolHandler().onPanStart(
              DragStartDetails(
                globalPosition: const Offset(150, 204),
                localPosition: const Offset(150, 204),
              ),
              context,
              controller,
            );
          },
        );

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        final handleEvents = captured.where(
          (e) =>
              (e as ActiveLayerEvent).mapOrNull(handleChanged: (_) => true) ??
              false,
        );
        (handleEvents.first as ActiveLayerEvent).mapOrNull(
          handleChanged: (e) => expect(e.handle, ResizeHandle.bottomCenter),
        );
      });

      testWidgets('should select centerLeft handle when hit', (tester) async {
        setupActiveState();
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            when(() => mediator.hitTest(any())).thenReturn(null);
            const SelectToolHandler().onPanStart(
              DragStartDetails(
                globalPosition: const Offset(96, 150),
                localPosition: const Offset(96, 150),
              ),
              context,
              controller,
            );
          },
        );

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        final handleEvents = captured.where(
          (e) =>
              (e as ActiveLayerEvent).mapOrNull(handleChanged: (_) => true) ??
              false,
        );
        (handleEvents.first as ActiveLayerEvent).mapOrNull(
          handleChanged: (e) => expect(e.handle, ResizeHandle.centerLeft),
        );
      });

      testWidgets('should select centerRight handle when hit', (tester) async {
        setupActiveState();
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            when(() => mediator.hitTest(any())).thenReturn(null);
            const SelectToolHandler().onPanStart(
              DragStartDetails(
                globalPosition: const Offset(204, 150),
                localPosition: const Offset(204, 150),
              ),
              context,
              controller,
            );
          },
        );

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        final handleEvents = captured.where(
          (e) =>
              (e as ActiveLayerEvent).mapOrNull(handleChanged: (_) => true) ??
              false,
        );
        (handleEvents.first as ActiveLayerEvent).mapOrNull(
          handleChanged: (e) => expect(e.handle, ResizeHandle.centerRight),
        );
      });

      testWidgets('should call mediator.selectAt when no handle hit', (
        tester,
      ) async {
        setupActiveState();
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            when(() => mediator.hitTest(any())).thenReturn(null);
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

        verify(
          () => mediator.selectAt(
            const Offset(500, 500),
            isDrag: true,
            filter: SelectionFilter.excludeConnectors,
          ),
        ).called(1);

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        final handleEvents = captured.where(
          (e) =>
              (e as ActiveLayerEvent).mapOrNull(handleChanged: (_) => true) ??
              false,
        );
        (handleEvents.first as ActiveLayerEvent).mapOrNull(
          handleChanged: (e) => expect(e.handle, isNull),
        );
      });

      testWidgets('should handle zoomed canvas correctly', (tester) async {
        controller.value = Matrix4.identity()..scale(2.0, 2.0, 1.0);
        setupActiveState();
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            when(() => mediator.hitTest(any())).thenReturn(null);
            const SelectToolHandler().onPanStart(
              DragStartDetails(
                globalPosition: const Offset(200, 200),
                localPosition: const Offset(200, 200),
              ),
              context,
              controller,
            );
          },
        );

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        final handleEvents = captured.where(
          (e) =>
              (e as ActiveLayerEvent).mapOrNull(handleChanged: (_) => true) ??
              false,
        );
        (handleEvents.first as ActiveLayerEvent).mapOrNull(
          handleChanged: (e) => expect(e.handle, ResizeHandle.topLeft),
        );
      });

      testWidgets('should not crash with empty activeObjects', (tester) async {
        setupActiveState(objects: {});
        setupShapeState();

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            when(() => mediator.hitTest(any())).thenReturn(null);
            expect(
              () => const SelectToolHandler().onPanStart(
                DragStartDetails(
                  globalPosition: const Offset(100, 100),
                  localPosition: const Offset(100, 100),
                ),
                context,
                controller,
              ),
              returnsNormally,
            );
          },
        );

        verify(
          () => mediator.selectAt(
            const Offset(100, 100),
            isDrag: true,
            filter: SelectionFilter.excludeConnectors,
          ),
        ).called(1);
      });

      testWidgets(
        'should switch tool and call selectConnectorAt when hitting connector during pan start',
        (tester) async {
          setupActiveState();
          setupShapeState();

          await pumpHandlerWidget(
            tester,
            callback: (context) {
              when(() => mediator.hitTest(any())).thenReturn(testConnector);
              const SelectToolHandler().onPanStart(
                DragStartDetails(
                  globalPosition: const Offset(300, 300),
                  localPosition: const Offset(300, 300),
                ),
                context,
                controller,
              );
            },
          );

          verify(
            () => toolbarBloc.add(
              const ToolbarEvent.selected(SpaceTool.selectConnector),
            ),
          ).called(1);

          verify(
            () => mediator.selectConnectorAt(
              const Offset(300, 300),
              isDrag: true,
            ),
          ).called(1);

          verify(
            () => activeBloc.add(const ActiveLayerEvent.handleChanged(null)),
          ).called(1);
        },
      );
    });

    // =========================================================================
    // onPanUpdate Tests
    // =========================================================================
    group('onPanUpdate', () {
      testWidgets(
        'should delegate to ResizeToolHandler when activeHandle set',
        (tester) async {
          setupActiveState(
            handle: ResizeHandle.bottomRight,
            startPoint: const Offset(200, 200),
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

          final captured = verify(() => activeBloc.add(captureAny())).captured;
          expect(captured.length, 1);
          expect(
            (captured.first as ActiveLayerEvent).mapOrNull(
                  objectChanged: (_) => true,
                ) ??
                false,
            isTrue,
          );
        },
      );

      testWidgets('should call mediator.dragActiveObject when no handle', (
        tester,
      ) async {
        setupActiveState(handle: null, startPoint: const Offset(200, 200));

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
      });

      testWidgets('should not call mediator when dragStartPoint is null', (
        tester,
      ) async {
        setupActiveState(handle: null, startPoint: null);

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            expect(
              () => const SelectToolHandler().onPanUpdate(
                DragUpdateDetails(
                  globalPosition: const Offset(210, 210),
                  localPosition: const Offset(210, 210),
                ),
                context,
                controller,
              ),
              returnsNormally,
            );
          },
        );

        verifyNever(() => mediator.dragActiveObject(any(), any()));
      });

      testWidgets('should correctly transform with zoomed canvas', (
        tester,
      ) async {
        controller.value = Matrix4.identity()..scale(2.0, 2.0, 1.0);
        setupActiveState(handle: null, startPoint: const Offset(100, 100));

        await pumpHandlerWidget(
          tester,
          callback: (context) {
            const SelectToolHandler().onPanUpdate(
              DragUpdateDetails(
                globalPosition: const Offset(220, 220),
                localPosition: const Offset(220, 220),
              ),
              context,
              controller,
            );
          },
        );

        verify(
          () => mediator.dragActiveObject(
            const Offset(110, 110),
            const Offset(10, 10),
          ),
        ).called(1);
      });
    });

    // =========================================================================
    // onPanEnd Tests
    // =========================================================================
    group('onPanEnd', () {
      testWidgets('should finalize interaction when no handle', (tester) async {
        setupActiveState(handle: null, objects: {});
        setupShapeState();

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

      testWidgets('should delegate to ResizeToolHandler when handle set', (
        tester,
      ) async {
        setupActiveState(handle: ResizeHandle.bottomRight);
        setupShapeState();

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

        final captured = verify(() => activeBloc.add(captureAny())).captured;
        final handleEvents = captured.where(
          (e) =>
              (e as ActiveLayerEvent).mapOrNull(handleChanged: (_) => true) ??
              false,
        );
        expect(handleEvents, isNotEmpty);
        (handleEvents.first as ActiveLayerEvent).mapOrNull(
          handleChanged: (e) => expect(e.handle, isNull),
        );

        verify(() => mediator.finalizeInteraction()).called(1);
      });

      testWidgets('should remove active object from ShapeLayer', (
        tester,
      ) async {
        setupActiveState(handle: null);
        setupShapeState();

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

        verify(
          () => shapeBloc.add(ShapeLayerEvent.removeObject(testShape.id)),
        ).called(1);
      });
    });
  });
}
