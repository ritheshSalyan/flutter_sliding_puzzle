import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../puzzle.dart';
import 'package:sliding_puzzle/src/puzzle/model/board.dart';
import 'package:sliding_puzzle/src/puzzle/model/model.dart';
import 'package:sliding_puzzle/src/puzzle/repository/board_repository.dart';

import 'helper/state_tracker.dart';

final puzzelBoardProvider = StateProvider<PuzzleBoard>((ref) {
  return BoardRepository.square(4).board;
});

class PuzzelProvider extends ChangeNotifier with StateTracker<PuzzleBoard> {
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
    var moveTile = _ref.read(puzzelBoardProvider).moveTile(tile);
    saveState(moveTile);
    _ref.read(puzzelBoardProvider.notifier).state = moveTile;
  }

  
}
