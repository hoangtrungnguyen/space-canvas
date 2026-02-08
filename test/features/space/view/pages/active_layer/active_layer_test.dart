import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_object.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_event.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/active_layer/active_layer.dart';
import 'package:ideascape/features/space/view/pages/active_layer/connector_selection_painter.dart';
import 'package:ideascape/features/space/view/pages/active_layer/selection_painter.dart';
import 'package:mocktail/mocktail.dart';

class MockActiveLayerBloc extends MockBloc<ActiveLayerEvent, ActiveLayerState>
    implements ActiveLayerBloc {}

class MockToolbarBloc extends MockBloc<ToolbarEvent, ToolbarState>
    implements ToolbarBloc {}

class MockShapeLayerBloc extends MockBloc<ShapeLayerEvent, ShapeLayerState>
    implements ShapeLayerBloc {}

void main() {
  late MockActiveLayerBloc activeBloc;
  late MockToolbarBloc toolbarBloc;
  late MockShapeLayerBloc shapeLayerBloc;
  late TransformationController transformationController;

  setUp(() {
    activeBloc = MockActiveLayerBloc();
    toolbarBloc = MockToolbarBloc();
    shapeLayerBloc = MockShapeLayerBloc();
    transformationController = TransformationController();
  });

  Widget createSubject() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActiveLayerBloc>.value(value: activeBloc),
        BlocProvider<ToolbarBloc>.value(value: toolbarBloc),
        BlocProvider<ShapeLayerBloc>.value(value: shapeLayerBloc),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: ActiveLayer(transformationController: transformationController),
        ),
      ),
    );
  }

  group('ActiveLayer', () {
    testWidgets(
      'renders ConnectorSelectionPainter when tool is selectConnector and active object is Connector',
      (tester) async {
        final connector = ConnectorObject(
          id: 1,
          startPoint: const Offset(0, 0),
          endPoint: const Offset(100, 100),
          strokeWidth: 2.0,
          color: 0xFF000000,
        );

        when(
          () => activeBloc.state,
        ).thenReturn(ActiveLayerState(activeObjects: {1: connector}));
        when(
          () => toolbarBloc.state,
        ).thenReturn(ToolbarState(tool: SpaceTool.selectConnector));
        when(
          () => shapeLayerBloc.state,
        ).thenReturn(ShapeLayerState.initialize(data: const ShapeLayerData()));

        await tester.pumpWidget(createSubject());

        expect(find.byType(CustomPaint), findsWidgets);

        final paints = tester.widgetList<CustomPaint>(find.byType(CustomPaint));
        final connectorPainter = paints.firstWhere(
          (widget) => widget.painter is ConnectorSelectionPainter,
          orElse: () => throw Exception('ConnectorSelectionPainter not found'),
        );

        expect(connectorPainter.painter, isA<ConnectorSelectionPainter>());
        expect(
          (connectorPainter.painter as ConnectorSelectionPainter).connectors,
          contains(connector),
        );
      },
    );

    testWidgets(
      'does NOT render ConnectorSelectionPainter when tool is select',
      (tester) async {
        final connector = ConnectorObject(
          id: 1,
          startPoint: const Offset(0, 0),
          endPoint: const Offset(100, 100),
          strokeWidth: 2.0,
          color: 0xFF000000,
        );

        when(
          () => activeBloc.state,
        ).thenReturn(ActiveLayerState(activeObjects: {1: connector}));
        when(
          () => toolbarBloc.state,
        ).thenReturn(ToolbarState(tool: SpaceTool.select));
        when(
          () => shapeLayerBloc.state,
        ).thenReturn(ShapeLayerState.initialize(data: const ShapeLayerData()));

        await tester.pumpWidget(createSubject());

        final paints = tester.widgetList<CustomPaint>(find.byType(CustomPaint));
        final hasConnectorPainter = paints.any(
          (widget) => widget.painter is ConnectorSelectionPainter,
        );

        expect(hasConnectorPainter, isFalse);

        // Should use SelectionPainter instead
        final hasSelectionPainter = paints.any(
          (widget) => widget.painter is SelectionPainter,
        );
        expect(hasSelectionPainter, isTrue);
      },
    );
    testWidgets(
      'does NOT render ConnectorSelectionPainter when active object is NOT Connector',
      (tester) async {
        final shape = ShapeObject(
          id: 1,
          type: ShapeType.rectangle,
          rect: const Rect.fromLTWH(0, 0, 100, 100),
          paint: Paint(),
        );

        when(
          () => activeBloc.state,
        ).thenReturn(ActiveLayerState(activeObjects: {1: shape}));
        when(
          () => toolbarBloc.state,
        ).thenReturn(ToolbarState(tool: SpaceTool.selectConnector));
        when(
          () => shapeLayerBloc.state,
        ).thenReturn(ShapeLayerState.initialize(data: const ShapeLayerData()));
        await tester.pumpWidget(createSubject());

        // Should check that ConnectorSelectionPainter is NOT rendered
        final paints = tester.widgetList<CustomPaint>(find.byType(CustomPaint));
        // Filter out ObjectPainter
        // Filter out ObjectPainter
        final hasConnectorPainter = paints.any(
          (widget) => widget.painter is ConnectorSelectionPainter,
        );
        expect(hasConnectorPainter, isFalse);
      },
    );
  });
}
