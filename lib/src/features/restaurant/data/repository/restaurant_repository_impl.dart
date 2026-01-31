import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../datasources/remote/remote.dart';
import '../models/request/request.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDatasource remoteDatasource;

  RestaurantRepositoryImpl(this.remoteDatasource);

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
}
