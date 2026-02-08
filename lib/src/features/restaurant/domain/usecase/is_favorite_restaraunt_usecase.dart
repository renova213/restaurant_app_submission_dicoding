import '../../../../core/core.dart';
import '../repository/restaurant_repository.dart';

class IsFavoriteRestaurantUsecase implements UseCase<bool, String> {
  final RestaurantRepository repository;

  IsFavoriteRestaurantUsecase(this.repository);

  @override
  Future<Either<AppError, bool>> call(String id) async {
    return await repository.isFavoriteRestaurant(id);
  }
}
