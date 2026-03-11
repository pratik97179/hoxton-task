import 'package:flutter/material.dart';

enum PhraseCarouselPhase {
  initial,
  exiting,
  entering,
}

/// View state for [PhraseCarousel] so only the Stack rebuilds.
class PhraseCarouselViewState {
  const PhraseCarouselViewState({
    required this.phase,
    required this.displayedIndex,
    this.exitingIndex,
  });

  final PhraseCarouselPhase phase;
  final int displayedIndex;
  final int? exitingIndex;
}

class PhraseCarouselController extends ChangeNotifier {
  PhraseCarouselController({required List<String> phrases}) : _phrases = phrases;

  final List<String> _phrases;
  List<String> get phrases => _phrases;

  int _currentPhraseIndex = 0;
  int get currentPhraseIndex => _currentPhraseIndex;

  void advance() {
    if (_currentPhraseIndex >= _phrases.length - 1) return;
    _currentPhraseIndex++;
    notifyListeners();
  }
}

class PhraseCarousel extends StatefulWidget {
  const PhraseCarousel({
    super.key,
    required this.controller,
    this.style,
    this.transitionDuration = const Duration(milliseconds: 1000),
  });

  final PhraseCarouselController controller;
  final TextStyle? style;
  final Duration transitionDuration;

  @override
  State<PhraseCarousel> createState() => _PhraseCarouselState();
}

class _PhraseCarouselState extends State<PhraseCarousel>
    with TickerProviderStateMixin {
  late AnimationController _enterController;
  late AnimationController _exitController;
  late Animation<Offset> _enterAnimation;
  late Animation<Offset> _exitAnimation;

  final ValueNotifier<PhraseCarouselViewState> _viewState =
      ValueNotifier(const PhraseCarouselViewState(
    phase: PhraseCarouselPhase.initial,
    displayedIndex: 0,
    exitingIndex: null,
  ));

  static const Duration _gapBetweenExitAndEnter = Duration(milliseconds: 50);

  static const double _lineHeight = 22;

  @override
  void initState() {
    super.initState();
    final initialIndex = widget.controller.currentPhraseIndex;
    _viewState.value = PhraseCarouselViewState(
      phase: PhraseCarouselPhase.initial,
      displayedIndex: initialIndex,
      exitingIndex: null,
    );
    _enterController = AnimationController(
      vsync: this,
      duration: widget.transitionDuration,
    );
    _exitController = AnimationController(
      vsync: this,
      duration: widget.transitionDuration,
    );
    _enterAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enterController, curve: Curves.bounceIn));
    _exitAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _exitController,
      curve: Curves.easeInOutBack,
    ));
    widget.controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    final nextIndex = widget.controller.currentPhraseIndex;
    final current = _viewState.value;
    if (nextIndex <= current.displayedIndex) return;
    if (current.phase != PhraseCarouselPhase.initial) return;

    _viewState.value = PhraseCarouselViewState(
      phase: PhraseCarouselPhase.exiting,
      displayedIndex: current.displayedIndex,
      exitingIndex: current.displayedIndex,
    );
    _exitController.forward(from: 0);
    _exitController.addStatusListener(_onExitStatus);
  }

  void _onExitStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _exitController.removeStatusListener(_onExitStatus);
    if (!mounted) return;
    final newIndex = widget.controller.currentPhraseIndex;
    _viewState.value = PhraseCarouselViewState(
      phase: PhraseCarouselPhase.entering,
      displayedIndex: newIndex,
      exitingIndex: null,
    );
    Future.delayed(_gapBetweenExitAndEnter, () {
      if (!mounted) return;
      _enterController.forward(from: 0);
      _enterController.addStatusListener(_onEnterStatus);
    });
  }

  void _onEnterStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _enterController.removeStatusListener(_onEnterStatus);
    if (!mounted) return;
    _viewState.value = PhraseCarouselViewState(
      phase: PhraseCarouselPhase.initial,
      displayedIndex: _viewState.value.displayedIndex,
      exitingIndex: null,
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _exitController.removeStatusListener(_onExitStatus);
    _enterController.removeStatusListener(_onEnterStatus);
    _viewState.dispose();
    _enterController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.style ??
        Theme.of(context).textTheme.bodyLarge ??
        const TextStyle();
    final phrases = widget.controller.phrases;
    if (phrases.isEmpty) return const SizedBox(height: _lineHeight);

    return ClipRect(
      child: SizedBox(
        height: _lineHeight,
        child: ValueListenableBuilder<PhraseCarouselViewState>(
          valueListenable: _viewState,
          builder: (context, state, _) {
            return Stack(
              alignment: Alignment.center,
              children: [
                if (state.exitingIndex != null &&
                    state.exitingIndex! < phrases.length)
                  SlideTransition(
                    position: _exitAnimation,
                    child: Text(
                      phrases[state.exitingIndex!],
                      style: textStyle,
                    ),
                  ),
                if (state.phase == PhraseCarouselPhase.initial &&
                    state.exitingIndex == null)
                  Text(phrases[state.displayedIndex], style: textStyle)
                else if (state.phase == PhraseCarouselPhase.entering)
                  SlideTransition(
                    position: _enterAnimation,
                    child: Text(
                      phrases[state.displayedIndex],
                      style: textStyle,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
