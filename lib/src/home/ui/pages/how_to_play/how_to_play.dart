import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/ui.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:universal_platform/universal_platform.dart';

import 'sections/ar_instruction.dart';
import 'sections/controls.dart';
import 'sections/correct_order.dart';
import 'sections/movement_instruction.dart';

class HowToPlay extends ConsumerStatefulWidget {
  const HowToPlay({Key? key}) : super(key: key);

  @override
  ConsumerState<HowToPlay> createState() => _HowToPlayState();
}

class _HowToPlayState extends ConsumerState<HowToPlay> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final sections = [
      const MovementInstructions(),
      const OrderOfBoard(),
      const Controls(),
      if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS)
        const ARInstruction()
    ];
    return DeferredPointerHandler(
      child: CommonScaffold(
        title: "How to Play",
        // backgroundColor: Colors.white,
        // appBar: AppBar(),
        large: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sections.length,
                  itemBuilder: (context, index) => sections[index],
                ),
              ),
              AnimatedBuilder(
                animation: pageController,
                builder: (BuildContext context, Widget? child) {
                  return Row(
                    children: [
                      AbsorbPointer(
                        absorbing: (pageController.page?.toInt() == 0),
                        child: Opacity(
                          opacity: (pageController.page?.toInt() != 0) ? 1 : 0,
                          child: ElevatedButton(
                            onPressed: () {
                              pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInCubic);
                            },
                            child: const Text("Previous"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(ref
                                    .watch(ThemeNotifier.provider)
                                    .foregroundColor),
                                elevation: MaterialStateProperty.all(0.0),
                                shape: MaterialStateProperty.all(
                                    const BeveledRectangleBorder())),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: sections.length,
                            effect: WormEffect(
                                activeDotColor: ref
                                    .watch(ThemeNotifier.provider)
                                    .foregroundColor),
                            onDotClicked: (index) {
                              pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInCubic);
                            },
                          ),
                        ),
                      ),
                      AbsorbPointer(
                        absorbing: (pageController.page?.toInt() ==
                            sections.length - 1),
                        child: Opacity(
                          opacity: (pageController.page?.toInt() !=
                                  sections.length - 1)
                              ? 1
                              : 0,
                          child: ElevatedButton(
                            onPressed: () {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInCubic,
                              );
                            },
                            child: const Text("Next"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(ref
                                    .watch(ThemeNotifier.provider)
                                    .foregroundColor),
                                elevation: MaterialStateProperty.all(0.0),
                                shape: MaterialStateProperty.all(
                                    const BeveledRectangleBorder())),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
