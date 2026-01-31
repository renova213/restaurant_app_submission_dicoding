import 'package:flutter/material.dart';

import '../../config/config.dart';

class FilledButton extends StatelessWidget {
  final TextStyle? textStyle;
  final bool infinity;
  final Widget child;
  final double? radius;
  final EdgeInsets? contentPadding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final Function()? onPressed;
  final bool disableButton;

  const FilledButton({
    super.key,
    this.onPressed,
    this.textStyle,
    required this.child,
    this.contentPadding,
    this.backgroundColor = const Color(0xffed0226),
    this.margin,
    this.radius,
    this.infinity = true,
    this.disableButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        width: infinity ? double.infinity : null,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            disabledBackgroundColor: AppColors.grey,
            shape: radius == null
                ? const StadiumBorder()
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius ?? 0),
                  ),
            padding: contentPadding,
          ),
          onPressed: disableButton ? null : onPressed,
          child: child,
        ),
      ),
    );
  }
}
