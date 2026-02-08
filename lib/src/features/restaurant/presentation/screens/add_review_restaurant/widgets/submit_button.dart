import 'package:flutter/material.dart';

import '../../../../../../config/config.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? onSubmit;
  const SubmitButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: onSubmit != null
            ? WidgetStateProperty.all(
                Theme.of(context).brightness == Brightness.dark
                    ? AppColors.greyShade600
                    : AppColors.red,
              )
            : WidgetStateProperty.all(AppColors.grey),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      onPressed: onSubmit,
      child: const Text("SUBMIT", style: TextStyle(color: AppColors.white)),
    );
  }
}
