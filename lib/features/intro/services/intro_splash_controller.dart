import 'dart:async';

import 'package:flutter/material.dart';

import '../intro_constants.dart';

class IntroSplashController {
  IntroSplashController({required TickerProvider vsync})
      : _revealController = AnimationController(
          vsync: vsync,
          duration: IntroConstants.textRevealDuration,
        ),
        _fadeOutController = AnimationController(
          vsync: vsync,
          duration: IntroConstants.splashFadeOutDuration,
        ) {
    _revealProgress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _revealController, curve: Curves.easeOut),
    );
    _fadeOutProgress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut),
    );
  }

  final ValueNotifier<int> phase = ValueNotifier<int>(0);
  late final Animation<double> _revealProgress;
  late final Animation<double> _fadeOutProgress;

  Animation<double> get revealProgress => _revealProgress;
  Animation<double> get fadeOutProgress => _fadeOutProgress;

  final AnimationController _revealController;
  final AnimationController _fadeOutController;
  Timer? _phaseTimer;
  Timer? _slideDoneTimer;
  Timer? _revealStartTimer;
  Timer? _introBodyTimer;
  bool _disposed = false;

  void start() {
    _phaseTimer = Timer(IntroConstants.initialWait, () {
      if (_disposed) return;
      phase.value = 1;
      _slideDoneTimer = Timer(IntroConstants.slideDuration, () {
        if (_disposed) return;
        _revealStartTimer = Timer(IntroConstants.pauseAfterSlide, () {
          if (_disposed) return;
          phase.value = 2;
          _revealController.forward();
          _revealController.addStatusListener(_onRevealStatus);
        });
      });
    });
  }

  void _onRevealStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _revealController.removeStatusListener(_onRevealStatus);
    _introBodyTimer = Timer(IntroConstants.pauseAfterReveal, () {
      if (_disposed) return;
      phase.value = 3;
      _fadeOutController.forward();
      _fadeOutController.addStatusListener(_onFadeOutStatus);
    });
  }

  void _onFadeOutStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _fadeOutController.removeStatusListener(_onFadeOutStatus);
    if (_disposed) return;
    phase.value = 4;
  }

  void dispose() {
    _disposed = true;
    _phaseTimer?.cancel();
    _slideDoneTimer?.cancel();
    _revealStartTimer?.cancel();
    _introBodyTimer?.cancel();
    _revealController.removeStatusListener(_onRevealStatus);
    _fadeOutController.removeStatusListener(_onFadeOutStatus);
    _revealController.dispose();
    _fadeOutController.dispose();
  }
}
