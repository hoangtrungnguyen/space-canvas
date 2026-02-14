import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ideascape/aliases.dart';
import 'package:dashboard/view/bloc/dashboard_page_bloc.dart';
import 'package:dashboard/view/widgets/project_space_card.dart';
import 'package:ideascape/features/space/view/pages/space_page.dart';

import '../widgets/sidebar.dart';

class DashboardPageBlocProvider extends StatelessWidget {
  const DashboardPageBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              DashboardPageBloc(getIt())..add(DashboardPageEvent.initialized()),
      child: Builder(
        builder: (BuildContext context) {
          return BlocListener<DashboardPageBloc, DashboardPageState>(
            listener: (context, state) {
              switch (state) {
                case DashboardPageStateCreatedSpaceSuccess():
                  context.push(IdeaSpace.routePath);
                  break;
              }
            },
            child: DashboardPage(),
          );
        },
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  static const String routePath = '/dashboard';
  static const String routeName = 'Dashboard';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<DashboardPageBloc>().add(
            DashboardPageEvent.createdSpace(),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Row(
        children: [
          // Sidebar Navigation
          const Sidebar(),
          // Main Content Area
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Boards',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue[700],
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Grid of Whiteboards
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: BlocBuilder<DashboardPageBloc, DashboardPageState>(
                      builder: (context, state) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 250,
                                childAspectRatio: 1.1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                          itemCount: state.data.items.length,
                          itemBuilder: (context, index) {
                            return ProjectSpaceCard(
                              id: state.data.items[index].id,
                              title: state.data.items[index].title,
                              lastEdited: state.data.items[index].lastEdited,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
