import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../core/core.dart';
import '../features/restaurant/restaurant.dart';

Future<void> injection({GlobalKey<NavigatorState>? navigatorKey}) async {
  // MARK: Core
  locator.registerLazySingleton<ApiService>(
    () => ApiService(baseUrl: AppConfig.mainBaseUrl),
  );

  locator.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // MARK: Features
  await restaurantInjection();
}
