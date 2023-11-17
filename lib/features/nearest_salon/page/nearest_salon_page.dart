import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyuu_test/theme/colors.dart';

import '../controller/branch_info_controller.dart';
import '../controller/package_info_controller.dart';
import '../model/branch_info.dart';
import '../widgets/build_branch_actions.dart';
import '../widgets/build_branch_address_and_rating.dart';
import '../widgets/build_branch_images.dart';
import '../widgets/build_specialists.dart';
import '../widgets/build_specialists_title.dart';
import '../widgets/tab_about.dart';
import '../widgets/tab_empty.dart';
import '../widgets/tab_gallery.dart';
import '../widgets/tab_package.dart';

class NearestSalonPage extends ConsumerWidget {
  const NearestSalonPage({
    super.key,
    required this.branchId,
    required this.rating,
  });

  static const path = '/nearestSalon';

  final String branchId;
  final double rating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(fetchBranchGalleryProvider(branchId: branchId), (_, __) {});
    ref.listen(fetchPackagesProvider(branchId: branchId), (_, __) {});

    final asyncValue = ref.watch(fetchBranchInfoProvider(branchId: branchId));

    if (asyncValue.hasError && asyncValue.isLoading) {
      return const _BuildLoading();
    }

    return switch (asyncValue) {
      AsyncData(:final value) => _BuildData(
          branchInfo: value,
          rating: rating,
        ),
      AsyncError(:final error) => _BuildError(
          onPressed: () => ref.invalidate(fetchBranchInfoProvider),
          error: error.toString(),
        ),
      _ => const _BuildLoading(),
    };
  }
}

class _BuildData extends StatelessWidget {
  const _BuildData({
    required this.branchInfo,
    required this.rating,
  });

  final BranchInfo branchInfo;
  final double rating;

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.paddingOf(context).top;
    const double height = 41;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ExtendedNestedScrollView(
          headerSliverBuilder: (c, i) {
            return [
              SliverToBoxAdapter(
                child: BuildBranchImages(branchInfo: branchInfo),
              ),
              SliverToBoxAdapter(
                child: BuildBranchAddressAndRating(
                  branchInfo: branchInfo,
                  rating: rating,
                ),
              ),
              SliverToBoxAdapter(
                child: BuildBranchActions(branchInfo: branchInfo),
              ),
            ];
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: topPadding),
              const BuildSpecialistsTitle(),
              BuildSpecialists(branchInfo: branchInfo),
              const SizedBox(height: 30),
              SizedBox(
                height: height,
                child: TabBar(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  labelPadding: const EdgeInsets.only(left: 17, right: 17),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: AppColors.text900,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.text100,
                  labelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: 'About'),
                    Tab(text: 'Services'),
                    Tab(text: 'Package'),
                    Tab(text: 'Gallery'),
                    Tab(text: 'Reviews'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  children: [
                    TabAbout(branchInfo: branchInfo),
                    const TabEmpty(),
                    TabPackage(branchInfo: branchInfo),
                    TabGallery(branchInfo: branchInfo),
                    const TabEmpty(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // return DefaultTabController(
    //   length: 5,
    //   child: Scaffold(
    //     body: NestedScrollView(
    //       floatHeaderSlivers: true,
    //       headerSliverBuilder: (context, innerBoxIsScrolled) {
    //         return [
    //           SliverToBoxAdapter(
    //             child: BuildBranchImages(branchInfo: branchInfo),
    //           ),
    //           SliverToBoxAdapter(
    //             child: BuildBranchAddressAndRating(
    //               branchInfo: branchInfo,
    //               rating: rating,
    //             ),
    //           ),
    //           SliverToBoxAdapter(
    //             child: BuildBranchActions(branchInfo: branchInfo),
    //           ),
    //           const SliverToBoxAdapter(
    //             child: BuildSpecialistsTitle(),
    //           ),
    //           SliverToBoxAdapter(
    //             child: BuildSpecialists(branchInfo: branchInfo),
    //           ),
    //           // SliverPersistentHeader(
    //           //   pinned: true,
    //           //   delegate: CustomSliverPersistentHeaderDelegate(
    //           //     minHeight: 110,
    //           //     maxHeight: 110,
    //           //     child: BuildSpecialists(branchInfo: branchInfo),
    //           //   ),
    //           // ),
    //           SliverPersistentHeader(
    //             pinned: true,
    //             delegate: CustomSliverPersistentHeaderDelegate(
    //               minHeight: topPadding + height + 2,
    //               maxHeight: topPadding + height + 2,
    //               child: Container(
    //                 color: Theme.of(context).scaffoldBackgroundColor,
    //                 alignment: Alignment.bottomLeft,
    //                 padding: const EdgeInsets.only(bottom: 2),
    //                 child: SizedBox(
    //                   height: height,
    //                   child: TabBar(
    //                     padding: const EdgeInsets.only(left: 30, right: 30),
    //                     labelPadding:
    //                         const EdgeInsets.only(left: 17, right: 17),
    //                     isScrollable: true,
    //                     tabAlignment: TabAlignment.start,
    //                     indicatorSize: TabBarIndicatorSize.tab,
    //                     dividerHeight: 0,
    //                     dividerColor: Colors.transparent,
    //                     indicator: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(23),
    //                       color: AppColors.text900,
    //                     ),
    //                     labelColor: Colors.white,
    //                     unselectedLabelColor: AppColors.text100,
    //                     labelStyle: const TextStyle(
    //                       fontSize: 13,
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //                     unselectedLabelStyle: const TextStyle(
    //                       fontSize: 13,
    //                       fontWeight: FontWeight.w500,
    //                     ),
    //                     tabs: const [
    //                       Tab(text: 'About'),
    //                       Tab(text: 'Services'),
    //                       Tab(text: 'Package'),
    //                       Tab(text: 'Gallery'),
    //                       Tab(text: 'Reviews'),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ];
    //       },
    //       body: TabBarView(
    //         children: [
    //           TabAbout(branchInfo: branchInfo),
    //           const TabEmpty(),
    //           const TabEmpty(),
    //           const TabEmpty(),
    //           const TabEmpty(),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class _BuildError extends StatelessWidget {
  const _BuildError({
    required this.onPressed,
    required this.error,
  });

  final VoidCallback onPressed;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Oops! $error',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.text300,
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildLoading extends StatelessWidget {
  const _BuildLoading();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
