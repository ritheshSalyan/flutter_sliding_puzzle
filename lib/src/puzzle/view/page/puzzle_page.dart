import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../puzzle.dart';

class PuzzlePage extends ConsumerWidget {
  const PuzzlePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: BoardView(
        board: ref.watch(puzzelBoardProvider),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(PuzzelProvider.provider).shuffle();
        },
      ),
      bottomNavigationBar: Row(
        children: [
          IconButton(
              onPressed: () {
                log(ref
                        .read(puzzelBoardProvider)
                        .getLeftMoveableTile()
                        ?.data
                        .toString() ??
                    "--");
              },
              icon: const Icon(Icons.arrow_left)),
          IconButton(
              onPressed: () {
                log("${ref.read(puzzelBoardProvider).getRightMoveableTile()?.data ?? "--"}");
              },
              icon: const Icon(Icons.arrow_right)),
          IconButton(
              onPressed: () {
                log(ref
                        .read(puzzelBoardProvider)
                        .geTopMoveableTile()
                        ?.data
                        .toString() ??
                    "--");
              },
              icon: const Icon(Icons.arrow_upward)),
          IconButton(
              onPressed: () {
                log(ref
                        .read(puzzelBoardProvider)
                        .getBottomMoveableTile()
                        ?.data
                        .toString() ??
                    "--");
              },
              icon: const Icon(Icons.arrow_downward)),
        ],
      ),
    );
  }
}
