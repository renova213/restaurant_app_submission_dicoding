import '../../models/response/response.dart';

abstract class RestaurantLocalDataSource {
  Future<void> insertFavorite(RestaurantItemResponse restaurant);
  Future<void> removeFavorite(String id);
  Future<List<RestaurantItemResponse>> getFavorites();
  Future<bool> isFavorite(String id);
}
