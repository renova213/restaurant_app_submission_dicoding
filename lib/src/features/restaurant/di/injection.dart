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

  // Cubit
  locator.registerFactory<RestaurantCubit>(
    () => RestaurantCubit(locator(), locator()),
  );

  locator.registerFactory<DetailRestaurantCubit>(
    () => DetailRestaurantCubit(locator()),
  );

  locator.registerFactory<AddReviewRestaurantCubit>(
    () => AddReviewRestaurantCubit(locator()),
  );

  locator.registerFactory<ReviewCubit>(() => ReviewCubit());

  locator.registerFactory<ThemeCubit>(() => ThemeCubit());
}
