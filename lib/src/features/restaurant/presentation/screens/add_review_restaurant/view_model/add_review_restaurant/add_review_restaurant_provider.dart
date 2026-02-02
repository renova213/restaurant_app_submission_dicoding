import 'package:flutter/material.dart';

import '../../../../../../../core/core.dart';
import '../../../../../domain/domain.dart';
import '../../../../../domain/usecase/params/params.dart';

class AddReviewRestaurantProvider extends ChangeNotifier {
  final PostAddReviewRestaurantUsecase postAddReviewRestaurantUsecase;
  AddReviewRestaurantProvider(this.postAddReviewRestaurantUsecase);

  AppState _addReviewState = AppState.initial;
  AppState get addReviewState => _addReviewState;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  //MARK: APIs
  Future<List<DetailRestaurantCustomerReviewEntity>> addReview(
    AddRestaurantReviewParam request,
  ) async {
    changeAppState(AppState.loading);

    final result = await postAddReviewRestaurantUsecase.call(request);

    return result.fold(
      (error) {
        AppLog.logger.e("error message: ${error.message}");
        AppLog.logger.e("original error: ${error.originalError}");
        _errorMessage = error.message;

        changeAppState(AppState.error);
        return [];
      },
      (customerReviews) {
        changeAppState(AppState.loaded);
        return customerReviews;
      },
    );
  }

  //MARK: Commons
  void changeAppState(AppState state) {
    if (_addReviewState == state) return;

    _addReviewState = state;
    notifyListeners();
  }
}
