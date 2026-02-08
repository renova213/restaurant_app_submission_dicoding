import '../../../../core/core.dart';
import '../entity/entity.dart';
import '../repository/restaurant_repository.dart';

class FavoriteRestaurantUsecase
    implements UseCase<List<RestaurantItemEntity>, NoParams> {
  final RestaurantRepository repository;

  FavoriteRestaurantUsecase(this.repository);

  @override
  Future<Either<AppError, List<RestaurantItemEntity>>> call(
    NoParams params,
  ) async {
    return await repository.getFavoriteRestaurants();
  }
}
