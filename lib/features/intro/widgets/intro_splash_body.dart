import 'package:flutter/material.dart';

import 'package:hoxton_task/core/design/components/app_image.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/intro/intro_constants.dart';

class IntroSplashBody extends StatelessWidget {
  const IntroSplashBody({
    super.key,
    required this.phase,
    required this.revealProgress,
  });

  final int phase;
  final Animation<double> revealProgress;

  @override
  Widget build(BuildContext context) {
    final image = AppImage.asset(
      IntroConstants.splashImagePath,
      height: 38,
      fit: BoxFit.contain,
      color: AppColors.white,
      colorBlendMode: BlendMode.srcIn,
    );

    final textWidget = Padding(
      padding: const EdgeInsets.only(left: AppSpacing.spacing16),
      child: Text(
        'HoxtonWealth',
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 32,
          height: 1.2,
          color: AppColors.white,
        ),
      ),
    );

    Widget secondChild;
    if (phase == 2) {
      secondChild = AnimatedBuilder(
        animation: revealProgress,
        builder: (context, _) => ClipRect(
          clipper: _LeftToRightRevealClipper(
            progress: revealProgress.value,
          ),
          child: textWidget,
        ),
      );
    } else {
      secondChild = AnimatedSize(
        duration: IntroConstants.slideDuration,
        curve: Curves.easeOut,
        alignment: Alignment.centerLeft,
        child: phase == 0
            ? const SizedBox.shrink()
            : Opacity(opacity: 0, child: textWidget),
      );
    }

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [image, secondChild],
      ),
    );
  }
}

class _LeftToRightRevealClipper extends CustomClipper<Rect> {
  const _LeftToRightRevealClipper({required this.progress});

  final double progress;

  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, 0, size.width * progress.clamp(0.0, 1.0), size.height);

  @override
  bool shouldReclip(covariant _LeftToRightRevealClipper old) =>
      old.progress != progress;
}
