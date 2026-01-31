import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/core.dart';
import '../../../../../domain/domain.dart';
import '../../../../../domain/usecase/params/params.dart';
import 'add_review_restaurant_state.dart';

class AddReviewRestaurantCubit extends Cubit<AddReviewRestaurantState> {
  final PostAddReviewRestaurantUsecase postAddReviewRestaurantUsecase;

  AddReviewRestaurantCubit(this.postAddReviewRestaurantUsecase)
    : super(const AddReviewRestaurantInitial());

  // MARK: APIs
  Future<List<DetailRestaurantCustomerReviewEntity>> addReview(
    AddRestaurantReviewParam request,
  ) async {
    emit(const AddReviewRestaurantLoading());

    final result = await postAddReviewRestaurantUsecase.call(request);

    return result.fold(
      (error) {
        emit(AddReviewRestaurantError(error.message));
        AppLog.logger.e(error.message);
        AppLog.logger.e(error.originalError);
        return [];
      },
      (customerReviews) {
        emit(AddReviewRestaurantLoaded());
        return customerReviews;
      },
    );
  }
}
