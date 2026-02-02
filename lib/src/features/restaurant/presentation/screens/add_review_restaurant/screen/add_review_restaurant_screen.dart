import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/config.dart';
import '../../../../../../core/core.dart';
import '../../../../../../shared_components/shared_components.dart';
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

  void _showErrorToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          message,
          style: TextStyleHelper.apply(
            context: context,
            size: .body1,
            style: .regular,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.primaryBackgroundThemeColor(
          Theme.of(context).brightness,
        ),
      ),
    );
  }

  void goBack() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: AppColors.primaryBackgroundThemeColor(
          Theme.of(context).brightness,
        ),
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

                Consumer<AddReviewRestaurantProvider>(
                  builder: (context, provider, _) {
                    return Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: provider.addReviewState.isLoading
                            ? 80
                            : MediaQuery.of(context).size.width * 0.9,
                        child: provider.addReviewState.isLoading
                            ? LoadingButton()
                            : SubmitButton(
                                onSubmit: () async {
                                  if (_nameEditingController.text.isNotEmpty &&
                                      _reviewEditingController
                                          .text
                                          .isNotEmpty) {
                                    final customerReviews = await context
                                        .read<AddReviewRestaurantProvider>()
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

                                      widget.onReviewSubmitted(customerReviews);

                                      goBack();
                                    } else {
                                      _showErrorToast(provider.errorMessage);
                                    }
                                  } else {
                                    _showErrorToast(
                                      "Please fill all the fields",
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
