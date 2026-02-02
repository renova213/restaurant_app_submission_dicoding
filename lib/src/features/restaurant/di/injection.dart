import '../../../core/core.dart';
import '../data/data.dart';
import '../domain/domain.dart';
import '../presentation/presentation.dart';

Future<void> restaurantInjection() async {
  // Datasource
  locator.registerLazySingleton<RestaurantRemoteDatasource>(
    () => RestaurantRemoteDatasourceImpl(locator()),
  );

  // Repository
  locator.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(locator()),
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

  // Providers
  locator.registerFactory<RestaurantProvider>(
    () => RestaurantProvider(locator(), locator()),
  );

  locator.registerFactory<DetailRestaurantProvider>(
    () => DetailRestaurantProvider(locator()),
  );

  locator.registerFactory<AddReviewRestaurantProvider>(
    () => AddReviewRestaurantProvider(locator()),
  );

  locator.registerFactory<ReviewProvider>(() => ReviewProvider());

  locator.registerLazySingleton<ThemeProvider>(() => ThemeProvider());
}
