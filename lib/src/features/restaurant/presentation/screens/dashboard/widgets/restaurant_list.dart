import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../config/config.dart';
import '../../../../../../shared_components/shared_components.dart';
import '../../../../domain/domain.dart';
import '../view_model/view_model.dart';
import 'restaurant_card.dart';
import 'restaurant_list_skeleton.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantCubit, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantLoading) {
          return const RestaurantListSkeleton();
        }

        if (state is RestaurantError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyleHelper.apply(
                context: context,
                size: .body1,
                style: .regular,
                color: AppColors.red,
              ),
            ),
          );
        }

        if (state is RestaurantLoaded &&
            state.restaurant.restaurantList.isEmpty) {
          return Center(
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
          );
        }

        if (state is RestaurantLoaded) {
          return ListView.separated(
            itemBuilder: (context, index) {
              RestaurantItemEntity restaurantItem =
                  state.restaurant.restaurantList[index];

              return RestaurantCard(
                restaurantItem: restaurantItem,
                index: index,
              );
            },
            separatorBuilder: (contex, index) => 16.verticalSpace(),
            itemCount: state.restaurant.restaurantList.length,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
