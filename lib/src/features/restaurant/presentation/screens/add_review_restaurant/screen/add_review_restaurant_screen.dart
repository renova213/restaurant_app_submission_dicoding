import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_app/src/config/config.dart';
import 'package:restaurant_app/src/shared_components/shared_components.dart';

import '../../../../domain/domain.dart';
import '../../../../domain/usecase/params/params.dart';
import '../view_model/view_model.dart';
import '../widgets/widgets.dart';

class AddReviewRestaurantScreen extends StatefulWidget {
  final String restaurantId;
  final ValueChanged<List<DetailRestaurantCustomerReviewEntity>>
  onReviewSubmitted;
  const AddReviewRestaurantScreen({
    super.key,
    required this.restaurantId,
    required this.onReviewSubmitted,
  });

  @override
  State<AddReviewRestaurantScreen> createState() =>
      _AddReviewRestaurantScreenState();
}

class _AddReviewRestaurantScreenState extends State<AddReviewRestaurantScreen> {
  final _reviewEditingController = TextEditingController();
  final _nameEditingController = TextEditingController();

  @override
  void dispose() {
    _reviewEditingController.dispose();
    _nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        title: Text(
          "Feedback Screen",
          style: TextStyleHelper.apply(
            context: context,
            size: .body1,
            style: .regular,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name :",
                  style: TextStyleHelper.apply(
                    context: context,
                    size: .body1,
                    style: .regular,
                  ),
                ),

                const SizedBox(height: 8),

                AddReviewTextField(
                  maxLines: 1,
                  maxLength: 50,
                  controller: _nameEditingController,
                ),

                Text(
                  "Feedback :",
                  style: TextStyleHelper.apply(
                    context: context,
                    size: .body1,
                    style: .regular,
                  ),
                ),

                AddReviewTextField(
                  maxLines: 6,
                  maxLength: 100,
                  controller: _reviewEditingController,
                ),

                BlocBuilder<AddReviewRestaurantCubit, AddReviewRestaurantState>(
                  builder: (context, state) {
                    return Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: state is AddReviewRestaurantLoading
                            ? 80
                            : MediaQuery.of(context).size.width * 0.9,
                        child: state is AddReviewRestaurantLoading
                            ? LoadingButton()
                            : SubmitButton(
                                onSubmit: () async {
                                  if (_nameEditingController.text.isNotEmpty &&
                                      _reviewEditingController
                                          .text
                                          .isNotEmpty) {
                                    final customerReviews = await context
                                        .read<AddReviewRestaurantCubit>()
                                        .addReview(
                                          AddRestaurantReviewParam(
                                            name: _nameEditingController.text,
                                            review:
                                                _reviewEditingController.text,
                                            id: widget.restaurantId,
                                          ),
                                        );

                                    if (customerReviews.isNotEmpty) {
                                      _reviewEditingController.clear();
                                      _nameEditingController.clear();

                                      context.pop();

                                      widget.onReviewSubmitted(customerReviews);
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          duration: const Duration(seconds: 1),
                                          content: Text(
                                            "Please fill all the fields",
                                            style: TextStyleHelper.apply(
                                              context: context,
                                              size: .body1,
                                              style: .regular,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          backgroundColor: AppColors.blue,
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1),
                                        content: Text(
                                          "Please fill all the fields",
                                          style: TextStyleHelper.apply(
                                            context: context,
                                            size: .body1,
                                            style: .regular,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        backgroundColor: AppColors.blue,
                                      ),
                                    );
                                  }
                                },
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
