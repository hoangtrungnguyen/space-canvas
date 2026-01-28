import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/bloc/page_bloc.dart';
import 'package:ideascape/features/space/view/pages/canvas_layer/canvas_layer.dart';
import 'package:ideascape/features/space/view/pages/space_app_bar.dart';
import 'package:ideascape/features/space/view/pages/space_listener.dart';
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
          (context) =>
              SpacePageBloc(id: id, spaceDataService: getIt<SpaceDataService>())
                ..add(const PageEvent.load()),
      child: BlocBuilder<SpacePageBloc, PageState>(
        buildWhen: (p, c) {
          return p != c;
        },
        builder: (context, state) {
          return state.map(
            init: (_) {
              return const Center(child: CircularProgressIndicator());
            },
            inProgress: (_) => const Center(child: CircularProgressIndicator()),
            failure: (_) => const Center(child: Text('Failed to load space')),
            success:
                (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => CanvasBloc()),
                    BlocProvider(
                      create:
                          (_) =>
                              ShapeLayerBloc(id)
                                ..add(const ShapeLayerEvent.initialize()),
                    ),
                    BlocProvider(create: (_) => ActiveLayerBloc()),
                    BlocProvider(create: (context) => ToolbarBloc()),
                  ],
                  child: RepositoryProvider(
                    create:
                        (context) =>
                            HistoryManager(context.read<ShapeLayerBloc>()),
                    child: const SpaceListener(child: SpaceView()),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SpaceAppBar(),
      body: BlocBuilder<ShapeLayerBloc, ShapeLayerState>(
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
                clipBehavior: Clip.none,
                children: [
                  CanvasLayer(transformationController: _controller),
                  ToolbarLayer(transformationController: _controller),
                ],
              );
            default:
              return Center(child: Text("Failure"));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
