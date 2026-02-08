import 'package:flutter/material.dart';

import 'my_app.dart';
import 'src/bootstrap/app_bootstrap.dart';

Future<void> main({bool isTest = false}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap(isTest: isTest);

  runApp(const MyApp());
}
