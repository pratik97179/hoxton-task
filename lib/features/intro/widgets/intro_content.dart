import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hoxton_task/core/design/components/app_image.dart';
import 'package:hoxton_task/core/router/app_route_names.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/intro/intro_constants.dart';

enum _IntroHeaderStage {
  initial,
  takeControlVisible,
  rightTextVisible,
  movedToTop,
}

class IntroContent extends StatefulWidget {
  const IntroContent({super.key});

  @override
  State<IntroContent> createState() => _IntroContentState();
}

class _IntroContentState extends State<IntroContent> {
  final ValueNotifier<_IntroHeaderStage> _headerStage =
      ValueNotifier<_IntroHeaderStage>(_IntroHeaderStage.initial);
  final ValueNotifier<int> _visibleItemCount = ValueNotifier<int>(0);
  final ValueNotifier<bool> _showContinue = ValueNotifier<bool>(false);

  int get _featureCount => IntroConstants.servicesList.length;

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    _headerStage.value = _IntroHeaderStage.takeControlVisible;

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    _headerStage.value = _IntroHeaderStage.rightTextVisible;

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    _headerStage.value = _IntroHeaderStage.movedToTop;

    for (int i = 0; i < _featureCount; i++) {
      await Future.delayed(const Duration(milliseconds: 450));
      if (!mounted) return;
      _visibleItemCount.value = i + 1;
    }

    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    _showContinue.value = true;
  }

  double _headlineBlockHeight() {
    const fs = 36.0;
    const lineHeight = 1.2;
    return fs * lineHeight * 3 + 24;
  }

  @override
  void dispose() {
    _headerStage.dispose();
    _visibleItemCount.dispose();
    _showContinue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<_IntroHeaderStage>(
      valueListenable: _headerStage,
      builder: (context, headerStage, _) {
        final size = MediaQuery.sizeOf(context);
        final isTakeControlVisible =
            headerStage.index >= _IntroHeaderStage.takeControlVisible.index;
        final isRightTextVisible =
            headerStage.index >= _IntroHeaderStage.rightTextVisible.index;
        final isMovedToTop = headerStage == _IntroHeaderStage.movedToTop;

        return SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Headline block
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
                      child: Text(
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

              // Feature list
              Positioned(
                left: AppSpacing.spacing16,
                right: AppSpacing.spacing16,
                top: () {
                  final headerTop = isMovedToTop
                      ? 78.0
                      : isTakeControlVisible
                      ? size.height / 2 - 60
                      : size.height / 2;
                  final belowHeader = headerTop + _headlineBlockHeight() + 24;
                  return math.max(size.height * 0.30, belowHeader);
                }(),
                child: ValueListenableBuilder<int>(
                  valueListenable: _visibleItemCount,
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

              // Bottom section: Get started + home indicator
              Positioned(
                bottom: 20,
                left: AppSpacing.spacing16,
                right: AppSpacing.spacing16,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _showContinue,
                  builder: (context, showContinue, _) => AnimatedOpacity(
                    opacity: showContinue ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 300),
                      offset: showContinue ? Offset.zero : const Offset(0, 0.3),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.spacing16),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => context.go(AppRouteNames.email),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.white,
                side: const BorderSide(color: AppColors.white, width: 2),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacing16,
                  vertical: AppSpacing.spacing8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.spacing8),
                ),
                backgroundColor: AppColors.primaryBg,
              ),
              child: const Text(
                'Get started',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
