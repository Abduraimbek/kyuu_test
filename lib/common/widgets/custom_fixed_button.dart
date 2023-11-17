import 'package:flutter/material.dart';
import 'package:kyuu_test/theme/colors.dart';

class CustomFixedButton extends StatelessWidget {
  const CustomFixedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: AppColors.green600,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      minWidth: 0,
      height: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}
