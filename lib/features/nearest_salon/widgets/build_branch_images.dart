import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:kyuu_test/theme/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/branch_info.dart';

class BuildBranchImages extends HookWidget {
  const BuildBranchImages({super.key, required this.branchInfo});

  final BranchInfo branchInfo;

  static const height = 336.0;

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: pageController,
              itemCount: null,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: branchInfo.images[index % branchInfo.images.length],
                  height: height,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    height: height,
                    color: Colors.grey.shade100,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image,
                      color: Colors.grey.shade300,
                      size: 35,
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 252),
              child: SmoothPageIndicator(
                controller: pageController,
                count: branchInfo.images.length,
                effect: WormEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.white.withOpacity(.3),
                  dotHeight: 6,
                  dotWidth: 6,
                  spacing: 7,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 58,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  Expanded(
                    child: Hero(
                      tag: branchInfo.id,
                      child: Text(
                        branchInfo.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text900,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      color: branchInfo.status == 'open'
                          ? AppColors.green600
                          : Colors.red,
                    ),
                    child: Text(
                      branchInfo.status,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(
                    onPressed: () => GoRouter.of(context).pop(),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    color: Colors.white,
                    icon: const Icon(Icons.favorite),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
