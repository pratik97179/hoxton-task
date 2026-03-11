import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_image.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/features/intro/pre_boarding_constants.dart';
import 'package:hoxton_task/features/intro/widgets/animated_ellipsis.dart';
import 'package:hoxton_task/features/intro/widgets/phrase_carousel.dart';

class PreBoardingContent extends StatelessWidget {
  const PreBoardingContent({
    super.key,
    required this.step,
    required this.phraseController,
  });

  final PreBoardingStep step;
  final PhraseCarouselController phraseController;

  static const TextStyle _headlineStyle = TextStyle(
    color: AppColors.white,
    fontSize: 32,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle _phraseStyle = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Headline(step: step),
          const SizedBox(height: AppSpacing.spacing12),
          PhraseCarousel(
            controller: phraseController,
            style: _phraseStyle,
          ),
          const SizedBox(height: AppSpacing.spacing32),
          _StepsSection(step: step),
        ],
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline({required this.step});

  final PreBoardingStep step;

  @override
  Widget build(BuildContext context) {
    final content = step == PreBoardingStep.complete
        ? Text(
            PreBoardingConstants.headlineReady,
            textAlign: TextAlign.center,
            style: PreBoardingContent._headlineStyle,
          )
        : Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                PreBoardingConstants.headlineBuilding,
                textAlign: TextAlign.center,
                style: PreBoardingContent._headlineStyle,
              ),
              AnimatedEllipsis(
                prefix: PreBoardingConstants.headlineTypingWord,
                style: PreBoardingContent._headlineStyle,
              ),
            ],
          );
    return Center(child: content);
  }
}

class _StepsSection extends StatelessWidget {
  const _StepsSection({required this.step});

  final PreBoardingStep step;

  @override
  Widget build(BuildContext context) {
    final showFadeMask =
        step == PreBoardingStep.profileLoading ||
        step == PreBoardingStep.profileDone;
    final isProfileLoading = step == PreBoardingStep.profileLoading;
    final isProfileDone = step.index >= PreBoardingStep.profileDone.index;
    final isDashboardLoading = step == PreBoardingStep.dashboardLoading;
    final isDashboardDone = step.index >= PreBoardingStep.dashboardDone.index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _StepRow(
          leading: isProfileLoading
              ? const CupertinoActivityIndicator(
                  radius: 10,
                  color: AppColors.white,
                )
              : AppImage.svg(
                  isProfileDone
                      ? PreBoardingConstants.radioTickedSvg
                      : PreBoardingConstants.radioEmptySvg,
                  height: 20,
                ),
          label: isProfileDone
              ? PreBoardingConstants.step1LabelDone
              : PreBoardingConstants.step1LabelLoading,
          dimmed: false,
        ),
        const SizedBox(height: AppSpacing.spacing12),
        Center(
          child: BottomFadeMask(
            showMask: showFadeMask,
            child: _StepRow(
              leading: isDashboardLoading
                  ? const CupertinoActivityIndicator(
                      color: AppColors.white,
                      radius: 10,
                    )
                  : AppImage.svg(
                      isDashboardDone
                          ? PreBoardingConstants.radioTickedSvg
                          : PreBoardingConstants.radioEmptySvg,
                      height: 20,
                    ),
              label: PreBoardingConstants.step2Label,
              dimmed: !isDashboardLoading && !isDashboardDone,
            ),
          ),
        ),
      ],
    );
  }
}

class BottomFadeMask extends StatelessWidget {
  const BottomFadeMask({
    super.key,
    required this.showMask,
    required this.child,
  });

  final bool showMask;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!showMask) return child;

    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment(0, -0.5),
        end: Alignment.bottomCenter,
        colors: [AppColors.coolGrey, Colors.transparent],
      ).createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.leading,
    required this.label,
    required this.dimmed,
  });

  final Widget leading;
  final String label;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final color = dimmed
        ? AppColors.white.withValues(alpha: 0.5)
        : AppColors.white;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leading,
        const SizedBox(width: AppSpacing.spacing8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
