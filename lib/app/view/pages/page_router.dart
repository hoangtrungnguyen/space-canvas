import 'package:dashboard/view/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ideascape/app/view/bloc/auth/auth_bloc.dart';
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
          path: IdeaSpace.routePath,
          name: IdeaSpace.routeName,
          builder: (BuildContext context, GoRouterState state) {
            final String id = state.pathParameters["id"]!.toString();
            return IdeaSpace(key: ValueKey(id), id: id);
          },
        ),
        GoRoute(
          path: DashboardPage.routePath,
          name: DashboardPage.routeName,
          builder: (_,_) {
            return DashboardPageBlocProvider();
          }
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
