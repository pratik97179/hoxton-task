import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hoxton_task/features/intro/pages/email_page.dart';
import 'package:hoxton_task/features/intro/pages/intro_page.dart';
import 'package:hoxton_task/features/intro/pages/password_page.dart';
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
          final onSubmit = state.extra as VoidCallback?;
          switch (mode) {
            case 'confirm':
              return PasswordPage.confirm(onSubmit: onSubmit);
            case 'verify':
              return PasswordPage.verify(onSubmit: onSubmit);
            default:
              return PasswordPage.set(onSubmit: onSubmit);
          }
        },
      ),
    ],
  );
}
