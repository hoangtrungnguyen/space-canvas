import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/view/widgets/active_layer_observer.dart';
import 'package:provider/provider.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/bloc/page_bloc.dart';
import 'package:ideascape/features/space/view/pages/canvas_layer/canvas_layer.dart';
import 'package:ideascape/features/space/view/pages/space_app_bar.dart';
import 'package:ideascape/features/space/view/pages/space_listener.dart';
import 'package:ideascape/features/space/view/pages/toolbar/toolbar_layer.dart';

import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/domain/managers/interaction_state_manager.dart';
import 'package:ideascape/features/space/domain/managers/selection_manager.dart';

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
                  ],
                  child: MultiProvider(
                    providers: [
                      BlocProvider(create: (context) => ToolbarBloc()),
                      ChangeNotifierProxyProvider<
                        ShapeLayerBloc,
                        HistoryManager
                      >(
                        create:
                            (context) =>
                                HistoryManager(context.read<ShapeLayerBloc>()),
                        update:
                            (context, shapeBloc, history) =>
                                history!..updateShapeLayerBloc(shapeBloc),
                      ),
                      ProxyProvider3<
                        ShapeLayerBloc,
                        ActiveLayerBloc,
                        HistoryManager,
                        InteractionStateManager
                      >(
                        update:
                            (context, shapeBloc, activeBloc, history, _) =>
                                InteractionStateManager(
                                  activeBloc: activeBloc,
                                  shapeBloc: shapeBloc,
                                  history: history,
                                ),
                      ),
                      ProxyProvider4<
                        ShapeLayerBloc,
                        ActiveLayerBloc,
                        InteractionStateManager,
                        ToolbarBloc,
                        SelectionManager
                      >(
                        update:
                            (
                              context,
                              shapeBloc,
                              activeBloc,
                              interactionManager,
                              toolbarBloc,
                              _,
                            ) => SelectionManager(
                              activeBloc: activeBloc,
                              shapeBloc: shapeBloc,
                              interactionManager: interactionManager,
                              toolbarBloc: toolbarBloc,
                            ),
                      ),
                    ],
                    child: ProxyProvider6<
                      ShapeLayerBloc,
                      ActiveLayerBloc,
                      HistoryManager,
                      InteractionStateManager,
                      SelectionManager,
                      ToolbarBloc,
                      CanvasInteractionMediator
                    >(
                      update:
                          (
                            context,
                            shapeBloc,
                            activeBloc,
                            history,
                            stateManager,
                            selectionManager,
                            toolbarBloc,
                            _,
                          ) => CanvasInteractionMediatorImpl(
                            shapeBloc: shapeBloc,
                            activeBloc: activeBloc,
                            history: history,
                            stateManager: stateManager,
                            selectionManager: selectionManager,
                            toolbarBloc: toolbarBloc,
                          ),
                      child: const ActiveLayerObserver(
                        child: SpaceListener(child: SpaceView()),
                      ),
                    ),
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
