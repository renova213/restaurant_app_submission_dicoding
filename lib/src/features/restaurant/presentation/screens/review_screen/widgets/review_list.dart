import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../../config/config.dart';
import '../../../../../../shared_components/shared_components.dart';
import '../../../../domain/domain.dart';

class ReviewList extends StatelessWidget {
  final List<DetailRestaurantCustomerReviewEntity> customerReviews;
  const ReviewList({super.key, required this.customerReviews});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final customerReview = customerReviews[index];

        return ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Center(
              child: Text(
                customerReview.name.isNotEmpty ? customerReview.name[0] : '-',
                style: TextStyleHelper.apply(
                  context: context,
                  size: .h2,
                  style: .bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          title: Row(
            spacing: 16,
            children: [
              Expanded(
                child: Text(
                  customerReview.name,
                  style: TextStyleHelper.apply(
                    context: context,
                    size: .body1,
                    style: .semiBold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  customerReview.date,
                  style: TextStyleHelper.apply(
                    context: context,
                    size: .body2,
                    style: .regular,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            customerReview.review,
            style: TextStyleHelper.apply(
              context: context,
              size: .body2,
              style: .regular,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 15, indent: 85);
      },
      itemCount: customerReviews.length,
    );
  }
}
