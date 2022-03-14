import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/puzzle/provider/difficuly_level.dart';

// class DifficultySelection extends ConsumerWidget {
//   const DifficultySelection({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//   }
// }

class DifficultySelection extends ConsumerStatefulWidget {
  const DifficultySelection({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DifficultySelectionState();
}

class _DifficultySelectionState extends ConsumerState<DifficultySelection> {
  @override
  Widget build(BuildContext context) {
    var selectedLevel = ref.watch(DifficultyNotifier.provider).index;

    return CommonScaffold(
      small: (context, constraints) {
        var pageController = PageController(initialPage: 0);
        Future.delayed(const Duration(milliseconds: 50), () {
          if (pageController.hasClients) {
            pageController.jumpToPage(
              selectedLevel,
            );
          }
        });
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            children: [
              Expanded(
                child: CubePageView(
                  controller: pageController,
                  // startPage: index2,
                  children: [
                    for (var e in DifficulyLevel.values) ...{
                      DifficultyLevelWidget(level: e)
                    }
                  ],
                ),
              ),
              PlayButton(
                pageController: pageController,
              )
            ],
          ),
        );
      },
      medium: (context, constraints) {
        var pageController = PageController(initialPage: 0);
        Future.delayed(const Duration(milliseconds: 50), () {
          if (pageController.hasClients) {
            pageController.jumpToPage(
              selectedLevel,
            );
          }
        });
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    constraints:
                        const BoxConstraints(maxWidth: 500, minWidth: 500),
                    child: CubePageView(
                      controller: pageController,
                      // startPage: index2,
                      children: [
                        for (var e in DifficulyLevel.values) ...{
                          DifficultyLevelWidget(level: e)
                        }
                      ],
                    ),
                  ),
                ),
              ),
              PlayButton(
                pageController: pageController,
              )
            ],
          ),
        );
      },
      large: (context, constraints) {
        var pageController = PageController(initialPage: 0);
        Future.delayed(const Duration(milliseconds: 50), () {
          if (pageController.hasClients) {
            pageController.jumpToPage(
              selectedLevel,
            );
          }
        });
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    constraints:
                        const BoxConstraints(maxWidth: 500, minWidth: 500),
                    child: CubePageView(
                      controller: pageController,
                      // startPage: index2,
                      children: [
                        for (var e in DifficulyLevel.values) ...{
                          DifficultyLevelWidget(level: e)
                        }
                      ],
                    ),
                  ),
                ),
              ),
              PlayButton(
                pageController: pageController,
              )
            ],
          ),
        );
      },
    );
  }
}

class PlayButton extends ConsumerWidget {
  const PlayButton({
    Key? key,
    required this.pageController,
  }) : super(key: key);
  final PageController pageController;

  @override
  Widget build(BuildContext context, ref) {
    return AnimatedBuilder(
        animation: pageController,
        builder: (context, snapshot) {
          int level = pageController.positions.isNotEmpty
              ? pageController.page?.toInt() ?? 0
              : 0;
          return Column(
            children: [
              Row(
                children: [
                  Opacity(
                      opacity: level > 0 ? 1 : 0,
                      child: IconButton(
                          onPressed: () {
                            if (level > 0) {
                              pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.linear);
                            }
                          },
                          icon: const Icon(Icons.swipe_left))),
                  Expanded(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(DifficultyNotifier.provider.notifier)
                              .changeDifficulty(DifficulyLevel.values[level]);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Play"),
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
                  Opacity(
                    opacity: level < DifficulyLevel.values.length - 1 ? 1 : 0,
                    child: IconButton(
                      onPressed: () {
                        if (level < DifficulyLevel.values.length - 1) {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear);
                        }
                      },
                      icon: const Icon(
                        Icons.swipe_right,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              )
            ],
          );
        });
  }
}

class DifficultyLevelWidget extends ConsumerWidget {
  const DifficultyLevelWidget({Key? key, required this.level})
      : super(key: key);

  final DifficulyLevel level;

  static final Map<DifficulyLevel, Color> _backgroundColor = {
    DifficulyLevel.easy: Colors.green.withOpacity(0.5),
    DifficulyLevel.medium: Colors.orange.withOpacity(0.5),
    DifficulyLevel.hard: Colors.red.withOpacity(0.5),
  };
  static final Map<DifficulyLevel, String> _description = {
    DifficulyLevel.easy: "You will have Numbers as hint",
    DifficulyLevel.medium: "Piller will increase in size on correct place",
    DifficulyLevel.hard: "No Clue is provided. Adjust on your own",
  };
  static final Map<DifficulyLevel, String> _title = {
    DifficulyLevel.easy: "Easy",
    DifficulyLevel.medium: "Medium",
    DifficulyLevel.hard: "Hard",
  };
  @override
  Widget build(BuildContext context, ref) {
    return Container(
      color: _backgroundColor[level],
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      level.index + 1,
                      (index) => const Icon(
                            Icons.star,
                            size: 50,
                          )),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  _title[level]!,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Text(_description[level]!),
              const Spacer(
                flex: 3,
              ),
            ],
          )),
        ],
      )),
    );
  }
}
