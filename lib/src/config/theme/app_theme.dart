import 'package:flutter/material.dart';

import '../config.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.lightBackground,
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    fontFamily: AppAssets.fonts.poppins,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.darkBackground,
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    fontFamily: AppAssets.fonts.poppins,
  );
}
