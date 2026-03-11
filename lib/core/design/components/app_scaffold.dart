import 'package:flutter/material.dart';

import 'package:hoxton_task/core/design/components/app_image.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';

class AppScaffoldWithBgDecor extends StatelessWidget {
  const AppScaffoldWithBgDecor({
    super.key,
    required this.body,
    this.resizeToAvoidBottomInset,
  });

  final Widget body;

  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AppBackgroundDecor(),
          SafeArea(child: body),
        ],
      ),
    );
  }
}

class AppBackgroundDecor extends StatelessWidget {
  const AppBackgroundDecor({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: AppSpacing.spacing48 + AppSpacing.spacing12,
          left: -(AppSpacing.spacing48 * 3),
          child: AppImage.asset(
            'assets/images/png/hoxton_main.png',
            height: AppSpacing.spacing48 * 5,
            fit: BoxFit.fitHeight,
            color: AppColors.white.withValues(alpha: 0.04),
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
        Positioned(
          bottom: 0,
          right: -(AppSpacing.spacing48 * 2),
          child: AppImage.asset(
            'assets/images/png/hoxton_main.png',
            height: AppSpacing.spacing48 * 5,
            fit: BoxFit.fitHeight,
            color: AppColors.white.withValues(alpha: 0.04),
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}
