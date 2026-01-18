import 'package:flutter/material.dart';
import 'js_interop_service.dart';

class DemoJsInteropPage extends StatefulWidget {
  const DemoJsInteropPage({super.key});

  @override
  State<DemoJsInteropPage> createState() => _DemoJsInteropPageState();
}

class _DemoJsInteropPageState extends State<DemoJsInteropPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          children: [
            ElevatedButton(
              onPressed: () {
                final jsInteropService = JsInteropService();
                jsInteropService.showAlert();
              },
              child: Text("Show Alert"),
            ),
            ElevatedButton(
              onPressed: () {
                requestFullScreen();
              },
              child: Text("Full Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
