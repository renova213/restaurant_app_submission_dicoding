import '../../../domain/domain.dart';

class ReviewArgs {
  final String restaurantId;
  final List<DetailRestaurantCustomerReviewEntity> customerReviews;

  const ReviewArgs({required this.restaurantId, required this.customerReviews});
}
