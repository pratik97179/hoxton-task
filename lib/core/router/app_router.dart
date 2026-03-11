import 'package:go_router/go_router.dart';

import 'package:hoxton_task/core/router/app_route_names.dart';
import 'package:hoxton_task/features/auth/presentation/pages/password_page.dart';
import 'package:hoxton_task/features/home/presentation/pages/home_page.dart';
import 'package:hoxton_task/features/auth/presentation/pages/email_page.dart';
import 'package:hoxton_task/features/intro/pages/intro_page.dart';
import 'package:hoxton_task/features/intro/pages/pre_boarding_page.dart';

GoRouter createAppRouter({required bool hasAccessToken}) {
  return GoRouter(
    initialLocation:
        hasAccessToken ? AppRouteNames.home : AppRouteNames.intro,
    routes: [
      GoRoute(
        path: AppRouteNames.intro,
        name: AppRouteNames.introName,
        builder: (context, state) => const IntroPage(),
      ),
      GoRoute(
        path: AppRouteNames.email,
        name: AppRouteNames.emailName,
        builder: (context, state) => const EmailPage(),
      ),
      GoRoute(
        path: AppRouteNames.password,
        name: AppRouteNames.passwordName,
        builder: (context, state) {
          final mode = state.uri.queryParameters['mode'] ?? 'set';
          final String? email = state.extra is String ? state.extra as String : null;
          switch (mode) {
            case 'verify':
              return PasswordPage.verify(email: email);
            case 'set':
            default:
              return PasswordPage.set(email: email);
          }
        },
      ),
      GoRoute(
        path: AppRouteNames.preBoarding,
        name: AppRouteNames.preBoardingName,
        builder: (context, state) {
          final String? userName =
              state.extra is String ? state.extra as String : null;
          return PreBoardingPage(
            userName: userName,
            onComplete: () => context.go(AppRouteNames.home),
          );
        },
      ),
      GoRoute(
        path: AppRouteNames.home,
        name: AppRouteNames.homeName,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
