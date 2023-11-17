import 'package:flutter/material.dart';
import 'package:kyuu_test/theme/colors.dart';

class CustomAppBarActionButton extends StatelessWidget {
  const CustomAppBarActionButton({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            width: 1,
            color: Colors.grey.shade300,
          ),
        ),
        padding: EdgeInsets.zero,
        onPressed: () {},
        child: Icon(
          icon,
          color: AppColors.dark900,
        ),
      ),
    );
  }
}
