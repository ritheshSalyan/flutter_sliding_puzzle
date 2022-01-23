import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_controller.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/input/keyboard_listner.dart';

import '../../puzzle.dart';

class PuzzlePage extends ConsumerWidget {
  const PuzzlePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomKeyboardActionListner(
          controller: ref.watch(BoardAnimationController.provider),
          child: const BoardView()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(BoardAnimationController.provider).shuffle();
        },
      ),
      bottomNavigationBar: Row(
        children: [
          IconButton(
              onPressed: () {
                log(ref
                    .read(BoardLogicController.provider.notifier)
                    .moveLeft()
                    .toString());
              },
              icon: const Icon(Icons.arrow_left)),
          IconButton(
              onPressed: () {
                log("${ref.read(BoardLogicController.provider.notifier).moveRight()}");
              },
              icon: const Icon(Icons.arrow_right)),
          IconButton(
              onPressed: () {
                log(ref
                    .read(BoardLogicController.provider.notifier)
                    .moveUp()
                    .toString());
              },
              icon: const Icon(Icons.arrow_upward)),
          IconButton(
              onPressed: () {
                log(ref
                    .read(BoardLogicController.provider.notifier)
                    .moveDown()
                    .toString());
              },
              icon: const Icon(Icons.arrow_downward)),
        ],
      ),
    );
  }
}
