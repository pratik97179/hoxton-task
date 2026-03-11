
abstract final class PreBoardingConstants {
  PreBoardingConstants._();
  static const String radioTickedSvg = 'assets/images/svg/radio_ticked.svg';
  static const String radioEmptySvg = 'assets/images/svg/radio_empty.svg';

  static const Duration profileLoadingDuration = Duration(seconds: 2);
  static const Duration afterProfileDoneDelay = Duration(seconds: 1);
  static const Duration headlineFadeDelay = Duration(milliseconds: 250);
  static const Duration dashboardLoadingDuration = Duration(seconds: 1);
  static const Duration afterDashboardDoneDelay = Duration(seconds: 1);
  static const Duration beforeNavigateDelay = Duration(milliseconds: 400);

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

enum PreBoardingStep {
  profileLoading,
  profileDone,
  dashboardLoading,
  dashboardDone,
  complete,
}
