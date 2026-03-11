import 'package:flutter/material.dart';

import 'package:hoxton_task/core/design/components/app_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWithBgDecor(
      body: Center(
        child: Text(
          'Home page',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}

