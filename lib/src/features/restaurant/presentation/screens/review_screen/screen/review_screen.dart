import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_app/src/config/config.dart';

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
        backgroundColor: AppColors.blue,
        onPressed: () {
          context.pushNamed(
            RestaurantRoutes.shared.addReviewRestaurant,
            extra: AddReviewRestaurantArgs(
              restaurantId: restaurantId,
              onReviewSubmitted: (customerReviews) {
                context.read<ReviewCubit>().initCustomerReviews(
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
          child: BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) {
              if (state is ReviewLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ReviewLoaded && state.customerReviews.isEmpty) {
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

              if (state is ReviewLoaded) {
                return ReviewList(customerReviews: state.customerReviews);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
