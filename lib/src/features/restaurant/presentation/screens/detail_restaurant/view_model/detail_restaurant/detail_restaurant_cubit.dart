import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/core.dart';
import '../../../../../domain/domain.dart';
import '../view_model.dart';

class DetailRestaurantCubit extends Cubit<DetailRestaurantState> {
  final GetDetailRestaurantUsecase getDetailRestaurantsUseCase;

  DetailRestaurantCubit(this.getDetailRestaurantsUseCase)
    : super(const DetailRestaurantInitial());

  // MARK: APIs
  Future<void> fetchDetailRestaurants(String id) async {
    emit(const DetailRestaurantLoading());

    final result = await getDetailRestaurantsUseCase.call(id);

    result.fold(
      (error) {
        emit(DetailRestaurantError(error.message));
        AppLog.logger.e(error.message);
        AppLog.logger.e(error.originalError);
      },
      (detailRestaurant) {
        emit(DetailRestaurantLoaded(detailRestaurant: detailRestaurant));
      },
    );
  }
}
