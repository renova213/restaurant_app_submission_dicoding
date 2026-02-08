import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../presentation/screens/navigationBar/screen/app_navigation_bar.dart';
import '../presentation/screens/navigationBar/view_model/navigation_provider.dart';
import '../presentation/screens/splash/screen/app_splash_screen.dart';
import '../presentation/screens/splash/view_model/app_splash_provider.dart';
import 'routes.dart';

final onboardingRouter = [
  GoRoute(
    path: OnboardingRoutes.splash,
    name: OnboardingRoutes.splash,
    builder: (context, state) {
      return ChangeNotifierProvider(
        create: (_) => AppSplashProvider()..init(),
        child: const AppSplashScreen(),
      );
    },
  ),

  GoRoute(
    path: OnboardingRoutes.navBar,
    name: OnboardingRoutes.navBar,
    builder: (context, state) {
      return ChangeNotifierProvider(
        create: (_) => NavigationProvider(),
        child: const AppNavigationBar(),
      );
    },
  ),
];
