import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../restaurant.dart';

final restaurantProviders = <ChangeNotifierProvider>[
  ChangeNotifierProvider<RestaurantProvider>(
    create: (_) => locator<RestaurantProvider>(),
  ),

  ChangeNotifierProvider<DetailRestaurantProvider>(
    create: (_) => locator<DetailRestaurantProvider>(),
  ),

  ChangeNotifierProvider<AddReviewRestaurantProvider>(
    create: (_) => locator<AddReviewRestaurantProvider>(),
  ),

  ChangeNotifierProvider<ReviewProvider>(
    create: (_) => locator<ReviewProvider>(),
  ),
];
