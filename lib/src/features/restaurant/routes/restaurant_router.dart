import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../presentation/navigation/navigation.dart';
import '../presentation/screens/add_review_restaurant/add_review_restaurant.dart';
import '../presentation/screens/dashboard/dashboard.dart';
import '../presentation/screens/detail_restaurant/detail_restaurant.dart';
import '../presentation/screens/review_screen/review.dart';
import 'routes.dart';

final restaurantRouter = [
  GoRoute(
    path: RestaurantRoutes.dashboard,
    name: RestaurantRoutes.dashboard,
    builder: (context, state) {
      return ChangeNotifierProvider(
        create: (_) =>
            RestaurantProvider(locator(), locator())..fetchRestaurants(),
        child: const RestaurantDashboardScreen(),
      );
    },
  ),

  GoRoute(
    path: RestaurantRoutes.detailRestaurant,
    name: RestaurantRoutes.detailRestaurant,
    builder: (context, state) {
      final args = state.extra as RestaurantDetailArgs;

      return ChangeNotifierProvider(
        create: (_) =>
            DetailRestaurantProvider(locator(), locator(), locator(), locator())
              ..fetchDetailRestaurants(args.restaurantId)
              ..checkIsFavorite(args.restaurantId),
        child: DetailRestaurantScreen(
          index: args.index,
          restaurantId: args.restaurantId,
          heroTagId: args.heroTagId,
        ),
      );
    },
  ),

  GoRoute(
    path: RestaurantRoutes.addReviewRestaurant,
    name: RestaurantRoutes.addReviewRestaurant,
    builder: (context, state) {
      final args = state.extra as AddReviewRestaurantArgs;

      return ChangeNotifierProvider(
        create: (_) => AddReviewRestaurantProvider(locator()),
        child: AddReviewRestaurantScreen(
          restaurantId: args.restaurantId,
          onReviewSubmitted: args.onReviewSubmitted,
        ),
      );
    },
  ),

  GoRoute(
    path: RestaurantRoutes.reviews,
    name: RestaurantRoutes.reviews,
    builder: (context, state) {
      final args = state.extra as ReviewArgs;

      return ChangeNotifierProvider(
        create: (_) =>
            ReviewProvider()..initCustomerReviews(args.customerReviews),
        child: ReviewScreen(
          restaurantId: args.restaurantId,
          customerReviews: args.customerReviews,
        ),
      );
    },
  ),
];
