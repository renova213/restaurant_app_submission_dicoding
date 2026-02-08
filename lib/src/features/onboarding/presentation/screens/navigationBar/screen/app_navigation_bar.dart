import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/config.dart';
import '../../../../../restaurant/presentation/screens/favorite_restaurant/screen/favorite_restaurant_screen.dart';
import '../../../../../restaurant/restaurant.dart';
import '../../../../../setting/presentation/screen/setting_screen.dart';
import '../view_model/navigation_provider.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: Stack(
            children: [
              const Offstage(
                offstage: false,
                child: RestaurantDashboardScreen(),
              ),

              if (provider.selectedIndex == 1) const FavoriteRestaurantScreen(),
              if (provider.selectedIndex == 2) const SettingScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
            currentIndex: provider.selectedIndex,
            unselectedItemColor: Theme.of(context).brightness == Brightness.dark
                ? AppColors.grey
                : AppColors.greyShade600,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? AppColors.greyShade600
                : AppColors.white,
            selectedItemColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            onTap: provider.setIndex,
          ),
        );
      },
    );
  }
}
