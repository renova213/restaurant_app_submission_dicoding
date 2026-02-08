import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/core/core.dart';
import 'package:restaurant_app/src/di/app_injection.dart';
import 'package:restaurant_app/src/features/restaurant/presentation/screens/favorite_restaurant/screen/favorite_restaurant_screen.dart';
import 'package:restaurant_app/src/features/restaurant/presentation/screens/favorite_restaurant/view_model/favorite_restaurant_provider.dart';
import 'package:restaurant_app/src/features/restaurant/presentation/screens/favorite_restaurant/widgets/widgets.dart';
import 'package:restaurant_app/src/shared_components/shared_components.dart';

import 'favorite_restaurant_screen_widget_test.mocks.dart';

@GenerateMocks([FavoriteRestaurantProvider])
void main() {
  late MockFavoriteRestaurantProvider mockProvider;

  Widget createWidget() {
    return MaterialApp(
      home: ChangeNotifierProvider<FavoriteRestaurantProvider>.value(
        value: mockProvider,
        child: const FavoriteRestaurantScreen(),
      ),
    );
  }

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    locator.reset();
    await injection();
    mockProvider = MockFavoriteRestaurantProvider();

    when(mockProvider.fetchFavoriteRestaurants()).thenAnswer((_) async {});
    when(mockProvider.addListener(any)).thenReturn(null);
    when(mockProvider.removeListener(any)).thenReturn(null);
  });

  group('FavoriteRestaurantScreen Widget Test', () {
    testWidgets('Screen renders without crashing', (tester) async {
      when(mockProvider.favoriteRestaurantState).thenReturn(AppState.initial);
      when(mockProvider.favoriteRestaurants).thenReturn([]);

      await tester.pumpWidget(createWidget());

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Show title "Favorite Restaurants"', (tester) async {
      when(mockProvider.favoriteRestaurantState).thenReturn(AppState.initial);
      when(mockProvider.favoriteRestaurants).thenReturn([]);

      await tester.pumpWidget(createWidget());

      expect(find.text('Favorite Restaurants'), findsOneWidget);
    });

    testWidgets('Show skeleton indicator when state is loading', (
      tester,
    ) async {
      when(mockProvider.favoriteRestaurantState).thenReturn(AppState.loading);
      when(mockProvider.favoriteRestaurants).thenReturn([]);

      await tester.pumpWidget(createWidget());

      expect(find.byType(FavoriteRestaurantListSkeleton), findsOneWidget);
    });

    testWidgets('Show listview when state is loaded', (tester) async {
      when(mockProvider.favoriteRestaurantState).thenReturn(AppState.loaded);

      await tester.pumpWidget(createWidget());

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Show error message and refresh button', (tester) async {
      when(mockProvider.favoriteRestaurantState).thenReturn(AppState.error);
      when(mockProvider.errorMessage).thenReturn('Something went wrong');
      when(mockProvider.favoriteRestaurants).thenReturn([]);

      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('Refresh'), findsOneWidget);
      expect(find.byType(GeneralButton), findsOneWidget);
    });
  });
}
