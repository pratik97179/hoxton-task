import 'package:go_router/go_router.dart';

import 'package:hoxton_task/features/intro/pages/intro_page.dart';
import 'package:hoxton_task/core/router/app_route_names.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRouteNames.intro,
    routes: [
      GoRoute(
        path: AppRouteNames.intro,
        name: AppRouteNames.introName,
        builder: (context, state) => const IntroPage(),
      ),
    ],
  );
}
