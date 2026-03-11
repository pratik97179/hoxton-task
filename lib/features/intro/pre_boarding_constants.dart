/// Pre-boarding screen: step enum, copy, durations, and asset paths.
abstract final class PreBoardingConstants {
  PreBoardingConstants._();

  // Assets
  static const String radioTickedSvg = 'assets/images/svg/radio_ticked.svg';
  static const String radioEmptySvg = 'assets/images/svg/radio_empty.svg';

  // Sequence durations
  static const Duration profileLoadingDuration = Duration(seconds: 2);
  static const Duration afterProfileDoneDelay = Duration(seconds: 1);
  static const Duration headlineFadeDelay = Duration(milliseconds: 300);
  static const Duration dashboardLoadingDuration = Duration(seconds: 2);
  static const Duration afterDashboardDoneDelay = Duration(seconds: 1);
  static const Duration beforeNavigateDelay = Duration(milliseconds: 400);

  // Copy
  static const String headlineBuilding = 'We are building your ';
  static const String headlineTypingWord = 'dashboard';
  static const String headlineReady = 'Your personalized dashboard is ready!';
  static const String step1LabelLoading = 'Setting Profile';
  static const String step1LabelDone = 'Profile Complete';
  static const String step2Label = 'Setting Up Your Dashboard';
  static String sliderText1(String userName) =>
      "It will only take a moment, $userName.";
  static const String sliderText2 = "You're nearly there...";
  static const String sliderText3 = 'All set!';
}

/// Semantic steps for the pre-boarding flow. Single source of truth for UI state.
enum PreBoardingStep {
  /// First loader visible; "Setting up profile".
  profileLoading,

  /// First tick shown; "Profile Completed"; slider advances.
  profileDone,

  /// Headline fade applied; second loader visible.
  dashboardLoading,

  /// Second tick shown; slider advances.
  dashboardDone,

  /// Final headline; then navigate to home.
  complete,
}
