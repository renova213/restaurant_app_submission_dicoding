import '../../../../core/core.dart';
import '../entity/entity.dart';
import '../repository/restaurant_repository.dart';

class GetRestaurantsUseCase implements UseCase<RestaurantEntity, NoParams> {
  final RestaurantRepository repository;

  GetRestaurantsUseCase(this.repository);

  @override
  Future<Either<AppError, RestaurantEntity>> call(NoParams params) {
    return repository.getRestaurants();
  }
}
