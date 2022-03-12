import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/theme/theme_provider.dart';
import 'package:sliding_puzzle/src/puzzle/provider/state_provider/board_provider.dart';

class TitleWidget extends ConsumerWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        // Text(
        //   "Puzzle Hack",
        //   style: Theme.of(context).textTheme.headline2,
        //   textAlign: TextAlign.center,
        // ),
        InkWell(
          onTap: () {
            ///
            ///TODO: Remove this Shortcut
            ///
            ref.read(BoardUIController.provider).triggerEndAnimation();
          },
          child: Text(
            ref.watch(BoardUIController.provider).moves.toString(),
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {
                ref.read(BoardUIController.provider).shuffle();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: Text(
                ref.read(BoardUIController.provider).boardMode == BoardMode.yetToStart ? 
                 "Start": "Shuffle"),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      ref.watch(ThemeNotifier.provider).foregroundColor)),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  ref.read(BoardUIController.provider).moveLeft();
                },
                icon: const Icon(Icons.swipe_left_alt)),
            IconButton(
                onPressed: () {
                  ref.read(BoardUIController.provider).moveRight();
                },
                icon: const Icon(Icons.swipe_right_alt)),
            IconButton(
                onPressed: () {
                  ref.read(BoardUIController.provider).moveUp();
                },
                icon: const Icon(Icons.swipe_up_alt)),
            IconButton(
                onPressed: () {
                  ref.read(BoardUIController.provider).moveDown();
                },
                icon: const Icon(Icons.swipe_down_alt)),
          ],
        )
      ],
    );
  }
}
