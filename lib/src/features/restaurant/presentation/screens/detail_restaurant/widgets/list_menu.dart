import 'package:flutter/material.dart';

import '../../../../../../shared_components/shared_components.dart';
import '../../../../domain/domain.dart';

class ListMenu extends StatelessWidget {
  final List<DetailRestaurantMenuItemEntity> menus;
  final String placeholderImage;

  const ListMenu({
    super.key,
    required this.menus,
    required this.placeholderImage,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(menus.length, (index) {
          final menu = menus[index];

          return Padding(
            padding: EdgeInsets.only(right: index == menus.length - 1 ? 0 : 16),
            child: _MenuCard(menu: menu, placeholderImage: placeholderImage),
          );
        }),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final DetailRestaurantMenuItemEntity menu;
  final String placeholderImage;

  const _MenuCard({required this.menu, required this.placeholderImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: AppNetworkImage(
                imageUrl: placeholderImage,
                placeholder: SkeletonContainer(
                  borderRadius: BorderRadius.circular(15),
                  width: 170,
                  height: 130,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),

          8.verticalSpace(),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              menu.name,
              style: TextStyleHelper.apply(
                context: context,
                size: .body1,
                style: .bold,
              ),
            ),
          ),

          8.verticalSpace(),

          Text(
            "RP 50.000",
            style: TextStyleHelper.apply(
              context: context,
              size: .body2,
              style: .bold,
            ),
          ),
        ],
      ),
    );
  }
}
