import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/config.dart';
import '../../../../../../shared_components/shared_components.dart';
import '../../../../domain/domain.dart';
import '../../../../routes/routes.dart';
import '../../../navigation/navigation.dart';
import '../view_model/view_model.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantItemEntity restaurantItem;
  final int index;
  const RestaurantCard({
    super.key,
    required this.restaurantItem,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          RestaurantRoutes.shared.detailRestaurant,
          extra: RestaurantDetailArgs(
            restaurantId: restaurantItem.id,
            index: index,
          ),
        );
      },
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final isDark = themeMode == ThemeMode.dark;
          return Container(
            width: context.width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyShade300),
              color: isDark ? AppColors.greyShade600 : AppColors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: Hero(
                      tag: restaurantItem.pictureId,
                      child: AppNetworkImage(
                        imageUrl: restaurantItem.pictureId,
                        placeholder: SkeletonContainer(
                          width: 120,
                          height: 100,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                8.horizontalSpace(),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Hero(
                          tag: restaurantItem.name + index.toString(),
                          child: Text(
                            restaurantItem.name,
                            style: TextStyleHelper.apply(
                              context: context,
                              size: .body1,
                              style: .regular,
                            ),
                          ),
                        ),

                        6.verticalSpace(),

                        Hero(
                          tag: restaurantItem.city + index.toString(),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.icons.location,
                                width: 15,
                                height: 15,
                              ),

                              4.horizontalSpace(),

                              Text(
                                restaurantItem.city,
                                style: TextStyleHelper.apply(
                                  context: context,
                                  size: .body2,
                                  style: .regular,
                                ),
                              ),
                            ],
                          ),
                        ),

                        12.verticalSpace(),

                        Hero(
                          tag:
                              restaurantItem.rating.toString() +
                              index.toString(),
                          child: Row(
                            children: [
                              RatingBarIndicator(
                                itemSize: 15,
                                rating: restaurantItem.rating,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: AppColors.yellowShade900,
                                ),
                              ),

                              4.horizontalSpace(),

                              Text(
                                restaurantItem.rating.toString(),
                                style: TextStyleHelper.apply(
                                  context: context,
                                  size: .body2,
                                  style: .regular,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
