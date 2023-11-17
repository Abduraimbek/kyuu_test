import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kyuu_test/common/widgets/custom_app_bar_action_button.dart';
import 'package:kyuu_test/theme/colors.dart';

import '../widgets/nearest_salon_list.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/girl.jpg',
              width: 40,
              height: 40,
            ),
          ),
        ),
        actions: const [
          CustomAppBarActionButton(icon: Icons.notifications_outlined),
          SizedBox(width: 10),
          CustomAppBarActionButton(icon: Icons.search_outlined),
          SizedBox(width: 25),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 15),
            child: Text(
              'Hi, Jenny Wilson',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.dark900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 7),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/location_stroke.svg',
                  width: 15,
                  height: 15,
                  colorFilter: const ColorFilter.mode(
                    AppColors.text300,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 5),
                const Expanded(
                  child: Text(
                    '6391 Elgin St. Celina, Delaware 10299',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.text300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 15),
            child: Text(
              'Nearest salon',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.dark900,
              ),
            ),
          ),
          const Expanded(
            child: NearestSalonList(),
          ),
        ],
      ),
    );
  }
}
