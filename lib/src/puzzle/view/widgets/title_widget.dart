import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_provider.dart';

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
        Text(
          ref.watch(BoardUIController.provider).moves.toString(),
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {
                ref.read(BoardUIController.provider).shuffle();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text("Shuffle"),
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
                icon: const Icon(Icons.arrow_left)),
            IconButton(
                onPressed: () {
                  ref.read(BoardUIController.provider).moveRight();
                },
                icon: const Icon(Icons.arrow_right)),
            IconButton(
                onPressed: () {
                  ref.read(BoardUIController.provider).moveUp();
                },
                icon: const Icon(Icons.arrow_upward)),
            IconButton(
                onPressed: () {
                  ref.read(BoardUIController.provider).moveDown();
                },
                icon: const Icon(Icons.arrow_downward)),
          ],
        )
      ],
    );
  }
}
