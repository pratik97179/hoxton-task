import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();

  final appRouter = createAppRouter();

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
