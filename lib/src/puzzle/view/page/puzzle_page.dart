import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_provider.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/board_builder.dart';

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
    );
  }
}
