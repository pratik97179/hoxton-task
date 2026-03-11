import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/session/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();

  final sessionManager = sl<SessionManager>();
  await sessionManager.restoreFromStorage();

  final prefs = await SharedPreferences.getInstance();
  var hasAccessToken =
      (prefs.getString('accessToken')?.isNotEmpty ?? false);

  if (hasAccessToken && sessionManager.session == null) {
    await sessionManager.clear();
    hasAccessToken = false;
  }

  final appRouter = createAppRouter(hasAccessToken: hasAccessToken);

  runApp(HoxtonApp(router: appRouter));
}

class HoxtonApp extends StatelessWidget {
  const HoxtonApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hoxton Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: ThemeData().textTheme.apply(fontFamily: 'Sentient'),
      ),
      routerConfig: router,
    );
  }
}
