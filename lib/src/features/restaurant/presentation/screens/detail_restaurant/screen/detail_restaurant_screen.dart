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
import '../widgets/widgets.dart';

class DetailRestaurantScreen extends StatelessWidget {
  final int index;
  const DetailRestaurantScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DetailRestaurantCubit, DetailRestaurantState>(
          builder: (context, state) {
            if (state is DetailRestaurantLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DetailRestaurantError) {
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

            if (state is DetailRestaurantLoaded) {
              return _body(
                context: context,
                detailRestaurant: state.detailRestaurant,
                index: index,
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _body({
    required BuildContext context,
    required DetailRestaurantEntity detailRestaurant,
    required int index,
  }) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: MyHeaderDelegate(detailRestaurant: detailRestaurant),
          pinned: true,
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Hero(
                          tag: detailRestaurant.name + index.toString(),
                          child: Text(
                            detailRestaurant.name,
                            style: TextStyleHelper.apply(
                              context: context,
                              size: .h2,
                              style: .semiBold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Hero(
                          tag:
                              detailRestaurant.rating.toString() +
                              index.toString(),
                          child: Row(
                            children: [
                              RatingBarIndicator(
                                itemSize: 15,
                                rating: detailRestaurant.rating,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: AppColors.yellowShade900,
                                ),
                              ),

                              4.horizontalSpace(),

                              Text(
                                detailRestaurant.rating.toString(),
                                style: TextStyleHelper.apply(
                                  context: context,
                                  size: .body1,
                                  style: .regular,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  8.verticalSpace(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        tag: detailRestaurant.city + index.toString(),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.icons.location,
                              width: 15,
                              height: 15,
                            ),

                            4.horizontalSpace(),

                            Text(
                              detailRestaurant.city,
                              style: TextStyleHelper.apply(
                                context: context,
                                size: .body1,
                                style: .regular,
                                color: AppColors.greyShade600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          context.pushNamed(
                            RestaurantRoutes.shared.reviews,
                            extra: ReviewArgs(
                              restaurantId: detailRestaurant.id,
                              customerReviews: detailRestaurant.customerReviews,
                            ),
                          );
                        },
                        child: Text(
                          "(see all reviews)",
                          style: TextStyleHelper.apply(
                            context: context,
                            size: .body1,
                            style: .regular,
                            color: AppColors.yellowShade900,
                          ),
                        ),
                      ),
                    ],
                  ),

                  24.verticalSpace(),

                  Text(
                    "Deskripsi Restaurant",
                    style: TextStyleHelper.apply(
                      context: context,
                      size: .body1,
                      style: .regular,
                    ),
                  ),

                  8.verticalSpace(),

                  Text(
                    detailRestaurant.description,
                    style: TextStyleHelper.apply(
                      context: context,
                      size: .body1,
                      style: .regular,
                    ),
                  ),

                  16.verticalSpace(),

                  Text(
                    "Menu Makanan",
                    style: TextStyleHelper.apply(
                      context: context,
                      size: .h2,
                      style: .semiBold,
                    ),
                  ),

                  12.verticalSpace(),

                  SizedBox(
                    height: 200,
                    child: ListMenu(
                      menus: detailRestaurant.menus.foods,
                      placeholderImage:
                          "https://toppng.com/uploads/preview/clipart-free-seaweed-clipart-draw-food-placeholder-11562968708qhzooxrjly.png",
                    ),
                  ),

                  16.verticalSpace(),

                  Text(
                    "Menu Minuman",
                    style: TextStyleHelper.apply(
                      context: context,
                      size: .h2,
                      style: .semiBold,
                    ),
                  ),

                  12.verticalSpace(),

                  SizedBox(
                    height: 200,
                    child: ListMenu(
                      menus: detailRestaurant.menus.drinks,
                      placeholderImage:
                          "https://cdn-icons-png.flaticon.com/512/6027/6027935.png",
                    ),
                  ),

                  8.verticalSpace(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
