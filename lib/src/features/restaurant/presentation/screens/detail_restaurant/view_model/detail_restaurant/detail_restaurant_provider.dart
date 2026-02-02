import 'package:flutter/material.dart';

import '../../../../../../../core/core.dart';
import '../../../../../domain/domain.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final GetDetailRestaurantUsecase getDetailRestaurantsUseCase;

  DetailRestaurantProvider(this.getDetailRestaurantsUseCase);

  AppState _restaurantState = AppState.initial;
  AppState get restaurantState => _restaurantState;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  late DetailRestaurantEntity _detailRestaurant;
  DetailRestaurantEntity get detailRestaurant => _detailRestaurant;

  // MARK: APIs
  Future<void> fetchDetailRestaurants(String id) async {
    changeAppState(AppState.loading);

    final result = await getDetailRestaurantsUseCase.call(id);

    result.fold(
      (error) {
        changeAppState(AppState.error);
        _errorMessage = error.message;
        AppLog.logger.e(error.message);
        AppLog.logger.e(error.originalError);

        changeAppState(AppState.error);
      },
      (detailRestaurant) {
        _detailRestaurant = detailRestaurant;
        changeAppState(AppState.loaded);
      },
    );
  }

  //MARK: Commons
  void changeAppState(AppState state) {
    if (_restaurantState == state) return;

    _restaurantState = state;
    notifyListeners();
  }
}
