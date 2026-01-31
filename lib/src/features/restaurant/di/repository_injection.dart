import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../restaurant.dart';

final restaurantRepositories = <RepositoryProvider>[
  RepositoryProvider<GetRestaurantsUseCase>(
    create: (_) => locator<GetRestaurantsUseCase>(),
  ),
  RepositoryProvider<GetSearchRestaurantsUsecase>(
    create: (_) => locator<GetSearchRestaurantsUsecase>(),
  ),
  RepositoryProvider<GetDetailRestaurantUsecase>(
    create: (_) => locator<GetDetailRestaurantUsecase>(),
  ),
  RepositoryProvider<PostAddReviewRestaurantUsecase>(
    create: (_) => locator<PostAddReviewRestaurantUsecase>(),
  ),
];

final restaurantCubits = <BlocProvider>[
  BlocProvider(create: (_) => RestaurantCubit(locator(), locator())),
  BlocProvider(create: (_) => DetailRestaurantCubit(locator())),
  BlocProvider(create: (_) => AddReviewRestaurantCubit(locator())),
  BlocProvider(create: (_) => ReviewCubit()),
];
