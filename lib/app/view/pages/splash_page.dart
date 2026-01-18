import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ideascape/features/dashboard/view/pages/dashboard_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToDashboard();
  }

  Future<void> _navigateToDashboard() async {
    // Add any initialization tasks here (e.g., loading preferences, checking auth)
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      context.go(DashboardPage.routePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lightbulb_circle,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            Text(
              "Ideascape",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
