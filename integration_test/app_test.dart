import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/main.dart' as app;

import 'package:restaurant_app/src/core/core.dart';
import 'package:restaurant_app/src/features/onboarding/presentation/screens/navigationBar/screen/app_navigation_bar.dart';
import 'package:restaurant_app/src/features/restaurant/presentation/screens/dashboard/screen/restaurant_dashboard_screen.dart';
import 'package:restaurant_app/src/features/restaurant/presentation/screens/favorite_restaurant/screen/favorite_restaurant_screen.dart';
import 'package:restaurant_app/src/features/setting/presentation/screen/setting_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> startApp(WidgetTester tester) async {
    app.main(isTest: true);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
  }

  setUp(() async {
    await locator.reset();
  });

  group('Splash Screen', () {
    testWidgets('Should display splash content', (tester) async {
      await startApp(tester);
      expect(find.text('Restaurant App'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('Should navigate to NavigationBar', (tester) async {
      await startApp(tester);
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.byType(AppNavigationBar), findsOneWidget);
    });
  });

  group('Navigation Bar', () {
    testWidgets('Default tab should be Dashboard', (tester) async {
      await startApp(tester);
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(RestaurantDashboardScreen), findsOneWidget);
    });

    testWidgets('Should switch to Favorite tab when tapped', (tester) async {
      await startApp(tester);
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(FavoriteRestaurantScreen), findsOneWidget);
    });

    testWidgets('Should switch to Setting tab when tapped', (tester) async {
      await startApp(tester);
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(SettingScreen), findsOneWidget);
    });
  });
}
