import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/core.dart';
import '../../../../../domain/domain.dart';
import 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final GetRestaurantsUseCase getRestaurantsUseCase;
  final GetSearchRestaurantsUsecase getSearchRestaurantsUsecase;

  RestaurantCubit(this.getRestaurantsUseCase, this.getSearchRestaurantsUsecase)
    : super(const RestaurantInitial());

  // MARK: APIs
  Future<void> fetchRestaurants({String query = ''}) async {
    emit(const RestaurantLoading());

    final result = query.isEmpty
        ? await getRestaurantsUseCase(NoParams())
        : await getSearchRestaurantsUsecase(query);

    result.fold(
      (error) {
        emit(RestaurantError(error.message));
        AppLog.logger.e(error.message);
        AppLog.logger.e(error.originalError);
      },
      (restaurant) {
        emit(RestaurantLoaded(restaurant: restaurant));
      },
    );
  }
}
