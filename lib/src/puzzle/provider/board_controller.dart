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

  Tile? moveLeft() {
    return state.getLeftMoveableTile();
    // if (tile != null) state = state.moveTile(tile);
    // return tile != null;
  }

  Tile? moveRight() {
    return state.getRightMoveableTile();
    // if (tile != null) state = state.moveTile(tile);
    // return tile != null;
  }

  Tile? moveUp() {
    return state.geTopMoveableTile();
    // if (tile != null) state = state.moveTile(tile);
    // return tile != null;
  }

  Tile? moveDown() {
    return state.getBottomMoveableTile();
    // if (tile != null) state = state.moveTile(tile);
    // return tile != null;
  }
}
