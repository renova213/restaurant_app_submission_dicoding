import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../models/request/request.dart';
import '../../models/response/response.dart';
import 'endpoint.dart';
import 'restaurant_remote_datasource.dart';

class RestaurantRemoteDatasourceImpl implements RestaurantRemoteDatasource {
  final ApiService apiService;
  RestaurantRemoteDatasourceImpl(this.apiService);

  @override
  Future<RestaurantResponse> getRestaurants() async {
    try {
      final response = await apiService.dio.get(
        RestaurantEndpoint.listOfRestaurant,
      );

      return RestaurantResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  @override
  Future<RestaurantResponse> searchRestaurants(String query) async {
    try {
      final response = await apiService.dio.get(
        RestaurantEndpoint.searchRestaurant,
        queryParameters: {"q": query},
      );

      return RestaurantResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  @override
  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    try {
      final response = await apiService.dio.get(
        RestaurantEndpoint.detailOfRestaurant(id),
      );

      return DetailRestaurantResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  @override
  Future<List<DetailRestaurantCustomerReviewResponse>> addReviewRestaurant(
    AddReviewRestaurantRequest request,
  ) async {
    try {
      final response = await apiService.dio.post(
        RestaurantEndpoint.addReviewRestaurant,
        data: request.toJson(),
      );

      return response.data["customerReviews"] != null
          ? (response.data["customerReviews"] as List)
                .map((e) => DetailRestaurantCustomerReviewResponse.fromJson(e))
                .toList()
          : [];
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
