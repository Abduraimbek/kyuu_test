import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/main/page/main_page.dart';
import '../features/nearest_salon/page/nearest_salon_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: MainPage.path,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: MainPage.path,
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: NearestSalonPage.path,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final branchId = extra['branchId'] as String;
        final rating = extra['rating'] as double;
        return NearestSalonPage(
          branchId: branchId,
          rating: rating,
        );
      },
    ),
  ],
);
