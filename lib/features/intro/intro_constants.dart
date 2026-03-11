
abstract final class IntroConstants {
  IntroConstants._();

  static const Duration initialWait = Duration(seconds: 1);
  static const Duration slideDuration = Duration(milliseconds: 300);
  static const Duration textRevealDuration = Duration(milliseconds: 600);
  static const Duration pauseAfterSlide = Duration(milliseconds: 400);
  static const Duration pauseAfterReveal = Duration(milliseconds: 400);

  static const Duration splashFadeOutDuration = Duration(milliseconds: 200);

  static const Duration introInitialDelay = Duration(milliseconds: 600);
  static const Duration introAfterTitleDelay = Duration(milliseconds: 500);
  static const Duration introAfterSubtitleDelay = Duration(milliseconds: 300);
  static const Duration introFeatureRevealDelay = Duration(milliseconds: 450);
  static const Duration introBeforeContinueDelay = Duration(milliseconds: 250);

  static const double headerTopInset = 78;
  static const double headerToFeaturesSpacing = 24;
  static const double featureRowVerticalPadding = 22;

  static const String splashImagePath = 'assets/images/png/hoxton_main.png';
  static const String onboardingIcon1 =
      'assets/images/svg/onboarding_intro_icon1.svg';
  static const String onboardingIcon2 =
      'assets/images/svg/onboarding_intro_icon2.svg';
  static const String onboardingIcon3 =
      'assets/images/svg/onboarding_intro_icon3.svg';
  static const String onboardingIcon4 =
      'assets/images/svg/onboarding_intro_icon4.svg';

  static const List<({String label, String iconPath})> servicesList = [
    (label: 'Organize your finances in one place', iconPath: onboardingIcon1),
    (label: 'Track your financial performance', iconPath: onboardingIcon2),
    (label: 'Plan your Financial future', iconPath: onboardingIcon3),
    (label: 'Security you can trust', iconPath: onboardingIcon4),
  ];
}
