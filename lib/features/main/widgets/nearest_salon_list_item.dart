import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kyuu_test/common/extensions/double_extensions.dart';
import 'package:kyuu_test/common/widgets/custom_stars.dart';
import 'package:kyuu_test/theme/colors.dart';

import '../../nearest_salon/page/nearest_salon_page.dart';
import '../model/branch.dart';

class NearestSalonListItem extends StatelessWidget {
  const NearestSalonListItem({super.key, required this.branch});

  final Branch branch;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(
          NearestSalonPage.path,
          extra: {
            'branchId': branch.id,
            'rating': branch.rating,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 24),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: AppColors.text300,
              offset: Offset(0, 0),
              blurRadius: .5,
              spreadRadius: .1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: branch.imageURL,
                fit: BoxFit.cover,
                height: 112,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Hero(
                      tag: branch.id,
                      child: Text(
                        branch.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.dark900,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  CustomStars(
                    starredCount: branch.rating.toInt(),
                    itemWidth: 11,
                    gap: 3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      branch.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.text300,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 4),
                    child: SvgPicture.asset(
                      'assets/svg/location_stroke.svg',
                      width: 13,
                      height: 13,
                      colorFilter: const ColorFilter.mode(
                        AppColors.dark900,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Text(
                    branch.space.getKmOrM,
                    style: const TextStyle(
                      color: AppColors.dark900,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
