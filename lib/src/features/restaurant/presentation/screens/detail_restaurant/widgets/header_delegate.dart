import 'package:flutter/material.dart';

import '../../../../../../config/config.dart';
import '../../../../../../shared_components/shared_components.dart';
import '../../../../domain/domain.dart';

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
              color: Colors.lightBlue,
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
              child: AppNetworkImage(
                imageUrl: detailRestaurant.pictureId,
                placeholder: SkeletonContainer(
                  width: 120,
                  height: 80,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                fit: BoxFit.cover,
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
