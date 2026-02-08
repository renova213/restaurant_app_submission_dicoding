import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/config.dart';
import '../../../../../../shared_components/shared_components.dart';
import '../../../../domain/domain.dart';
import '../view_model/view_model.dart';

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final DetailRestaurantEntity detailRestaurant;
  MyHeaderDelegate({required this.detailRestaurant});
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = shrinkOffset / maxExtent;
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: progress,
            child: Container(
              alignment: Alignment.centerLeft,
              color: AppColors.primaryBackgroundThemeColor(
                Theme.of(context).brightness,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  detailRestaurant.name,
                  style: TextStyleHelper.apply(
                    context: context,
                    size: .body1,
                    style: .regular,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),

          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: 1 - progress,
            child: Hero(
              tag: detailRestaurant.pictureId,
              child: Stack(
                children: [
                  AppNetworkImage(
                    imageUrl: detailRestaurant.pictureId,
                    width: context.width,
                    height: context.height,
                    placeholder: SkeletonContainer(
                      width: context.width,
                      height: context.height,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    fit: BoxFit.fill,
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 16),
                      child: Consumer<DetailRestaurantProvider>(
                        builder: (context, provider, _) => IconButton(
                          onPressed: () async {
                            final messenger = ScaffoldMessenger.of(context);
                            final brightness = Theme.of(context).brightness;
                            final textStyle = TextStyleHelper.apply(
                              context: context,
                              size: .body1,
                              style: .regular,
                              color: AppColors.white,
                            );

                            try {
                              await provider.toggleFavorite();
                            } finally {
                              messenger.showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  backgroundColor:
                                      AppColors.primaryBackgroundThemeColor(
                                        brightness,
                                      ),
                                  content: Text(
                                    provider.isFavorite
                                        ? "Added to favorite"
                                        : "Removed restaurant from favorite",
                                    style: textStyle,
                                  ),
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            provider.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: AppColors.yellowShade900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 250;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
