import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../puzzle.dart';

class BoardLogicController extends StateNotifier<PuzzleBoard> {
//   final puzzelBoardProvider = StateProvider<PuzzleBoard>((ref) {
//   return BoardRepository.square(4).board;
// });
  BoardLogicController({int dimension = 3})
      : super(BoardRepository.square(dimension).board);

  static final provider =
      StateNotifierProvider<BoardLogicController, PuzzleBoard>((ref) {
    return BoardLogicController();
  });

List<Tile> get tiles =>state.tiles;

  bool moveTile(Tile tile) {
    final canMove = state.canMoveTile(tile);
    if (canMove) {
      state = state.moveTile(tile);
    }
    return canMove;
  }

  Tile? getMoveLeftTile() {
    return state.getLeftMoveableTile();
  }

  Tile? getMoveRightTile() {
    return state.getRightMoveableTile();
  }

  Tile? getMoveUpTile() {
    return state.geTopMoveableTile();
  }

  Tile? getMoveDownTile() {
    return state.getBottomMoveableTile();
  }

  bool isComplete() {
    return state.isComplete();
  }
}
