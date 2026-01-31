import '../../models/request/request.dart';
import '../../models/response/response.dart';

abstract class RestaurantRemoteDatasource {
  Future<RestaurantResponse> getRestaurants();
  Future<RestaurantResponse> searchRestaurants(String query);
  Future<DetailRestaurantResponse> getDetailRestaurant(String id);
  Future<List<DetailRestaurantCustomerReviewResponse>> addReviewRestaurant(
    AddReviewRestaurantRequest request,
  );
}
