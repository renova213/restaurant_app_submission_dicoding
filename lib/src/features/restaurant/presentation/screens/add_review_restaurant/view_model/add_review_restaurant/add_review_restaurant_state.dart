import 'package:equatable/equatable.dart';

abstract class AddReviewRestaurantState extends Equatable {
  const AddReviewRestaurantState();

  @override
  List<Object?> get props => [];
}

class AddReviewRestaurantInitial extends AddReviewRestaurantState {
  const AddReviewRestaurantInitial();
}

class AddReviewRestaurantLoading extends AddReviewRestaurantState {
  const AddReviewRestaurantLoading();
}

class AddReviewRestaurantLoaded extends AddReviewRestaurantState {
  const AddReviewRestaurantLoaded();

  @override
  List<Object?> get props => [];
}

class AddReviewRestaurantError extends AddReviewRestaurantState {
  final String message;

  const AddReviewRestaurantError(this.message);

  @override
  List<Object?> get props => [message];
}
