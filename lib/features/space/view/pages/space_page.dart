import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/grid_painter.dart';
import 'package:ideascape/features/space/domain/models/object_painter.dart';

import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/bloc/page_bloc.dart';
import 'package:ideascape/features/space/view/widgets/toolbar.dart';
import 'package:ideascape/features/space/view/widgets/shape_library.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler_factory.dart';

import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import '../constant.dart';

class IdeaSpace extends StatelessWidget {
  static const String routePath = '/idea-space/:id';
  static const String routeName = 'Idea Space';

  const IdeaSpace({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              SpacePageBloc(id: id, spaceDataService: getIt<SpaceDataService>()),
      child: BlocBuilder<SpacePageBloc, PageState>(
        buildWhen: (p, c) {
          return p != c;
        },
        builder: (context, state) {
          return state.map(
            init: (_) {
              context.read<SpacePageBloc>().add(const PageEvent.load());
              return const Center(child: CircularProgressIndicator());
            },
            inProgress: (_) => const Center(child: CircularProgressIndicator()),
            failure: (_) => const Center(child: Text('Failed to load space')),
            success:
                (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => CanvasBloc()),
                    BlocProvider(create: (_) => ShapeLayerBloc(id)),
                    BlocProvider(create: (_) => ActiveLayerBloc()),
                    BlocProvider(create: (context) => ToolbarBloc()),
                  ],
                  child: const SpaceView(),
                ),
          );
        },
      ),
    );
  }
}

class SpaceView extends StatefulWidget {
  const SpaceView({super.key});

  @override
  State<SpaceView> createState() => _SpaceViewState();
}

class _SpaceViewState extends State<SpaceView> {
  late TransformationController _controller;
  final double _initialScale =
      3.0; // Set your initial scale factor here (e.g., 2.0 for 2x zoom)

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the desired initial scale.
    _controller = TransformationController(
      Matrix4.identity()..scale(_initialScale),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ShapeLayerBloc>().add(const ShapeLayerEvent.initialize());

      _controller.addListener(() {
        final matrix = _controller.value;
        final scale = matrix.getMaxScaleOnAxis();
        final translation = matrix.getTranslation();

        context.read<CanvasBloc>().add(
          CanvasEvent.transformUpdated(
            offset: Offset(translation.x, translation.y),
            scale: scale,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: BlocSelector<ShapeLayerBloc, ShapeLayerState, String>(
          selector: (state) {
            return state.data.title;
          },
          builder: (context, title) {
            return Text(title);
          },
        ),
        actions: [
          IconButton(icon: const Icon(Icons.undo), onPressed: () {}),
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CircleAvatar(child: Icon(Icons.person)),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CanvasBloc, CanvasState>(
            listenWhen: (p, c) {
              return p.offset != c.offset || p.scale != c.scale;
            },
            listener: (BuildContext context, CanvasState state) {
              final newMatrix =
                  Matrix4.identity()
                    ..translate(state.offset.dx, state.offset.dy)
                    ..scale(state.scale);
              if (_controller.value != newMatrix) {
                _controller.value = newMatrix;
              }
            },
          ),
        ],
        child: BlocBuilder<ShapeLayerBloc, ShapeLayerState>(
          buildWhen: (p, c) {
            return p != c;
          },
          builder: (context, state) {
            switch (state) {
              case ShapeLayerStateFailure():
                return const Center(child: Text("failure"));
              case ShapeLayerStateInitialize():
                return const Center(child: Text("init"));
              case ShapeLayerStateLoading():
                return const Center(child: CircularProgressIndicator());
              case ShapeLayerStateSuccess():
                return Stack(
                  children: [
                    // The main interactive canvas area
                    GestureDetector(
                      child: Stack(
                        children: [
                          BlocBuilder<ToolbarBloc, ToolbarState>(
                            buildWhen: (p, c) {
                              return p.tool != c.tool;
                            },
                            builder: (context, state) {
                              return InteractiveViewer(
                                panEnabled: state.panEnabled,
                                transformationController: _controller,
                                boundaryMargin: const EdgeInsets.all(
                                  double.infinity,
                                ),
                                // panEnabled: _selectedTool == SpaceTool.pan,
                                minScale: 0.02,
                                scaleFactor: 0.1,
                                maxScale: 100.0,
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (
                                    BuildContext context,
                                    Widget? child,
                                  ) {
                                    return GestureDetector(
                                      onTapUp: (details) {
                                        final tool =
                                            context
                                                .read<ToolbarBloc>()
                                                .state
                                                .tool;
                                        final handler =
                                            ToolHandlerFactory.getHandler(tool);
                                        handler.onTapUp(
                                          details,
                                          context,
                                          _controller,
                                        );
                                      },
                                      onPanStart:
                                          state.panEnabled
                                              ? null
                                              : (details) {
                                                final tool =
                                                    context
                                                        .read<ToolbarBloc>()
                                                        .state
                                                        .tool;
                                                final handler =
                                                    ToolHandlerFactory.getHandler(
                                                      tool,
                                                    );
                                                handler.onPanStart(
                                                  details,
                                                  context,
                                                  _controller,
                                                );
                                              },
                                      onPanUpdate:
                                          state.panEnabled
                                              ? null
                                              : (details) {
                                                final tool =
                                                    context
                                                        .read<ToolbarBloc>()
                                                        .state
                                                        .tool;
                                                final handler =
                                                    ToolHandlerFactory.getHandler(
                                                      tool,
                                                    );
                                                handler.onPanUpdate(
                                                  details,
                                                  context,
                                                  _controller,
                                                );
                                              },
                                      onPanEnd:
                                          state.panEnabled
                                              ? null
                                              : (details) {
                                                final tool =
                                                    context
                                                        .read<ToolbarBloc>()
                                                        .state
                                                        .tool;
                                                final handler =
                                                    ToolHandlerFactory.getHandler(
                                                      tool,
                                                    );
                                                handler.onPanEnd(
                                                  details,
                                                  context,
                                                  _controller,
                                                );
                                              },
                                      child: Stack(
                                        children: [
                                          CustomPaint(
                                            size:
                                                MediaQuery.of(context).size *
                                                15,
                                            painter: GridPainter(
                                              transformationController:
                                                  _controller,
                                            ),
                                          ),
                                          BlocBuilder<
                                            ShapeLayerBloc,
                                            ShapeLayerState
                                          >(
                                            buildWhen: (p, c) {
                                              return p.data.objects !=
                                                  c.data.objects;
                                            },
                                            builder: (context, state) {
                                              return CustomPaint(
                                                size: Size(
                                                  defaultWidth,
                                                  defaultHeight,
                                                ),
                                                painter: ObjectPainter(
                                                  objects:
                                                      state.data.objects.values
                                                          .toList(),
                                                  transform: _controller.value,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    // Left-side main toolbar
                    Positioned(top: 16, left: 16, child: ToolBar()),

                    // Shape Library Panel
                    BlocBuilder<ToolbarBloc, ToolbarState>(
                      builder: (context, state) {
                        if (state.tool != SpaceTool.shape)
                          return const SizedBox.shrink();
                        return Positioned(
                          top: 16,
                          left: 90, // Next to toolbar
                          child: ShapeLibrary(
                            onShapeSelected: (type) {
                              context.read<ToolbarBloc>().add(
                                ToolbarEvent.shapeSelected(type),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              default:
                return Center(child: Text("Failure"));
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}

extension on ToolbarState {
  get panEnabled => this.tool == SpaceTool.pan;
}
