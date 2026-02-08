import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../config/config.dart';
import '../../../../../../core/core.dart';
import '../../../../../../shared_components/shared_components.dart';
import '../../../../domain/domain.dart';
import '../view_model/view_model.dart';
import 'restaurant_card.dart';
import 'restaurant_list_skeleton.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, _) {
        if (provider.restaurantState.isLoading) {
          return const RestaurantListSkeleton();
        }

        if (provider.restaurantState.isError) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.errorMessage,
                    style: TextStyleHelper.apply(
                      context: context,
                      size: .body1,
                      style: .regular,
                      color: AppColors.red,
                    ),
                  ),

                  16.verticalSpace(),

                  SizedBox(
                    width: context.width * 0.7,
                    child: GeneralButton(
                      onPressed: () {
                        context.read<RestaurantProvider>().fetchRestaurants();
                      },
                      child: GeneralText(
                        text: "Refresh",
                        style: TextStyleHelper.apply(
                          context: context,
                          size: .body1,
                          style: .semiBold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (provider.restaurantState.isLoaded &&
            provider.restaurant.restaurantList.isEmpty) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Lottie.asset(AppAssets.lotties.emptyData),
                  Text(
                    "No restaurant found",
                    style: TextStyleHelper.apply(
                      context: context,
                      size: .body1,
                      style: .regular,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (provider.restaurantState.isLoaded) {
          return ListView.separated(
            itemBuilder: (context, index) {
              RestaurantItemEntity restaurantItem =
                  provider.restaurant.restaurantList[index];
              final heroTagId = const Uuid().v4();

              return RestaurantCard(
                restaurantItem: restaurantItem,
                index: index,
                heroTagId: heroTagId,
              );
            },
            separatorBuilder: (contex, index) => 16.verticalSpace(),
            itemCount: provider.restaurant.restaurantList.length,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
