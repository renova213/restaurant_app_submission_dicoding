import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../features/onboarding/routes/routes.dart';
import '../features/restaurant/restaurant.dart';

final GoRouter appRouter = GoRouter(
  observers: kDebugMode ? [ChuckerFlutter.navigatorObserver] : [],
  initialLocation: OnboardingRoutes.splash,
  routes: [
    GoRoute(path: '/', redirect: (_, _) => '/splash'),
    ...onboardingRouter,
    ...restaurantRouter,
  ],
);
