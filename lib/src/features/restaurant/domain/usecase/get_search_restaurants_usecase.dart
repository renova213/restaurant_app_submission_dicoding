import '../../../../core/core.dart';
import '../entity/entity.dart';
import '../repository/restaurant_repository.dart';

class GetSearchRestaurantsUsecase implements UseCase<RestaurantEntity, String> {
  final RestaurantRepository repository;

  GetSearchRestaurantsUsecase(this.repository);

  @override
  Future<Either<AppError, RestaurantEntity>> call(String query) {
    return repository.searchRestaurants(query);
  }
}
