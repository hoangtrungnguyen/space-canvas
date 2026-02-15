import 'dart:ui';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/connector_tool_handler.dart';
import 'package:mocktail/mocktail.dart';

class MockActiveLayerBloc extends MockBloc<ActiveLayerEvent, ActiveLayerState>
    implements ActiveLayerBloc {}

class MockShapeLayerBloc extends MockBloc<ShapeLayerEvent, ShapeLayerState>
    implements ShapeLayerBloc {}

class MockToolbarBloc extends MockBloc<ToolbarEvent, ToolbarState>
    implements ToolbarBloc {}

class MockMediator extends Mock implements CanvasInteractionMediator {}

class GenericNode extends Node {
  @override
  final int id;
  @override
  final int zIndex;
  @override
  final Rect rect;
  @override
  final double rotation;

  GenericNode({
    required this.id,
    required this.zIndex,
    required this.rect,
    this.rotation = 0.0,
  });

  @override
  T accept<T>(NodeVisitor<T> visitor) => visitor.visitListOfPoint(
    ListOfPointNode(
      id: id,
      zIndex: zIndex,
      points: [],
      strokeWidth: 1,
      color: 0,
    ),
  ); // Hack for test

  @override
  Paint get paint => Paint();

  @override
  Path get path => Path()..addRect(rect);

  @override
  Matrix4 get transform => Matrix4.identity();

  @override
  Rect get bounds => rect;
}

void main() {
  late ConnectorToolHandler handler;
  late MockActiveLayerBloc activeBloc;
  late MockShapeLayerBloc shapeBloc;
  late MockToolbarBloc toolbarBloc;
  late MockMediator mediator;
  late TransformationController transformationController;

  setUp(() {
    handler = const ConnectorToolHandler();
    activeBloc = MockActiveLayerBloc();
    shapeBloc = MockShapeLayerBloc();
    toolbarBloc = MockToolbarBloc();
    mediator = MockMediator();
    transformationController = TransformationController();

    when(() => activeBloc.state).thenReturn(const ActiveLayerState());
    when(
      () => shapeBloc.state,
    ).thenReturn(ShapeLayerState.initialize(data: const ShapeLayerData()));
  });

  Widget createTestWidget(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActiveLayerBloc>.value(value: activeBloc),
        BlocProvider<ShapeLayerBloc>.value(value: shapeBloc),
        BlocProvider<ToolbarBloc>.value(value: toolbarBloc),
      ],
      child: RepositoryProvider<CanvasInteractionMediator>.value(
        value: mediator,
        child: MaterialApp(home: Scaffold(body: child)),
      ),
    );
  }

  testWidgets('onTapUp starts connector creation when tapping an anchor', (
    tester,
  ) async {
    final object = GenericNode(
      id: 1,
      zIndex: 0,
      rect: const Rect.fromLTWH(100, 100, 100, 100),
    );

    when(() => shapeBloc.state).thenReturn(
      ShapeLayerState.success(data: ShapeLayerData(nodes: {1: object})),
    );

    await tester.pumpWidget(createTestWidget(Container()));
    final context = tester.element(find.byType(Container));

    // Tap closely to Top Center (150, 100)
    handler.onTapUp(
      TapUpDetails(
        kind: PointerDeviceKind.touch,
        globalPosition: const Offset(150, 100),
        localPosition: const Offset(150, 100),
      ),
      context,
      transformationController,
    );

    verify(
      () => activeBloc.add(
        ActiveLayerEvent.connectorDragStarted(
          startNodeId: 1,
          startPoint: const Offset(150, 100), // Top Center of rect
        ),
      ),
    ).called(1);
  });

  testWidgets('onTapUp ends connector creation and switches tool', (
    tester,
  ) async {
    final startPoint = const Offset(0, 0);
    when(() => activeBloc.state).thenReturn(
      ActiveLayerState(
        connectorStartPoint: startPoint,
        connectorStartNodeId: 1,
      ),
    );

    final object = GenericNode(
      id: 2,
      zIndex: 0,
      rect: const Rect.fromLTWH(200, 200, 100, 100),
    );
    when(() => shapeBloc.state).thenReturn(
      ShapeLayerState.success(data: ShapeLayerData(nodes: {2: object})),
    );

    await tester.pumpWidget(createTestWidget(Container()));
    final context = tester.element(find.byType(Container));

    // Tap on second object
    handler.onTapUp(
      TapUpDetails(
        kind: PointerDeviceKind.touch,
        globalPosition: const Offset(250, 250),
        localPosition: const Offset(250, 250),
      ),
      context,
      transformationController,
    );

    verify(
      () => mediator.createConnector(
        startPoint: startPoint,
        endPoint: const Offset(250, 250),
        startNodeId: 1,
        endNodeId: 2,
        startLocation: any(named: 'startLocation'),
        endLocation: any(named: 'endLocation'),
      ),
    ).called(1);

    verify(
      () => toolbarBloc.add(
        const ToolbarEvent.selected(SpaceTool.selectConnector),
      ),
    ).called(1);

    verify(
      () => activeBloc.add(const ActiveLayerEvent.connectorDragEnded()),
    ).called(1);
  });
}
