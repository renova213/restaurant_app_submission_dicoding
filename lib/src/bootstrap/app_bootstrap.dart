import 'package:flutter/services.dart';

import '../di/app_injection.dart';

Future<void> bootstrap() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await injection();
}
