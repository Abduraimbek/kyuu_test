import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kyuu_test/common/helpers/helpers.dart';
import 'package:kyuu_test/theme/colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/branch_info.dart';

class BuildBranchActions extends StatelessWidget {
  const BuildBranchActions({super.key, required this.branchInfo});

  final BranchInfo branchInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: Row(
        children: [
          _BuildItem(
            onTap: () {
              launchUrl(
                Uri.parse(branchInfo.about.website),
                mode: LaunchMode.externalApplication,
              );
            },
            svgPath: 'assets/svg/chrome_stroke.svg',
            text: 'Website',
          ),
          _BuildItem(
            onTap: () {
              if (branchInfo.about.contact.isEmpty) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('No phone numbers.')),
                  );
              } else {
                callPhoneNumber(branchInfo.about.contact[0]);
              }
            },
            svgPath: 'assets/svg/phone_stroke.svg',
            text: 'Call',
          ),
          _BuildItem(
            onTap: () {
              Share.share(
                'lat: ${branchInfo.address.latitude}; long: ${branchInfo.address.longitude}',
              );
            },
            svgPath: 'assets/svg/location_stroke.svg',
            text: 'Direction',
          ),
          _BuildItem(
            onTap: () {
              shareApp();
            },
            svgPath: 'assets/svg/share_stroke.svg',
            text: 'Share',
          ),
        ],
      ),
    );
  }
}

class _BuildItem extends StatelessWidget {
  const _BuildItem({
    required this.onTap,
    required this.svgPath,
    required this.text,
  });

  final VoidCallback onTap;
  final String svgPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                svgPath,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.text900,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
