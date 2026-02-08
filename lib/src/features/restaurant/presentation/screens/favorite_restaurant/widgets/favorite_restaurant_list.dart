import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../config/config.dart';
import '../../../../../../core/core.dart';
import '../../../../../../shared_components/shared_components.dart';
import '../../../../domain/domain.dart';
import '../view_model/favorite_restaurant_provider.dart';
import 'widgets.dart';

class FavoriteRestaurantList extends StatelessWidget {
  const FavoriteRestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteRestaurantProvider>(
      builder: (context, provider, _) {
        if (provider.favoriteRestaurantState.isLoading) {
          return const FavoriteRestaurantListSkeleton();
        }

        if (provider.favoriteRestaurantState.isError) {
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
                        context
                            .read<FavoriteRestaurantProvider>()
                            .fetchFavoriteRestaurants();
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

        if (provider.favoriteRestaurantState.isEmpty) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Lottie.asset(AppAssets.lotties.emptyData),
                  Text(
                    "No favorite restaurant found",
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

        if (provider.favoriteRestaurantState.isLoaded) {
          return ListView.separated(
            itemBuilder: (context, index) {
              RestaurantItemEntity restaurantItem =
                  provider.favoriteRestaurants[index];
              final heroTagId = const Uuid().v4();

              return FavoriteRestaurantCard(
                restaurantItem: restaurantItem,
                index: index,
                heroTagId: heroTagId,
              );
            },
            separatorBuilder: (context, index) => 16.verticalSpace(),
            itemCount: provider.favoriteRestaurants.length,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
