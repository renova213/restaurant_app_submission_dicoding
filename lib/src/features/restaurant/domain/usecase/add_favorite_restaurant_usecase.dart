import '../../../../core/core.dart';
import '../entity/entity.dart';
import '../repository/restaurant_repository.dart';

class AddFavoriteRestaurantUsecase
    implements UseCase<void, RestaurantItemEntity> {
  final RestaurantRepository repository;

  AddFavoriteRestaurantUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(RestaurantItemEntity restaurant) async {
    return await repository.addFavoriteRestaurant(restaurant);
  }
}
