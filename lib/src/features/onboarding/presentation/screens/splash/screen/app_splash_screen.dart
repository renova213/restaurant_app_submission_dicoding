import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/config.dart';
import '../../../../../../routes/app_route.dart';
import '../../../../../../shared_components/shared_components.dart';
import '../view_model/app_splash_cubit.dart';
import '../view_model/app_splash_state.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({super.key});

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AppSplashCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppSplashCubit, AppSplashState>(
      listenWhen: (prev, curr) => prev.isReady != curr.isReady,
      listener: (context, state) {
        if (state.isReady) {
          context.pushReplacement(AppRoutes.restaurantRoutes.dashboard);
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
