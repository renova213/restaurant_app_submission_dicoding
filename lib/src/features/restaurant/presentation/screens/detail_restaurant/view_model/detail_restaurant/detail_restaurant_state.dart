import 'package:equatable/equatable.dart';

import '../../../../../domain/domain.dart';

abstract class DetailRestaurantState extends Equatable {
  const DetailRestaurantState();

  @override
  List<Object?> get props => [];
}

class DetailRestaurantInitial extends DetailRestaurantState {
  const DetailRestaurantInitial();
}

class DetailRestaurantLoading extends DetailRestaurantState {
  const DetailRestaurantLoading();
}

class DetailRestaurantLoaded extends DetailRestaurantState {
  final DetailRestaurantEntity detailRestaurant;

  const DetailRestaurantLoaded({required this.detailRestaurant});

  @override
  List<Object?> get props => [detailRestaurant];
}

class DetailRestaurantError extends DetailRestaurantState {
  final String message;

  const DetailRestaurantError(this.message);

  @override
  List<Object?> get props => [message];
}
