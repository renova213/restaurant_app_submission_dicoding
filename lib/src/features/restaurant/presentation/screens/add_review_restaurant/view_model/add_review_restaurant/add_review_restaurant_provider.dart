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

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<List<DetailRestaurantCustomerReviewEntity>> addReview(
    AddRestaurantReviewParam request,
  ) async {
    changeAppState(AppState.loading);

    final result = await postAddReviewRestaurantUsecase.call(request);

    if (_disposed) return [];

    return result.fold(
      (error) {
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

  void changeAppState(AppState state) {
    if (_disposed) return;
    if (_addReviewState == state) return;

    _addReviewState = state;
    notifyListeners();
  }
}
