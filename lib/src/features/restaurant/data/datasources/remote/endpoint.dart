class RestaurantEndpoint {
  static const String listOfRestaurant = '/list';
  static const String searchRestaurant = '/search';
  static const String addReviewRestaurant = "/review";
  static String detailOfRestaurant(String id) {
    return '/detail/$id';
  }
}
