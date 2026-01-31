import 'package:flutter/material.dart';

extension Spacer on int {
  Widget verticalSpace() {
    return SizedBox(height: toDouble());
  }

  Widget horizontalSpace() {
    return SizedBox(width: toDouble());
  }
}

extension SpacerExt on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}
