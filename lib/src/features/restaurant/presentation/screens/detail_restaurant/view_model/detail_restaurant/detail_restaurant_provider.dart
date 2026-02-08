import 'package:flutter/material.dart';

import '../../../../../../../core/core.dart';
import '../../../../../domain/domain.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final GetDetailRestaurantUsecase getDetailRestaurantsUseCase;
  final AddFavoriteRestaurantUsecase addFavoriteRestaurantUsecase;
  final IsFavoriteRestaurantUsecase isFavoriteRestaurantUsecase;
  final RemoveFavoriteRestaurantUsecase removeFavoriteRestaurantUsecase;

  DetailRestaurantProvider(
    this.getDetailRestaurantsUseCase,
    this.addFavoriteRestaurantUsecase,
    this.isFavoriteRestaurantUsecase,
    this.removeFavoriteRestaurantUsecase,
  );

  AppState _restaurantState = AppState.initial;
  AppState get restaurantState => _restaurantState;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  late DetailRestaurantEntity _detailRestaurant;
  DetailRestaurantEntity get detailRestaurant => _detailRestaurant;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> fetchDetailRestaurants(String id) async {
    changeAppState(AppState.loading);

    final result = await getDetailRestaurantsUseCase.call(id);

    if (_disposed) return;

    result.fold(
      (error) {
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

  Future<bool> toggleFavorite() async {
    return isFavorite
        ? await removeFavoriteRestaurant()
        : await addFavoriteRestaurant();
  }

  Future<bool> addFavoriteRestaurant() async {
    final result = await addFavoriteRestaurantUsecase.call(
      RestaurantItemEntity(
        id: detailRestaurant.id,
        name: detailRestaurant.name,
        description: detailRestaurant.description,
        pictureId: detailRestaurant.pictureId,
        city: detailRestaurant.city,
        rating: detailRestaurant.rating,
      ),
    );

    if (_disposed) return false;

    return result.fold(
      (error) {
        AppLog.logger.e(error.message);
        safeNotify();
        return false;
      },
      (isFavorite) async {
        await checkIsFavorite(detailRestaurant.id);
        return true;
      },
    );
  }

  Future<bool> removeFavoriteRestaurant() async {
    final result = await removeFavoriteRestaurantUsecase.call(
      detailRestaurant.id,
    );

    if (_disposed) return false;

    return result.fold(
      (error) {
        AppLog.logger.e(error.message);
        safeNotify();
        return false;
      },
      (isFavorite) async {
        await checkIsFavorite(detailRestaurant.id);
        return true;
      },
    );
  }

  Future<void> checkIsFavorite(String id) async {
    final result = await isFavoriteRestaurantUsecase.call(id);

    if (_disposed) return;

    result.fold(
      (error) {
        AppLog.logger.e(error.message);
      },
      (isFavorite) {
        _isFavorite = isFavorite;
        safeNotify();
      },
    );
  }

  void changeAppState(AppState state) {
    if (_disposed) return;
    if (_restaurantState == state) return;

    _restaurantState = state;
    safeNotify();
  }

  void safeNotify() {
    if (!_disposed) {
      notifyListeners();
    }
  }
}
