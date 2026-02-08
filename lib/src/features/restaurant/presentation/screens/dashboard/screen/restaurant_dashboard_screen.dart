import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/core.dart';
import '../../../../../../shared_components/shared_components.dart';
import '../view_model/view_model.dart';
import '../widgets/widgets.dart';

class RestaurantDashboardScreen extends StatelessWidget {
  const RestaurantDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RestaurantProvider(locator(), locator())..fetchRestaurants(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.verticalSpace(),
                Row(
                  spacing: 16,
                  children: [
                    const Expanded(child: RestaurantSearchBar()),
                    ThemeSwitcher(),
                  ],
                ),

                Text(
                  "Recommendation Restaurants",
                  style: TextStyleHelper.apply(
                    context: context,
                    size: .body1,
                    style: .semiBold,
                  ),
                ),
                Expanded(child: RestaurantList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
