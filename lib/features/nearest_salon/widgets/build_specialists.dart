import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyuu_test/theme/colors.dart';

import '../model/branch_info.dart';

const double _height = 110;

class BuildSpecialists extends StatelessWidget {
  const BuildSpecialists({super.key, required this.branchInfo});

  final BranchInfo branchInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        scrollDirection: Axis.horizontal,
        itemCount: branchInfo.experts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (_, i) => _BuildItem(expert: branchInfo.experts[i]),
      ),
    );
  }
}

class _BuildItem extends StatelessWidget {
  const _BuildItem({required this.expert});

  final BranchInfoExpert expert;

  @override
  Widget build(BuildContext context) {
    const width = 64.0;

    return SizedBox(
      height: _height,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(500),
            child: CachedNetworkImage(
              imageUrl: expert.imageUrl,
              width: width,
              height: width,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: width,
                height: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade100,
                ),
                child: Icon(
                  Icons.person,
                  size: 24,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
          ),
          const Spacer(flex: 3),
          Text(
            expert.name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.text900,
            ),
          ),
          const Spacer(flex: 1),
          Text(
            expert.role,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.text200,
            ),
          ),
        ],
      ),
    );
  }
}
