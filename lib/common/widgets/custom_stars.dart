import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kyuu_test/theme/colors.dart';

class CustomStars extends StatelessWidget {
  const CustomStars({
    super.key,
    required this.starredCount,
    required this.itemWidth,
    required this.gap,
  });

  final int starredCount;
  final double itemWidth;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 5; i++)
          _BuildStar(
            colored: i < starredCount,
            hasGap: i < 4,
            width: itemWidth,
            gap: gap,
          ),
      ],
    );
  }
}

class _BuildStar extends StatelessWidget {
  const _BuildStar({
    required this.colored,
    required this.hasGap,
    required this.width,
    required this.gap,
  });

  final bool colored;
  final bool hasGap;
  final double width;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: hasGap ? gap : 0),
      child: SvgPicture.asset(
        'assets/svg/star_solid.svg',
        width: width,
        height: width,
        colorFilter: ColorFilter.mode(
          colored ? AppColors.yellow500 : AppColors.light900,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
