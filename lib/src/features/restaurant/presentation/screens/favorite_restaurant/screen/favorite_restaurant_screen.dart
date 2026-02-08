import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/core.dart';
import '../../../../../../shared_components/shared_components.dart';
import '../view_model/favorite_restaurant_provider.dart';
import '../widgets/widgets.dart';

class FavoriteRestaurantScreen extends StatelessWidget {
  const FavoriteRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          FavoriteRestaurantProvider(locator())..fetchFavoriteRestaurants(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.verticalSpace(),

                Text(
                  "Favorite Restaurants",
                  style: TextStyleHelper.apply(
                    context: context,
                    size: .body1,
                    style: .semiBold,
                  ),
                ),
                Expanded(child: FavoriteRestaurantList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
