import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyuu_test/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/branches_controller.dart';
import '../model/branch.dart';
import 'nearest_salon_list_item.dart';

class NearestSalonList extends ConsumerWidget {
  const NearestSalonList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(fetchBranchesProvider);

    if (asyncValue.hasError && asyncValue.isLoading) {
      return const _BuildLoading();
    }

    return switch (asyncValue) {
      AsyncData(:final value) => _BuildList(branches: value),
      AsyncError(:final error) => _BuildError(error: error.toString()),
      _ => const _BuildLoading(),
    };
  }
}

class _BuildList extends ConsumerWidget {
  const _BuildList({required this.branches});

  final List<Branch> branches;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () => ref.refresh(fetchBranchesProvider.future),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 9),
        itemCount: branches.length,
        itemBuilder: (context, index) {
          return NearestSalonListItem(branch: branches[index]);
        },
      ),
    );
  }
}

class _BuildError extends ConsumerWidget {
  const _BuildError({required this.error});

  final String error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onPressed: () {
              ref.invalidate(fetchBranchesProvider);
            },
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
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 9),
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: List.generate(
            10,
            (index) => Container(
              width: double.infinity,
              height: 190,
              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
