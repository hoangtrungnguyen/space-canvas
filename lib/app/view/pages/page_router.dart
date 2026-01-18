import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ideascape/app/view/bloc/auth/auth_bloc.dart';
import 'package:ideascape/features/dashboard/view/pages/dashboard_page.dart';

// import 'package:ideascape/features/demo/demo_js_interop_page.dart';
import 'package:ideascape/features/demo/grid_demo_page.dart';
// import 'package:ideascape/features/demo/js_interop_service.dart';
import 'package:ideascape/features/home/home.dart' show HomePage;
import 'package:ideascape/features/space/view/pages/draw_path_space_demo_page.dart';
import 'package:ideascape/features/space/view/pages/space_page.dart';

import 'splash_page.dart';

mixin AppRouter {
  GoRouter buildRouter(AuthBloc authBloc) {
    return GoRouter(
      // initialLocation: SpaceDemoPage.routePath,
      // initialLocation: DashboardPage.routePath,
      initialLocation: '/splash',
      // initialLocation: "/js-interop",
      routes: <RouteBase>[
        GoRoute(
          path: '/splash',
          builder:
              (BuildContext context, GoRouterState state) => const SplashPage(),
        ),
        GoRoute(
          path: '/home',
          builder:
              (BuildContext context, GoRouterState state) => const HomePage(),
        ),
        GoRoute(
          path: DashboardPage.routePath,
          name: DashboardPage.routeName,
          builder:
              (BuildContext context, GoRouterState state) =>
                  const DashboardPageBlocProvider(),
        ),
        GoRoute(
          path: IdeaSpace.routePath,
          name: IdeaSpace.routeName,
          builder: (BuildContext context, GoRouterState state) {
            final String id = state.pathParameters["id"]!.toString();
            return IdeaSpace(key: ValueKey(id), id: id);
          },
        ),
        GoRoute(
          path: '/demo-gridview',
          builder: (context, state) {
            return GridInteractionDemo();
          },
        ),
        GoRoute(
          path: SpaceDemoPage.routePath,
          builder: (context, state) {
            return SpaceDemoPage();
          },
        ),
      ],
    );
  }
}
