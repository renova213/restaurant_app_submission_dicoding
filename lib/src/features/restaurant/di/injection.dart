import '../../../core/core.dart';
import '../data/data.dart';
import '../domain/domain.dart';
import '../presentation/presentation.dart';
import '../presentation/screens/favorite_restaurant/view_model/favorite_restaurant_provider.dart';

Future<void> restaurantInjection() async {
  // Datasource
  locator.registerLazySingleton<RestaurantRemoteDatasource>(
    () => RestaurantRemoteDatasourceImpl(locator()),
  );

  locator.registerLazySingleton<RestaurantLocalDataSource>(
    () => RestaurantLocalDataSourceImpl(locator()),
  );

  // Repository
  locator.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(locator(), locator()),
  );

  // Usecase
  locator.registerLazySingleton<GetRestaurantsUseCase>(
    () => GetRestaurantsUseCase(locator()),
  );

  locator.registerLazySingleton<GetSearchRestaurantsUsecase>(
    () => GetSearchRestaurantsUsecase(locator()),
  );

  locator.registerLazySingleton<GetDetailRestaurantUsecase>(
    () => GetDetailRestaurantUsecase(locator()),
  );

  locator.registerLazySingleton<PostAddReviewRestaurantUsecase>(
    () => PostAddReviewRestaurantUsecase(locator()),
  );

  locator.registerLazySingleton<IsFavoriteRestaurantUsecase>(
    () => IsFavoriteRestaurantUsecase(locator()),
  );

  locator.registerLazySingleton<AddFavoriteRestaurantUsecase>(
    () => AddFavoriteRestaurantUsecase(locator()),
  );

  locator.registerLazySingleton<RemoveFavoriteRestaurantUsecase>(
    () => RemoveFavoriteRestaurantUsecase(locator()),
  );

  locator.registerLazySingleton<FavoriteRestaurantUsecase>(
    () => FavoriteRestaurantUsecase(locator()),
  );

  // Providers
  locator.registerFactory<RestaurantProvider>(
    () => RestaurantProvider(locator(), locator()),
  );

  locator.registerFactory<DetailRestaurantProvider>(
    () => DetailRestaurantProvider(locator(), locator(), locator(), locator()),
  );

  locator.registerFactory<AddReviewRestaurantProvider>(
    () => AddReviewRestaurantProvider(locator()),
  );

  locator.registerFactory<ReviewProvider>(() => ReviewProvider());

  locator.registerFactory<FavoriteRestaurantProvider>(
    () => FavoriteRestaurantProvider(locator()),
  );

  locator.registerLazySingleton<ThemeProvider>(() => ThemeProvider());
}
