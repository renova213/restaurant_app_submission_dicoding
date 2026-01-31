import 'package:flutter/material.dart';

import '../../../../../../shared_components/shared_components.dart';

class RestaurantListSkeleton extends StatelessWidget {
  const RestaurantListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Row(
          children: [
            SkeletonContainer(
              width: context.width * 0.9,
              height: 80,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return 16.verticalSpace();
      },
      itemCount: 10,
    );
  }
}
