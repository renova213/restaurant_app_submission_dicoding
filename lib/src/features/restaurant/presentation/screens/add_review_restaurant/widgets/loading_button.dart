import 'package:flutter/material.dart';
import 'package:restaurant_app/src/config/config.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.blue),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
