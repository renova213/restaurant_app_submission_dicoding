import '../../../../core/core.dart';
import '../entity/entity.dart';
import '../repository/restaurant_repository.dart';
import 'params/add_restaurant_review_param.dart';

class PostAddReviewRestaurantUsecase
    implements UseCase<void, AddRestaurantReviewParam> {
  final RestaurantRepository repository;

  PostAddReviewRestaurantUsecase(this.repository);

  @override
  Future<Either<AppError, List<DetailRestaurantCustomerReviewEntity>>> call(
    AddRestaurantReviewParam request,
  ) async {
    final result = await repository.addReviewRestaurant(
      id: request.id,
      name: request.name,
      review: request.review,
    );

    return result;
  }
}
