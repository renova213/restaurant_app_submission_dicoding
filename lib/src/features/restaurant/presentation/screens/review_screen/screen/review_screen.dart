import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/config.dart';
import '../../../../../../core/core.dart';
import '../../../../../../shared_components/shared_components.dart';
import '../../../../domain/domain.dart';
import '../../../../routes/routes.dart';
import '../../../navigation/navigation.dart';
import '../view_model/view_model.dart';
import '../widgets/widgets.dart';

class ReviewScreen extends StatelessWidget {
  final String restaurantId;
  final List<DetailRestaurantCustomerReviewEntity> customerReviews;
  const ReviewScreen({
    super.key,
    required this.restaurantId,
    required this.customerReviews,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Customer Reviews",
          style: TextStyleHelper.apply(
            context: context,
            size: .body1,
            style: .regular,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBackgroundThemeColor(
          Theme.of(context).brightness,
        ),
        onPressed: () {
          context.pushNamed(
            RestaurantRoutes.shared.addReviewRestaurant,
            extra: AddReviewRestaurantArgs(
              restaurantId: restaurantId,
              onReviewSubmitted: (customerReviews) {
                context.read<ReviewProvider>().initCustomerReviews(
                  customerReviews,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Consumer<ReviewProvider>(
            builder: (context, provider, _) {
              if (provider.reviewState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (provider.reviewState.isLoaded &&
                  provider.customerReviews.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        "Not have reviews yet",
                        style: TextStyleHelper.apply(
                          context: context,
                          size: .body1,
                          style: .regular,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (provider.reviewState.isLoaded) {
                return ReviewList(customerReviews: provider.customerReviews);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
