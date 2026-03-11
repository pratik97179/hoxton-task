import 'package:flutter/foundation.dart';

import 'package:hoxton_task/features/intro/intro_constants.dart';

/// Header animation stages for intro content. Public so UI can use the same enum.
enum IntroHeaderStage {
  initial,
  takeControlVisible,
  rightTextVisible,
  movedToTop,
}

/// Owns intro content animation state and runs the delay sequence. No BuildContext.
class IntroContentController {
  final ValueNotifier<IntroHeaderStage> headerStage =
      ValueNotifier(IntroHeaderStage.initial);
  final ValueNotifier<int> visibleItemCount = ValueNotifier(0);
  final ValueNotifier<bool> showContinue = ValueNotifier(false);

  bool _disposed = false;
  static final int _featureCount = IntroConstants.servicesList.length;

  /// Starts the animation sequence. Call once when content is shown. Safe to call from initState.
  Future<void> startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_disposed) return;
    headerStage.value = IntroHeaderStage.takeControlVisible;

    await Future.delayed(const Duration(milliseconds: 500));
    if (_disposed) return;
    headerStage.value = IntroHeaderStage.rightTextVisible;

    await Future.delayed(const Duration(milliseconds: 200));
    if (_disposed) return;
    headerStage.value = IntroHeaderStage.movedToTop;

    for (int i = 0; i < _featureCount; i++) {
      await Future.delayed(const Duration(milliseconds: 450));
      if (_disposed) return;
      visibleItemCount.value = i + 1;
    }

    await Future.delayed(const Duration(milliseconds: 100));
    if (_disposed) return;
    showContinue.value = true;
  }

  void dispose() {
    _disposed = true;
    headerStage.dispose();
    visibleItemCount.dispose();
    showContinue.dispose();
  }
}
