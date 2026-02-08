import 'package:flutter/material.dart';

import '../../../../../../../core/core.dart';
import '../../../../../domain/domain.dart';

class ReviewProvider extends ChangeNotifier {
  AppState _reviewState = AppState.initial;
  AppState get reviewState => _reviewState;

  List<DetailRestaurantCustomerReviewEntity> _customerReviews = [];
  List<DetailRestaurantCustomerReviewEntity> get customerReviews =>
      _customerReviews;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> initCustomerReviews(
    List<DetailRestaurantCustomerReviewEntity> customerReviews,
  ) async {
    changeAppState(AppState.loading);

    await Future.delayed(const Duration(seconds: 1));

    if (_disposed) return;

    _customerReviews = customerReviews;
    changeAppState(AppState.loaded);
  }

  void changeAppState(AppState state) {
    if (_disposed) return;
    if (_reviewState == state) return;

    _reviewState = state;
    notifyListeners();
  }
}
