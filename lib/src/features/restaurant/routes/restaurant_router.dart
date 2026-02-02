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
    path: RestaurantRoutes.shared.dashboard,
    name: RestaurantRoutes.shared.dashboard,
    builder: (context, state) {
      return ChangeNotifierProvider(
        create: (_) =>
            RestaurantProvider(locator(), locator())..fetchRestaurants(),
        child: const RestaurantDashboardScreen(),
      );
    },
  ),

  GoRoute(
    path: RestaurantRoutes.shared.detailRestaurant,
    name: RestaurantRoutes.shared.detailRestaurant,
    builder: (context, state) {
      final args = state.extra as RestaurantDetailArgs;

      return ChangeNotifierProvider(
        create: (_) =>
            DetailRestaurantProvider(locator())
              ..fetchDetailRestaurants(args.restaurantId),
        child: DetailRestaurantScreen(
          index: args.index,
          restaurantId: args.restaurantId,
        ),
      );
    },
  ),

  GoRoute(
    path: RestaurantRoutes.shared.addReviewRestaurant,
    name: RestaurantRoutes.shared.addReviewRestaurant,
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
    path: RestaurantRoutes.shared.reviews,
    name: RestaurantRoutes.shared.reviews,
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
