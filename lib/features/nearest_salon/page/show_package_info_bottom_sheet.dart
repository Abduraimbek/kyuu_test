import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kyuu_test/common/widgets/shimmer_placeholders.dart';
import 'package:kyuu_test/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/package_info_controller.dart';
import '../model/package_info.dart';

void sShowPackageInfoBottomSheet({
  required BuildContext context,
  required int packageId,
  required double screenHeight,
}) {
  showModalBottomSheet(
    context: context,
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return SizedBox(
        height: screenHeight * .9,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              width: 56,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.light600,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: _BuildContent(packageId: packageId),
            ),
          ],
        ),
      );
    },
  );
}

class _BuildContent extends ConsumerWidget {
  const _BuildContent({required this.packageId});

  final int packageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue =
        ref.watch(fetchPackageInfoProvider(packageId: packageId));

    if (asyncValue.hasError && asyncValue.isLoading) {
      return const _BuildLoading();
    }

    return switch (asyncValue) {
      AsyncData(:final value) => _BuildData(packageInfo: value),
      AsyncError(:final error) => _BuildError(
          onPressed: () => ref.invalidate(fetchPackageInfoProvider),
          error: error.toString(),
        ),
      _ => const _BuildLoading(),
    };
  }
}

class _BuildData extends StatelessWidget {
  const _BuildData({required this.packageInfo});

  final PackageInfo packageInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildImage(),
        buildTitle(
          text: packageInfo.name,
          paddingTop: 15,
          paddingBottom: 5,
        ),
        buildInfo(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFullInfo(),
                buildTitle(
                  text: 'Service',
                  paddingTop: 30,
                  paddingBottom: 17,
                ),
                buildServicesGrid(),
              ],
            ),
          ),
        ),
        buildButton(),
      ],
    );
  }

  Widget buildButton() {
    String sum = NumberFormat.currency(
      locale: 'uz_UZ',
      decimalDigits: 0,
      name: 'SUM',
    ).format(packageInfo.price);

    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 5,
        bottom: 40,
      ),
      child: MaterialButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        height: 58,
        minWidth: double.infinity,
        color: AppColors.primary500,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sum,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Text(
                'BOOK NOW',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildServiceItem(String text) {
    return Expanded(
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svg/check_stroke.svg',
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.text900,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildServiceRow(String? text1, String? text2) {
    if (text1 != null && text2 != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
        child: Row(
          children: [buildServiceItem(text1), buildServiceItem(text2)],
        ),
      );
    }

    if (text1 != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
        child: Row(
          children: [buildServiceItem(text1), const Spacer()],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget buildServicesGrid() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < packageInfo.services.length; i += 2)
          buildServiceRow(
            packageInfo.services.elementAtOrNull(i),
            packageInfo.services.elementAtOrNull(i + 1),
          ),
      ],
    );
  }

  Widget buildFullInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Text(
        packageInfo.fullInfo,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.text600,
        ),
      ),
    );
  }

  Widget buildInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 5),
      child: Text(
        packageInfo.shortInfo,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.text300,
        ),
      ),
    );
  }

  Widget buildImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: packageInfo.imageUrl,
          width: double.infinity,
          height: 137,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            width: double.infinity,
            height: 137,
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
    );
  }

  Widget buildTitle({
    required String text,
    required double paddingTop,
    required double paddingBottom,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        bottom: paddingBottom,
        left: 25,
        right: 25,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.text900,
        ),
      ),
    );
  }
}

class _BuildLoading extends StatelessWidget {
  const _BuildLoading();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BannerPlaceholder(height: 137),
            const SizedBox(height: 20),
            TitlePlaceholder(width: width * .45),
            const SizedBox(height: 20),
            TitlePlaceholder(width: width),
            const SizedBox(height: 20),
            TitlePlaceholder(width: width * .45),
            const SizedBox(height: 20),
            TitlePlaceholder(width: width),
            const SizedBox(height: 20),
            TitlePlaceholder(width: width),
            const SizedBox(height: 20),
            TitlePlaceholder(width: width),
            const Spacer(),
            const BannerPlaceholder(height: 58),
          ],
        ),
      ),
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
          Text('Oops! $error'),
          TextButton(
            onPressed: onPressed,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
