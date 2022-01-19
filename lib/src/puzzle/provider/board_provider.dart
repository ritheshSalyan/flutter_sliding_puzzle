import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/model/board.dart';
import 'package:sliding_puzzle/src/puzzle/model/model.dart';
import 'package:sliding_puzzle/src/puzzle/repository/board_repository.dart';

import '../puzzle.dart';
import 'helper/state_tracker.dart';

final puzzelBoardProvider = StateProvider<PuzzleBoard>((ref) {
  return BoardRepository.square(4).board;
});

class PuzzelProvider extends ChangeNotifier with StackTracker<PuzzleBoard> {
  final Ref _ref;
  PuzzelProvider(
    this._ref,
  );

  static final provider = ChangeNotifierProvider<PuzzelProvider>((ref) {
    return PuzzelProvider(ref);
  });

  void shuffle() {
    _ref.read(puzzelBoardProvider.notifier).state =
        BoardRepository.square(4).board;
  }

  void moveTile(Tile tile) {
    saveState(_ref.read(puzzelBoardProvider));
    var moveTile = _ref.read(puzzelBoardProvider).moveTile(tile);
    _ref.read(puzzelBoardProvider.notifier).state = moveTile;
  }
}
