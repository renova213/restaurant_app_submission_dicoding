import 'package:flutter/material.dart';

import 'my_app.dart';
import 'src/bootstrap/app_bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();

  runApp(const MyApp());
}
