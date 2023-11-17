import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kyuu_test/common/extensions/double_extensions.dart';
import 'package:kyuu_test/common/helpers/helpers.dart';
import 'package:kyuu_test/common/widgets/read_more_text.dart';
import 'package:kyuu_test/theme/colors.dart';

import '../model/branch_info.dart';

class TabAbout extends StatelessWidget {
  const TabAbout({super.key, required this.branchInfo});

  final BranchInfo branchInfo;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20),
      children: [
        _BuildAboutText(text: branchInfo.about.text),
        const _BuildTitle(
          text: 'Opening Hours',
          paddingTop: 25,
          paddingBottom: 10,
        ),
        _BuildOpeningHoursRow(
          label: 'Monday - Friday:',
          open: branchInfo.openHours.weekDays.openAt,
          close: branchInfo.openHours.weekDays.closeAt,
        ),
        const SizedBox(height: 7),
        _BuildOpeningHoursRow(
          label: 'Saturday - Sunday:',
          open: branchInfo.openHours.weekEnds.openAt,
          close: branchInfo.openHours.weekEnds.closeAt,
        ),
        const _BuildTitle(
          text: 'Contact',
          paddingTop: 25,
          paddingBottom: 10,
        ),
        _BuildPhoneNumbers(contacts: branchInfo.about.contact),
        const _BuildTitle(
          text: 'Address',
          paddingTop: 25,
          paddingBottom: 10,
        ),
        _BuildMapView(branchInfo: branchInfo),
      ],
    );
  }
}

class _BuildAboutText extends StatelessWidget {
  const _BuildAboutText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: ReadMoreText(
        '$text  ',
        textAlign: TextAlign.justify,
        trimLines: 3,
        trimMode: TrimMode.line,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 23 / 14,
          color: AppColors.text600,
        ),
        moreStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          height: 23 / 14,
          color: AppColors.text600,
        ),
        lessStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          height: 23 / 14,
          color: AppColors.text600,
        ),
      ),
    );
  }
}

class _BuildTitle extends StatelessWidget {
  const _BuildTitle({
    required this.text,
    required this.paddingTop,
    required this.paddingBottom,
  });

  final String text;
  final double paddingTop;
  final double paddingBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
        top: paddingTop,
        bottom: paddingBottom,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.text900,
        ),
      ),
    );
  }
}

class _BuildOpeningHoursRow extends StatelessWidget {
  const _BuildOpeningHoursRow({
    required this.label,
    required this.open,
    required this.close,
  });

  final String label;
  final String open;
  final String close;

  @override
  Widget build(BuildContext context) {
    int openHour = int.tryParse(open.substring(0, 2)) ?? 0;
    String openMinute = open.substring(3, 5);
    int closeHour = int.tryParse(close.substring(0, 2)) ?? 0;
    String closeMinute = close.substring(3, 5);

    String finalText = '$openHour:$openMinute am - $closeHour:$closeMinute pm';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.text300,
              ),
            ),
          ),
          Expanded(
            child: Text(
              finalText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.text600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildPhoneNumbers extends StatelessWidget {
  const _BuildPhoneNumbers({required this.contacts});

  final List<String> contacts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          for (var i = 0; i < contacts.length; i++) ...[
            GestureDetector(
              onTap: () {
                callPhoneNumber(contacts[i]);
              },
              child: Text(
                contacts[i],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            if (contacts.length - 1 > i)
              const Text(
                ',   ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text600,
                  decoration: TextDecoration.underline,
                ),
              ),
          ]
        ],
      ),
    );
  }
}

class _BuildMapView extends StatelessWidget {
  const _BuildMapView({required this.branchInfo});

  final BranchInfo branchInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            branchInfo.address.orientation,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.text600,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              imageUrl: branchInfo.address.mapPicture,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: double.infinity,
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade100,
                ),
                child: Icon(
                  Icons.map,
                  color: Colors.grey.shade300,
                  size: 50,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          MaterialButton(
            onPressed: () {},
            minWidth: double.infinity,
            height: 58,
            color: AppColors.primary500,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/svg/navigation_stroke.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Get directions - ${branchInfo.space.getKmOrM}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
