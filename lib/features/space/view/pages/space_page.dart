import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/bloc/page_bloc.dart';
import 'package:ideascape/features/space/view/pages/canvas_layer/canvas_layer.dart';
import 'package:ideascape/features/space/view/pages/toolbar/toolbar_layer.dart';

import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';

class IdeaSpace extends StatelessWidget {
  static const String routePath = '/idea-space/:id';
  static const String routeName = 'Idea Space';

  const IdeaSpace({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => SpacePageBloc(
            id: id,
            spaceDataService: getIt<SpaceDataService>(),
          ),
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
                  child: RepositoryProvider(
                    create:
                        (context) =>
                            HistoryManager(context.read<ShapeLayerBloc>()),
                    child: const SpaceView(),
                  ),
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
      Matrix4.diagonal3Values(_initialScale, _initialScale, _initialScale),
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
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () {
              context.read<HistoryManager>().undo();
            },
          ),
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
              final newMatrix = Matrix4.translationValues(
                state.offset.dx,
                state.offset.dy,
                0.0,
              )..multiply(
                Matrix4.diagonal3Values(state.scale, state.scale, state.scale),
              );
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
                    CanvasLayer(transformationController: _controller),
                    const ToolbarLayer(),
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
