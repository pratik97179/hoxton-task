import 'package:flutter/material.dart';

import 'package:hoxton_task/core/design/components/app_scaffold.dart';
import 'package:hoxton_task/features/intro/controllers/intro_content_controller.dart';
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
  late final IntroContentController _introContentController;

  @override
  void initState() {
    super.initState();
    _controller = IntroSplashController(vsync: this);
    _controller.start();
    _introContentController = IntroContentController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _introContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWithBgDecor(
      body: ValueListenableBuilder<int>(
        valueListenable: _controller.phase,
        builder: (context, phase, _) {
          if (phase == 4) {
            return _IntroContentWithAnimation(
              controller: _introContentController,
            );
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

/// Starts the intro content animation once, then builds [IntroContent].
class _IntroContentWithAnimation extends StatefulWidget {
  const _IntroContentWithAnimation({required this.controller});

  final IntroContentController controller;

  @override
  State<_IntroContentWithAnimation> createState() =>
      _IntroContentWithAnimationState();
}

class _IntroContentWithAnimationState extends State<_IntroContentWithAnimation> {
  @override
  void initState() {
    super.initState();
    widget.controller.startAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return IntroContent(controller: widget.controller);
  }
}
