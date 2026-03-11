import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hoxton_task/core/design/components/app_button.dart';
import 'package:hoxton_task/core/design/components/app_image.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/core/router/app_route_names.dart';
import 'package:hoxton_task/features/intro/controllers/intro_content_controller.dart';
import 'package:hoxton_task/features/intro/intro_constants.dart';

/// Presentational intro content. Receives [controller]; animation is started by the page.
class IntroContent extends StatelessWidget {
  const IntroContent({super.key, required this.controller});

  final IntroContentController controller;

  static double _headlineBlockHeight() {
    const fs = 36.0;
    const lineHeight = 1.2;
    return fs * lineHeight * 3 + 24;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<IntroHeaderStage>(
      valueListenable: controller.headerStage,
      builder: (context, headerStage, _) {
        final size = MediaQuery.sizeOf(context);
        final isTakeControlVisible =
            headerStage.index >= IntroHeaderStage.takeControlVisible.index;
        final isRightTextVisible =
            headerStage.index >= IntroHeaderStage.rightTextVisible.index;
        final isMovedToTop = headerStage == IntroHeaderStage.movedToTop;

        return SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                top: isMovedToTop
                    ? 78
                    : isTakeControlVisible
                        ? size.height / 2 - 60
                        : size.height / 2,
                left: AppSpacing.spacing16,
                right: AppSpacing.spacing16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AnimatedOpacity(
                          opacity: isTakeControlVisible ? 1 : 0,
                          duration: const Duration(milliseconds: 500),
                          child: const Text(
                            'Take Control',
                            style: TextStyle(
                              fontFamily: 'Sentient',
                              fontWeight: FontWeight.w400,
                              fontSize: 32,
                              height: 1.2,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: isRightTextVisible ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: const Text(
                            ' of Your',
                            style: TextStyle(
                              fontFamily: 'Sentient',
                              fontWeight: FontWeight.w400,
                              fontSize: 32,
                              height: 1.2,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AnimatedOpacity(
                      opacity: isRightTextVisible ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const Text(
                        'Wealth with Hoxton Wealth App',
                        style: TextStyle(
                          fontFamily: 'Sentient',
                          fontWeight: FontWeight.w400,
                          fontSize: 32,
                          height: 1.2,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: AppSpacing.spacing16,
                right: AppSpacing.spacing16,
                top: () {
                  final headerTop = isMovedToTop
                      ? 78.0
                      : isTakeControlVisible
                          ? size.height / 2 - 60
                          : size.height / 2;
                  final belowHeader =
                      headerTop + _headlineBlockHeight() + 24;
                  return math.max(size.height * 0.30, belowHeader);
                }(),
                child: ValueListenableBuilder<int>(
                  valueListenable: controller.visibleItemCount,
                  builder: (context, visibleItemCount, _) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        IntroConstants.servicesList.length,
                        (i) {
                          final showItem = i < visibleItemCount;
                          return AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: showItem ? 1 : 0,
                            child: AnimatedSlide(
                              duration: const Duration(milliseconds: 200),
                              offset: showItem
                                  ? Offset.zero
                                  : const Offset(0, 0.3),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 22,
                                ),
                                child: _IntroFeatureRow(
                                  label: IntroConstants.servicesList[i].label,
                                  iconPath:
                                      IntroConstants.servicesList[i].iconPath,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: AppSpacing.spacing16,
                right: AppSpacing.spacing16,
                child: ValueListenableBuilder<bool>(
                  valueListenable: controller.showContinue,
                  builder: (context, showContinue, _) => AnimatedOpacity(
                    opacity: showContinue ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 300),
                      offset:
                          showContinue ? Offset.zero : const Offset(0, 0.3),
                      child: _IntroBottomSection(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _IntroFeatureRow extends StatelessWidget {
  const _IntroFeatureRow({required this.label, required this.iconPath});

  final String label;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.spacing8),
          decoration: const BoxDecoration(
            color: AppColors.slateShade2,
            shape: BoxShape.circle,
          ),
          child: AppImage.svg(
            iconPath,
            width: AppSpacing.spacing32,
            height: AppSpacing.spacing32,
            color: AppColors.white,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: AppSpacing.spacing12),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                height: 1.2,
                color: AppColors.greyGreenTint2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _IntroBottomSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton.bordered(
      label: 'Get started',
      onPressed: () => context.go(AppRouteNames.email),
    );
  }
}
