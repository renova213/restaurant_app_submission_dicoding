import 'package:flutter/material.dart';

import '../../../domain/domain.dart';

class AddReviewRestaurantArgs {
  final String restaurantId;
  final ValueChanged<List<DetailRestaurantCustomerReviewEntity>>
  onReviewSubmitted;

  const AddReviewRestaurantArgs({
    required this.restaurantId,
    required this.onReviewSubmitted,
  });
}
