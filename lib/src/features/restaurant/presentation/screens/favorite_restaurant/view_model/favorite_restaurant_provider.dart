import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../domain/domain.dart';

class FavoriteRestaurantProvider extends ChangeNotifier {
  final FavoriteRestaurantUsecase favoriteRestaurantUsecase;

  FavoriteRestaurantProvider(this.favoriteRestaurantUsecase);

  AppState _favoriteRestaurantState = AppState.initial;
  AppState get favoriteRestaurantState => _favoriteRestaurantState;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  late List<RestaurantItemEntity> _favoriteRestaurants;
  List<RestaurantItemEntity> get favoriteRestaurants => _favoriteRestaurants;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> fetchFavoriteRestaurants() async {
    changeAppState(AppState.loading);

    final result = await favoriteRestaurantUsecase(NoParams());

    if (_disposed) return;

    result.fold(
      (error) {
        _errorMessage = error.message;
        AppLog.logger.e(error.message);
        AppLog.logger.e(error.originalError);
        changeAppState(AppState.error);
      },
      (favoriteRestaurants) {
        _favoriteRestaurants = favoriteRestaurants;
        changeAppState(
          _favoriteRestaurants.isEmpty ? AppState.empty : AppState.loaded,
        );
      },
    );
  }

  void changeAppState(AppState state) {
    if (_disposed) return;
    if (_favoriteRestaurantState == state) return;

    _favoriteRestaurantState = state;
    notifyListeners();
  }
}
