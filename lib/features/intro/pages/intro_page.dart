import 'package:flutter/material.dart';

import 'package:hoxton_task/core/design/components/app_scaffold.dart';
import 'package:hoxton_task/features/intro/services/intro_splash_controller.dart';
import 'package:hoxton_task/features/intro/widgets/intro_content.dart';
import 'package:hoxton_task/features/intro/widgets/intro_splash_body.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with TickerProviderStateMixin {
  late final IntroSplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = IntroSplashController(vsync: this);
    _controller.start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWithBgDecor(
      body: ValueListenableBuilder<int>(
        valueListenable: _controller.phase,
        builder: (context, phase, _) {
          if (phase == 4) {
            return IntroContent();
          }
          if (phase == 3) {
            return AnimatedBuilder(
              animation: _controller.fadeOutProgress,
              builder: (context, _) {
                return Opacity(
                  opacity: 1 - _controller.fadeOutProgress.value,
                  child: IntroSplashBody(
                    phase: 2,
                    revealProgress: _controller.revealProgress,
                  ),
                );
              },
            );
          }
          return IntroSplashBody(
            phase: phase,
            revealProgress: _controller.revealProgress,
          );
        },
      ),
    );
  }
}
