import '../../../../core/core.dart';
import '../repository/restaurant_repository.dart';

class RemoveFavoriteRestaurantUsecase implements UseCase<void, String> {
  final RestaurantRepository repository;

  RemoveFavoriteRestaurantUsecase(this.repository);
  @override
  Future<Either<AppError, void>> call(String id) async {
    return repository.removeFavoriteRestaurant(id);
  }
}
