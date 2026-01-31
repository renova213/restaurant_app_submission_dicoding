import '../../../../core/core.dart';
import '../entity/entity.dart';
import '../repository/restaurant_repository.dart';

class GetDetailRestaurantUsecase
    implements UseCase<DetailRestaurantEntity, String> {
  final RestaurantRepository repository;

  GetDetailRestaurantUsecase(this.repository);

  @override
  Future<Either<AppError, DetailRestaurantEntity>> call(String id) {
    return repository.getDetailRestaurant(id);
  }
}
