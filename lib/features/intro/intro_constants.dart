/// Intro screen: durations, asset paths, and feature list.
abstract final class IntroConstants {
  IntroConstants._();

  // Durations
  static const Duration initialWait = Duration(seconds: 1);
  static const Duration slideDuration = Duration(milliseconds: 300);
  static const Duration textRevealDuration = Duration(milliseconds: 600);
  static const Duration pauseAfterSlide = Duration(milliseconds: 400);
  static const Duration pauseAfterReveal = Duration(milliseconds: 400);

  /// Splash fades out before showing intro content.
  static const Duration splashFadeOutDuration = Duration(milliseconds: 200);

  // Assets
  static const String splashImagePath = 'assets/images/png/hoxton_main.png';
  static const String onboardingIcon1 =
      'assets/images/svg/onboarding_intro_icon1.svg';
  static const String onboardingIcon2 =
      'assets/images/svg/onboarding_intro_icon2.svg';
  static const String onboardingIcon3 =
      'assets/images/svg/onboarding_intro_icon3.svg';
  static const String onboardingIcon4 =
      'assets/images/svg/onboarding_intro_icon4.svg';

  // Content screen animation
  static const Duration contentTakeControlFadeIn = Duration(milliseconds: 500);
  /// Headline AnimatedSize when "of Your..." renders invisible (Take Control slides up).
  static const Duration contentHeadlineExpandDuration =
      Duration(milliseconds: 600);
  static const Duration contentSecondPartFadeIn = Duration(milliseconds: 500);
  /// After "of Your..." visible, wait before features list appears.
  static const Duration contentPauseBeforeFeatures = Duration(milliseconds: 200);
  static const Duration contentFeaturesListExpandDuration =
      Duration(milliseconds: 600);
  static const Duration contentFeatureReveal = Duration(milliseconds: 400);
  static const Duration contentFeatureStagger = Duration(milliseconds: 350);
  static const Duration contentGetStartedFadeIn = Duration(milliseconds: 400);

  // Feature list: (label, iconPath)
  static const List<({String label, String iconPath})> features = [
    (label: 'Organize your finances in one place', iconPath: onboardingIcon1),
    (label: 'Track your financial performance', iconPath: onboardingIcon2),
    (label: 'Plan your Financial future', iconPath: onboardingIcon3),
    (label: 'Security you can trust', iconPath: onboardingIcon4),
  ];
}
