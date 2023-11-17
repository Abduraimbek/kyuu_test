import 'package:flutter/material.dart';
import 'package:kyuu_test/common/widgets/custom_stars.dart';
import 'package:kyuu_test/theme/colors.dart';

import '../model/branch_info.dart';

class BuildBranchAddressAndRating extends StatelessWidget {
  const BuildBranchAddressAndRating({
    super.key,
    required this.branchInfo,
    required this.rating,
  });

  final BranchInfo branchInfo;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            branchInfo.address.address,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.text500,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              CustomStars(
                starredCount: rating.toInt(),
                itemWidth: 16.5,
                gap: 4.375,
              ),
              const SizedBox(width: 9),
              const Text(
                '76 Reviews',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
