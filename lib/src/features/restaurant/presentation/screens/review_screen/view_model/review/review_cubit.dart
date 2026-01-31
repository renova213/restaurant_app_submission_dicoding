import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/domain.dart';
import '../view_model.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(const ReviewInitial());

  // MARK: Commons
  void initCustomerReviews(
    List<DetailRestaurantCustomerReviewEntity> customerReviews,
  ) async {
    emit(ReviewLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(ReviewLoaded(customerReviews: customerReviews));
  }
}
