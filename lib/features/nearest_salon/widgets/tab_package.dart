import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kyuu_test/theme/colors.dart';

import '../controller/package_info_controller.dart';
import '../model/branch_info.dart';
import '../model/package.dart';
import '../page/show_package_info_bottom_sheet.dart';

class TabPackage extends ConsumerWidget {
  const TabPackage({super.key, required this.branchInfo});

  final BranchInfo branchInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue =
        ref.watch(fetchPackagesProvider(branchId: branchInfo.id));

    if (asyncValue.hasError && asyncValue.isLoading) {
      return const _BuildLoading();
    }

    return switch (asyncValue) {
      AsyncData(:final value) => _BuildData(packages: value),
      AsyncError(:final error) => _BuildError(
          onPressed: () => ref.invalidate(fetchPackagesProvider),
          error: error.toString(),
        ),
      _ => const _BuildLoading(),
    };
  }
}

class _BuildData extends StatelessWidget {
  const _BuildData({required this.packages});

  final List<Package> packages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      itemCount: packages.length,
      itemBuilder: (context, index) {
        return _BuildItem(package: packages[index]);
      },
    );
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
    return Center(
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
    );
  }
}

class _BuildLoading extends StatelessWidget {
  const _BuildLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _BuildItem extends StatelessWidget {
  const _BuildItem({required this.package});

  final Package package;

  @override
  Widget build(BuildContext context) {
    const double height = 112;
    String sum = NumberFormat.currency(
      locale: 'uz_UZ',
      decimalDigits: 0,
      name: 'SUM',
    ).format(package.price);

    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: package.imageUrl,
              width: 130,
              height: height,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: 130,
                height: height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.image,
                  color: Colors.grey.shade300,
                  size: 40,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4),
                Text(
                  package.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  package.shortInfo,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.text300,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        sum,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        sShowPackageInfoBottomSheet(
                          context: context,
                          packageId: package.id,
                          screenHeight: MediaQuery.sizeOf(context).height,
                        );
                      },
                      height: 28,
                      textColor: Colors.white,
                      color: AppColors.primary500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
