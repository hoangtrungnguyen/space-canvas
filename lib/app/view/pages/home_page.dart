import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            context.push('/canvas');
          },
          child: Text("Canvas"),
        ),
        ElevatedButton(
          onPressed: () {
            context.push('/document');
          },
          child: Text("Document"),
        ),
        ElevatedButton(
          onPressed: () {
            context.push('/demo-gridview');
          },
          child: Text("Demo GridView"),
        ),
      ],
    );
  }
}
