import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyuu_test/theme/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../controller/branch_info_controller.dart';
import '../model/branch_info.dart';

class TabGallery extends ConsumerWidget {
  const TabGallery({super.key, required this.branchInfo});

  final BranchInfo branchInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue =
        ref.watch(fetchBranchGalleryProvider(branchId: branchInfo.id));

    if (asyncValue.hasError && asyncValue.isLoading) {
      return const _BuildLoading();
    }

    return switch (asyncValue) {
      AsyncData(:final value) => _BuildData(images: value),
      AsyncError(:final error) => _BuildError(
          onPressed: () => ref.invalidate(fetchBranchGalleryProvider),
          error: error.toString(),
        ),
      _ => const _BuildLoading(),
    };
  }
}

class _BuildData extends StatelessWidget {
  const _BuildData({required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.only(top: 20, bottom: 60),
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: images[index],
        );
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
