import 'package:flutter/material.dart';

class AddReviewTextField extends StatelessWidget {
  final int maxLines;
  final int maxLength;
  final TextEditingController controller;
  const AddReviewTextField({
    super.key,
    required this.controller,
    required this.maxLength,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      maxLines: maxLines,
      maxLength: maxLength,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Required";
        }
        return null;
      },
    );
  }
}
