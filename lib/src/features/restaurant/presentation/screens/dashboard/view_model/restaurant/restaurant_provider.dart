import 'package:flutter/material.dart';

import '../../../../../../../core/core.dart';
import '../../../../../domain/domain.dart';

class RestaurantProvider extends ChangeNotifier {
  final GetRestaurantsUseCase getRestaurantsUseCase;
  final GetSearchRestaurantsUsecase getSearchRestaurantsUsecase;

  RestaurantProvider(
    this.getRestaurantsUseCase,
    this.getSearchRestaurantsUsecase,
  );

  AppState _restaurantState = AppState.initial;
  AppState get restaurantState => _restaurantState;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  late RestaurantEntity _restaurant;
  RestaurantEntity get restaurant => _restaurant;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> fetchRestaurants({String query = ''}) async {
    changeAppState(AppState.loading);

    final result = query.isEmpty
        ? await getRestaurantsUseCase(NoParams())
        : await getSearchRestaurantsUsecase(query);

    if (_disposed) return;

    result.fold(
      (error) {
        _errorMessage = error.message;
        AppLog.logger.e(error.message);
        AppLog.logger.e(error.originalError);
        changeAppState(AppState.error);
      },
      (restaurant) {
        _restaurant = restaurant;
        changeAppState(AppState.loaded);
      },
    );
  }

  void changeAppState(AppState state) {
    if (_disposed) return;
    if (_restaurantState == state) return;

    _restaurantState = state;
    notifyListeners();
  }
}
