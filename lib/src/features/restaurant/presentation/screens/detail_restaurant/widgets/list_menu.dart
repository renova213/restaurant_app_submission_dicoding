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
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(color: Colors.white),
      scrollDirection: Axis.horizontal,
      itemCount: menus.length,
      itemBuilder: (context, index) {
        DetailRestaurantMenuItemEntity menu = menus[index];

        return Padding(
          padding: EdgeInsets.only(right: 16),
          child: SizedBox(
            width: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 170,
                  height: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: AppNetworkImage(
                      imageUrl: placeholderImage,
                      placeholder: SkeletonContainer(
                        width: 170,
                        height: 130,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      fit: BoxFit.cover,
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
          ),
        );
      },
    );
  }
}
