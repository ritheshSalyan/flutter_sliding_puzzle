import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../puzzle.dart';

class BoardLogicController extends StateNotifier<PuzzleBoard> {
//   final puzzelBoardProvider = StateProvider<PuzzleBoard>((ref) {
//   return BoardRepository.square(4).board;
// });
  final int dimension;
  BoardLogicController({this.dimension = 3})
      : super(BoardRepository.correctSquare(3));

  static final provider =
      StateNotifierProvider<BoardLogicController, PuzzleBoard>((ref) {
    return BoardLogicController();
  });

  List<Tile> get tiles => state.tiles;

  int get xDim => state.xDim;
  int get yDim => state.yDim;

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

  void generateCorrectBoard() {
    state = BoardRepository.correctSquare(dimension);
  }

  void generateRandomBoard() {
    state = BoardRepository.square(dimension);
  }
}
