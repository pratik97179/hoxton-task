import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hoxton_task/core/design/components/app_button.dart';
import 'package:hoxton_task/core/design/components/app_image.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/core/router/app_route_names.dart';
import 'package:hoxton_task/features/intro/controllers/intro_content_controller.dart';
import 'package:hoxton_task/features/intro/intro_constants.dart';

class IntroContent extends StatefulWidget {
  const IntroContent({super.key, required this.controller});

  final IntroContentController controller;

  @override
  State<IntroContent> createState() => _IntroContentState();
}

class _IntroContentState extends State<IntroContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pinController;
  final ValueNotifier<double> _unpinnedSpacerHeight = ValueNotifier<double>(200);

  @override
  void initState() {
    super.initState();
    _pinController = AnimationController(
      vsync: this,
      duration: IntroConstants.slideDuration,
    );
    widget.controller.headerStage.addListener(_onHeaderStageChanged);
  }

  void _onHeaderStageChanged() {
    if (widget.controller.headerStage.value ==
            IntroHeaderStage.movedToTop &&
        !_pinController.isAnimating &&
        _pinController.status != AnimationStatus.completed) {
      _pinController.forward();
    }
  }

  @override
  void dispose() {
    widget.controller.headerStage.removeListener(_onHeaderStageChanged);
    _unpinnedSpacerHeight.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<IntroHeaderStage>(
      valueListenable: widget.controller.headerStage,
      builder: (context, currentStage, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = constraints.maxHeight;
            final unpinnedHeight = maxHeight * 0.35;
            if (currentStage == IntroHeaderStage.rightTextVisible &&
                (_unpinnedSpacerHeight.value - unpinnedHeight).abs() > 1) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted &&
                    widget.controller.headerStage.value ==
                        IntroHeaderStage.rightTextVisible) {
                  _unpinnedSpacerHeight.value = unpinnedHeight;
                }
              });
            }

            final showHeadlineTitle = currentStage.index >=
                IntroHeaderStage.takeControlVisible.index;
            final showHeadlineSubtitle = currentStage.index >=
                IntroHeaderStage.rightTextVisible.index;
            final isHeaderPinnedToTop =
                currentStage == IntroHeaderStage.movedToTop;

            return ValueListenableBuilder<double>(
              valueListenable: _unpinnedSpacerHeight,
              builder: (context, unpinnedSpacerHeight, _) {
                return AnimatedBuilder(
                  animation: _pinController,
                  builder: (context, _) {
                    final height = isHeaderPinnedToTop
                        ? IntroConstants.headerTopInset +
                            (unpinnedSpacerHeight -
                                    IntroConstants.headerTopInset) *
                                (1.0 - _pinController.value)
                        : unpinnedHeight;
                    return Column(
                      children: [
                        SizedBox(height: height),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.spacing16,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AnimatedOpacity(
                                    opacity: showHeadlineTitle ? 1 : 0,
                                    duration: const Duration(milliseconds: 400),
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
                                    opacity: showHeadlineSubtitle ? 1 : 0,
                                    duration: const Duration(milliseconds: 400),
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
                                opacity: showHeadlineSubtitle ? 1 : 0,
                                duration: const Duration(milliseconds: 400),
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
                        const SizedBox(
                            height: IntroConstants.headerToFeaturesSpacing),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.spacing16,
                            ),
                            child: ValueListenableBuilder<int>(
                              valueListenable: widget.controller.visibleItemCount,
                              builder: (context, revealedFeatureCount, _) {
                                return SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(
                                      IntroConstants.servicesList.length,
                                      (index) {
                                        final isFeatureRevealed =
                                            index < revealedFeatureCount;
                                        return AnimatedOpacity(
                                          duration: const Duration(milliseconds: 200),
                                          opacity: isFeatureRevealed ? 1 : 0,
                                          child: AnimatedSlide(
                                            duration: const Duration(milliseconds: 200),
                                            offset: isFeatureRevealed
                                                ? Offset.zero
                                                : const Offset(0, 0.4),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                vertical:
                                                    IntroConstants.featureRowVerticalPadding,
                                              ),
                                              child: _IntroFeatureRow(
                                                label:
                                                    IntroConstants.servicesList[index].label,
                                                iconPath: IntroConstants
                                                    .servicesList[index]
                                                    .iconPath,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.spacing16,
                          ),
                          child: ValueListenableBuilder<bool>(
                            valueListenable: widget.controller.showContinue,
                            builder: (context, isContinueRevealed, _) => AnimatedOpacity(
                              opacity: isContinueRevealed ? 1 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: AnimatedSlide(
                                duration: const Duration(milliseconds: 300),
                                offset: isContinueRevealed
                                    ? Offset.zero
                                    : const Offset(0, 0.4),
                                child: _IntroBottomSection(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
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
