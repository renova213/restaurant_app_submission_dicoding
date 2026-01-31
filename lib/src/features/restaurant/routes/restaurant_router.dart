import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
      return BlocProvider(
        create: (_) =>
            RestaurantCubit(locator(), locator())..fetchRestaurants(),
        child: RestaurantDashboardScreen(),
      );
    },
  ),

  GoRoute(
    path: RestaurantRoutes.shared.detailRestaurant,
    name: RestaurantRoutes.shared.detailRestaurant,
    builder: (context, state) {
      final args = state.extra as RestaurantDetailArgs;

      return BlocProvider(
        create: (_) =>
            DetailRestaurantCubit(locator())
              ..fetchDetailRestaurants(args.restaurantId),
        child: DetailRestaurantScreen(index: args.index),
      );
    },
  ),

  GoRoute(
    path: RestaurantRoutes.shared.addReviewRestaurant,
    name: RestaurantRoutes.shared.addReviewRestaurant,
    builder: (context, state) {
      final args = state.extra as AddReviewRestaurantArgs;

      return BlocProvider(
        create: (_) => AddReviewRestaurantCubit(locator()),
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

      return BlocProvider(
        create: (_) => ReviewCubit()..initCustomerReviews(args.customerReviews),
        child: ReviewScreen(
          restaurantId: args.restaurantId,
          customerReviews: args.customerReviews,
        ),
      );
    },
  ),
];
