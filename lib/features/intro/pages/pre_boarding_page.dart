import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_scaffold.dart';
import 'package:hoxton_task/features/intro/controllers/pre_boarding_controller.dart';
import 'package:hoxton_task/features/intro/pre_boarding_constants.dart';
import 'package:hoxton_task/features/intro/widgets/pre_boarding_content.dart';
import 'package:hoxton_task/features/intro/widgets/phrase_carousel.dart';

class PreBoardingPage extends StatefulWidget {
  const PreBoardingPage({super.key, this.userName, required this.onComplete});

  final String? userName;
  final VoidCallback onComplete;

  @override
  State<PreBoardingPage> createState() => _PreBoardingPageState();
}

class _PreBoardingPageState extends State<PreBoardingPage> {
  late final PhraseCarouselController _phraseController;
  late final PreBoardingController _preBoardingController;

  @override
  void initState() {
    super.initState();
    final userName = widget.userName ?? '';
    _phraseController = PhraseCarouselController(
      phrases: [
        PreBoardingConstants.sliderText1(userName),
        PreBoardingConstants.sliderText2,
        PreBoardingConstants.sliderText3,
      ],
    );
    _preBoardingController = PreBoardingController(
      onComplete: widget.onComplete,
      advanceSlider: _phraseController.advance,
    );
    _preBoardingController.start();
  }

  @override
  void dispose() {
    _preBoardingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWithBgDecor(
      body: ValueListenableBuilder<PreBoardingStep>(
        valueListenable: _preBoardingController.step,
        builder: (context, step, _) {
          return Center(
            child: PreBoardingContent(
              step: step,
              phraseController: _phraseController,
            ),
          );
        },
      ),
    );
  }
}
