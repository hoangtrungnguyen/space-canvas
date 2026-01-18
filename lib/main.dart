import 'package:flutter/material.dart';
import 'package:ideascape/app/view/app_root.dart';
import 'package:ideascape/boostrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const AppRoot());
}
