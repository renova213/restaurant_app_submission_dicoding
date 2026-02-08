import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../datasources/local/local.dart';
import '../datasources/remote/remote.dart';
import '../models/request/request.dart';
import '../models/response/response.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDatasource remoteDatasource;
  final RestaurantLocalDataSource localDatasource;

  RestaurantRepositoryImpl(this.remoteDatasource, this.localDatasource);

  @override
  Future<Either<AppError, RestaurantEntity>> getRestaurants() {
    return safeApiCall(() async {
      final restaurantResponse = await remoteDatasource.getRestaurants();
      return restaurantResponse.toEntity();
    });
  }

  @override
  Future<Either<AppError, RestaurantEntity>> searchRestaurants(String q) {
    return safeApiCall(() async {
      final restaurantResponse = await remoteDatasource.searchRestaurants(q);
      return restaurantResponse.toEntity();
    });
  }

  @override
  Future<Either<AppError, DetailRestaurantEntity>> getDetailRestaurant(
    String id,
  ) {
    return safeApiCall(() async {
      final detailRestaurantResponse = await remoteDatasource
          .getDetailRestaurant(id);
      return detailRestaurantResponse.toEntity();
    });
  }

  @override
  Future<Either<AppError, List<DetailRestaurantCustomerReviewEntity>>>
  addReviewRestaurant({
    required String id,
    required String review,
    required String name,
  }) {
    return safeApiCall(() async {
      final detailRestaurantResponse = await remoteDatasource
          .addReviewRestaurant(
            AddReviewRestaurantRequest(id: id, name: name, review: review),
          );

      return detailRestaurantResponse.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<AppError, void>> addFavoriteRestaurant(
    RestaurantItemEntity restaurant,
  ) {
    return safeApiCall(() async {
      final model = RestaurantItemResponse(
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description,
        pictureId: restaurant.pictureId,
        city: restaurant.city,
        rating: restaurant.rating,
      );

      await localDatasource.insertFavorite(model);
    });
  }

  @override
  Future<Either<AppError, void>> removeFavoriteRestaurant(String id) {
    return safeApiCall(() async {
      await localDatasource.removeFavorite(id);
    });
  }

  @override
  Future<Either<AppError, List<RestaurantItemEntity>>>
  getFavoriteRestaurants() {
    return safeApiCall(() async {
      final result = await localDatasource.getFavorites();
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<AppError, bool>> isFavoriteRestaurant(String id) {
    return safeApiCall(() async {
      return await localDatasource.isFavorite(id);
    });
  }
}
