import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/src/core/core.dart';
import 'package:restaurant_app/src/features/restaurant/restaurant.dart';

import 'restaurant_provider_test.mocks.dart';

@GenerateMocks([GetRestaurantsUseCase, GetSearchRestaurantsUsecase])
void main() {
  late MockGetRestaurantsUseCase mockGetRestaurantsUseCase;
  late MockGetSearchRestaurantsUsecase mockGetSearchRestaurantsUsecase;
  late RestaurantProvider provider;

  setUp(() {
    mockGetRestaurantsUseCase = MockGetRestaurantsUseCase();
    mockGetSearchRestaurantsUsecase = MockGetSearchRestaurantsUsecase();

    provider = RestaurantProvider(
      mockGetRestaurantsUseCase,
      mockGetSearchRestaurantsUsecase,
    );
  });

  final restaurant = RestaurantEntity(
    restaurantList: [
      RestaurantItemEntity(
        id: "1",
        name: "pizza hut",
        description: "Delicious pizza",
        pictureId: "pizza-hut.jpg",
        city: "Jakarta",
        rating: 4.5,
      ),
    ],
  );

  group('RestaurantProvider', () {
    test(
      'SUCCESS: fetchRestaurants without query → loading → loaded',
      () async {
        when(
          mockGetRestaurantsUseCase.call(any),
        ).thenAnswer((_) async => Right(restaurant));

        provider.changeAppState(AppState.loading);
        expect(provider.restaurantState, AppState.loading);

        await provider.fetchRestaurants();

        expect(provider.restaurantState, AppState.loaded);
        expect(provider.errorMessage, isEmpty);
        expect(provider.restaurant, restaurant);

        verify(mockGetRestaurantsUseCase.call(any)).called(1);
        verifyNever(mockGetSearchRestaurantsUsecase.call(any));
      },
    );

    test('SUCCESS: fetchRestaurants with query → loading → loaded', () async {
      when(
        mockGetSearchRestaurantsUsecase.call(any),
      ).thenAnswer((_) async => Right(restaurant));

      provider.changeAppState(AppState.loading);
      expect(provider.restaurantState, AppState.loading);

      await provider.fetchRestaurants(query: 'pizza hut');

      expect(provider.restaurantState, AppState.loaded);
      expect(provider.restaurant, restaurant);

      verify(mockGetSearchRestaurantsUsecase.call('pizza hut')).called(1);
      verifyNever(mockGetRestaurantsUseCase.call(any));
    });

    test('ERROR: fetchRestaurants without query → loading → error', () async {
      final failure = AppError(
        message: 'Server error',
        originalError: Exception('500'),
      );

      when(
        mockGetRestaurantsUseCase.call(any),
      ).thenAnswer((_) async => Left(failure));

      provider.changeAppState(AppState.loading);
      expect(provider.restaurantState, AppState.loading);

      await provider.fetchRestaurants();

      expect(provider.restaurantState, AppState.error);
      expect(provider.errorMessage, 'Server error');

      verify(mockGetRestaurantsUseCase.call(any)).called(1);
    });

    test('ERROR: fetchRestaurants with query → loading → error', () async {
      final failure = AppError(
        message: 'Search failed',
        originalError: Exception('400'),
      );

      when(
        mockGetSearchRestaurantsUsecase.call(any),
      ).thenAnswer((_) async => Left(failure));

      provider.changeAppState(AppState.loading);
      expect(provider.restaurantState, AppState.loading);

      await provider.fetchRestaurants(query: 'pizza hut');

      expect(provider.restaurantState, AppState.error);
      expect(provider.errorMessage, 'Search failed');

      verify(mockGetSearchRestaurantsUsecase.call('pizza hut')).called(1);
    });
  });
}
