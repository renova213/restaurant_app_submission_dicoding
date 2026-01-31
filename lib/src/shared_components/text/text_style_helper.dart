import 'package:flutter/material.dart';

import '../../config/config.dart';

class TextStyleHelper {
  static TextStyle apply({
    required BuildContext context,
    Color? color,
    double? letterSpacing,
    String? fontFamily,
    required FontStyleSize size,
    required AppFontStyle style,
    TextDecoration? decoration,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextStyle(
      color: color ?? (isDark ? Colors.white : Colors.black),
      fontSize: size.sizeValue,
      fontFamily: fontFamily ?? AppAssets.fonts.poppins,
      fontWeight: style.fontWeight,
      fontStyle: style.fontStyle,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }
}

enum FontStyleSize { h1, h2, body1, body2, small, micro, label, caption }

extension FontStyleSizeExt on FontStyleSize {
  double get sizeValue {
    switch (this) {
      case FontStyleSize.h1:
        return 32.0;
      case FontStyleSize.h2:
        return 24.0;
      case FontStyleSize.body1:
        return 16.0;
      case FontStyleSize.body2:
        return 14.0;
      case FontStyleSize.small:
        return 12.0;
      case FontStyleSize.label:
        return 11.0;
      case FontStyleSize.micro:
        return 10.0;
      case FontStyleSize.caption:
        return 8.0;
    }
  }
}

enum AppFontStyle { light, regular, medium, semiBold, bold, italic }

extension AppFontStyleExt on AppFontStyle {
  FontWeight get fontWeight {
    switch (this) {
      case AppFontStyle.light:
        return FontWeight.w300;
      case AppFontStyle.regular:
        return FontWeight.w400;
      case AppFontStyle.medium:
        return FontWeight.w500;
      case AppFontStyle.semiBold:
        return FontWeight.w600;
      case AppFontStyle.bold:
        return FontWeight.w700;
      case AppFontStyle.italic:
        return FontWeight.w400;
    }
  }

  FontStyle get fontStyle {
    switch (this) {
      case AppFontStyle.italic:
        return FontStyle.italic;
      default:
        return FontStyle.normal;
    }
  }
}
