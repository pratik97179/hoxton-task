import 'package:flutter/foundation.dart';

import 'package:hoxton_task/features/intro/pre_boarding_constants.dart';

class PreBoardingController {
  PreBoardingController({
    required VoidCallback onComplete,
    VoidCallback? advanceSlider,
  })  : _onComplete = onComplete,
        _advanceSlider = advanceSlider;

  final VoidCallback _onComplete;
  final VoidCallback? _advanceSlider;

  final ValueNotifier<PreBoardingStep> step =
      ValueNotifier(PreBoardingStep.profileLoading);

  bool _disposed = false;
  bool _started = false;

  Future<void> start() async {
    if (_started) return;
    _started = true;

    await Future.delayed(PreBoardingConstants.profileLoadingDuration);
    if (_disposed) return;
    step.value = PreBoardingStep.profileDone;
    _advanceSlider?.call();

    await Future.delayed(PreBoardingConstants.afterProfileDoneDelay);
    if (_disposed) return;

    await Future.delayed(PreBoardingConstants.headlineFadeDelay);
    if (_disposed) return;
    step.value = PreBoardingStep.dashboardLoading;

    await Future.delayed(PreBoardingConstants.dashboardLoadingDuration);
    if (_disposed) return;
    step.value = PreBoardingStep.dashboardDone;
    _advanceSlider?.call();

    await Future.delayed(PreBoardingConstants.afterDashboardDoneDelay);
    if (_disposed) return;
    step.value = PreBoardingStep.complete;

    await Future.delayed(PreBoardingConstants.beforeNavigateDelay);
    if (_disposed) return;
    _onComplete();
  }

  void dispose() {
    _disposed = true;
    step.dispose();
  }
}
