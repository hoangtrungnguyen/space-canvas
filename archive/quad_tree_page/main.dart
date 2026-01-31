// main.dart
// Entry point of the application.
// Sets up the Provider for state management and the main app layout.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'whiteboard_state.dart';
import 'whiteboard_widget.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WhiteboardState(),
      child: const QuadtreeWhiteboardApp(),
    ),
  );
}

class QuadtreeWhiteboardApp extends StatelessWidget {
  const QuadtreeWhiteboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quadtree Whiteboard Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D2D2D),
          elevation: 4,
        ),
      ),
      home: const WhiteboardScreen(),
    );
  }
}

class WhiteboardScreen extends StatelessWidget {
  const WhiteboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Canvas with Quadtree'),
        actions: [
          // Debug toggle switch
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Text('Debug View'),
                Consumer<WhiteboardState>(
                  builder: (context, state, child) {
                    return Switch(
                      value: state.isDebugMode,
                      onChanged: (value) {
                        state.toggleDebugMode();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: const WhiteboardWidget(),
      // Floating action button to add objects randomly
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (int i = 0; i < 1000; i++) {
            Provider.of<WhiteboardState>(
              context,
              listen: false,
            ).addRandomObject();
          }
        },
        tooltip: 'Add Random Object',
        child: const Icon(Icons.add),
      ),
    );
  }
}
