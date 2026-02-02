import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/config.dart';
import '../../../../../../routes/app_route.dart';
import '../../../../../../shared_components/shared_components.dart';
import '../view_model/app_splash_provider.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({super.key});

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<AppSplashProvider>().init();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSplashProvider>(
      builder: (context, provider, _) {
        if (provider.isReady) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.pushReplacement(AppRoutes.restaurantRoutes.dashboard);
          });
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.images.logo, width: 200),
                8.verticalSpace(),
                Text(
                  "Restaurant App",
                  style: TextStyleHelper.apply(
                    context: context,
                    size: .h2,
                    style: .semiBold,
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
