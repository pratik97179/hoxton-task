import 'package:flutter/foundation.dart';

import 'package:hoxton_task/features/intro/intro_constants.dart';

enum IntroHeaderStage {
  initial,
  takeControlVisible,
  rightTextVisible,
  movedToTop,
}

typedef _Step = (Duration delay, void Function() action);

class IntroContentController {
  final ValueNotifier<IntroHeaderStage> headerStage =
      ValueNotifier(IntroHeaderStage.initial);
  final ValueNotifier<int> visibleItemCount = ValueNotifier(0);
  final ValueNotifier<bool> showContinue = ValueNotifier(false);

  bool _disposed = false;

  Future<void> startAnimations() async {
    final steps = <_Step>[
      (IntroConstants.introInitialDelay, () => headerStage.value = IntroHeaderStage.takeControlVisible),
      (IntroConstants.introAfterTitleDelay, () => headerStage.value = IntroHeaderStage.rightTextVisible),
      (IntroConstants.introAfterSubtitleDelay, () => headerStage.value = IntroHeaderStage.movedToTop),
      ...List.generate(
        IntroConstants.servicesList.length,
        (i) => (IntroConstants.introFeatureRevealDelay, () => visibleItemCount.value = i + 1),
      ),
      (IntroConstants.introBeforeContinueDelay, () => showContinue.value = true),
    ];

    for (final (delay, action) in steps) {
      await Future.delayed(delay);
      if (_disposed) return;
      action();
    }
  }

  void dispose() {
    _disposed = true;
    headerStage.dispose();
    visibleItemCount.dispose();
    showContinue.dispose();
  }
}
