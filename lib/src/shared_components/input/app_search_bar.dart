import 'package:flutter/material.dart';

import '../spacer/spacer.dart';
import '../text/text.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String initialValue;
  final String hintText;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final EdgeInsets padding;
  final FontStyleSize fontSize;
  final AppFontStyle placeholderStyle;
  final AppFontStyle fontStyle;

  const AppSearchBar({
    super.key,
    required this.controller,
    this.initialValue = '',
    this.hintText = 'Search',
    this.onChanged,
    this.onClear,
    this.height = 48,
    this.borderColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.borderRadius = 32,
    this.prefixIcon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.fontSize = .body2,
    this.fontStyle = .regular,
    this.placeholderStyle = .light,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor),
        ),
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            12.horizontalSpace(),

            prefixIcon ?? const Icon(Icons.search),

            8.horizontalSpace(),

            Expanded(
              child: SizedBox(
                height: height,
                child: TextField(
                  maxLines: 1,
                  controller: controller,
                  style: TextStyleHelper.apply(
                    context: context,
                    size: fontSize,
                    style: fontStyle,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    hintText: hintText,
                    hintStyle: TextStyleHelper.apply(
                      context: context,
                      size: fontSize,
                      style: placeholderStyle,
                    ),
                    fillColor: backgroundColor,
                    filled: true,
                  ),
                  onChanged: (value) {
                    onChanged?.call(value);
                  },
                ),
              ),
            ),

            8.horizontalSpace(),

            controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      controller.clear();
                      onClear?.call();
                    },
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
