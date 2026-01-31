import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/onboarding/presentation/screens/splash/screen/app_splash_screen.dart';
import '../features/onboarding/presentation/screens/splash/view_model/app_splash_cubit.dart';
import '../features/restaurant/restaurant.dart';
import 'app_route.dart';

final GoRouter appRouter = GoRouter(
  observers: kDebugMode ? [ChuckerFlutter.navigatorObserver] : [],
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(path: '/', redirect: (_, _) => '/splash'),
    GoRoute(
      path: '/splash',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => AppSplashCubit()..init(),
          child: AppSplashScreen(),
        );
      },
    ),
    ...restaurantRouter,
  ],
);
