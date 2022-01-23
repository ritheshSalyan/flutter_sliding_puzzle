import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../puzzle.dart';

class BoardLogicController extends StateNotifier<PuzzleBoard> {
//   final puzzelBoardProvider = StateProvider<PuzzleBoard>((ref) {
//   return BoardRepository.square(4).board;
// });
  BoardLogicController({int dimension = 4})
      : super(BoardRepository.square(dimension).board);

  static final provider =
      StateNotifierProvider<BoardLogicController, PuzzleBoard>((ref) {
    return BoardLogicController();
  });

  bool moveTile(Tile tile) {
    final canMove = state.canMoveTile(tile);
    if (canMove) {
      state = state.moveTile(tile);
    }
    return canMove;
  }

  bool moveLeft() {
    final tile = state.getLeftMoveableTile();
    if (tile != null) state = state.moveTile(tile);
    return tile != null;
  }

  bool moveRight() {
    final tile = state.getRightMoveableTile();
    if (tile != null) state = state.moveTile(tile);
    return tile != null;
  }

  bool moveUp() {
    final tile = state.geTopMoveableTile();
    if (tile != null) state = state.moveTile(tile);
    return tile != null;
  }

  bool moveDown() {
    final tile = state.getBottomMoveableTile();
    if (tile != null) state = state.moveTile(tile);
    return tile != null;
  }
}


