import 'package:flutter/material.dart';
import 'package:kyuu_test/theme/colors.dart';

class BuildSpecialistsTitle extends StatelessWidget {
  const BuildSpecialistsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 30, bottom: 15),
      child: Text(
        'Salon specialists',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.text900,
        ),
      ),
    );
  }
}
