import 'package:equatable/equatable.dart';

import '../../../../../domain/domain.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewState {
  const ReviewInitial();
}

class ReviewLoading extends ReviewState {
  const ReviewLoading();
}

class ReviewLoaded extends ReviewState {
  final List<DetailRestaurantCustomerReviewEntity> customerReviews;

  const ReviewLoaded({required this.customerReviews});

  @override
  List<Object?> get props => [customerReviews];
}

class ReviewError extends ReviewState {
  final String message;

  const ReviewError(this.message);

  @override
  List<Object?> get props => [message];
}
