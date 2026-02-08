import '../../../../core/core.dart';
import '../entity/entity.dart';

abstract class RestaurantRepository {
  Future<Either<AppError, RestaurantEntity>> getRestaurants();
  Future<Either<AppError, RestaurantEntity>> searchRestaurants(String q);
  Future<Either<AppError, DetailRestaurantEntity>> getDetailRestaurant(
    String id,
  );
  Future<Either<AppError, List<DetailRestaurantCustomerReviewEntity>>>
  addReviewRestaurant({
    required String id,
    required String review,
    required String name,
  });
  Future<Either<AppError, void>> addFavoriteRestaurant(
    RestaurantItemEntity restaurant,
  );
  Future<Either<AppError, void>> removeFavoriteRestaurant(String id);
  Future<Either<AppError, List<RestaurantItemEntity>>> getFavoriteRestaurants();
  Future<Either<AppError, bool>> isFavoriteRestaurant(String id);
}
