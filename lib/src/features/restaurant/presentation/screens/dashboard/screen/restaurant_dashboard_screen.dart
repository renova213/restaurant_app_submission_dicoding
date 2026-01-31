import 'package:flutter/material.dart';

import '../../../../../../shared_components/shared_components.dart';
import '../widgets/widgets.dart';

class RestaurantDashboardScreen extends StatelessWidget {
  const RestaurantDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
    );
  }
}
