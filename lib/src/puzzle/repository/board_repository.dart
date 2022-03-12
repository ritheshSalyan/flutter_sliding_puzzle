import '../model/model.dart';
import 'random_position_repository.dart';

class BoardRepository<T> {
  final PuzzleBoard<T> board;

  BoardRepository(this.board);

  static PuzzleBoard<int> square(int dim) {
    final positionGenerator = RandomPositionRepository(maxX: dim, maxY: dim);

    final List<Tile<int>> tiles = [];
    for (var i = 0; i < dim; i++) {
      for (var j = 0; j < dim; j++) {
        tiles.add(
          Tile(
            correctPos: BoardPosition(i, j),
            currentPos: positionGenerator.generateRandomPosition(),
            data: (i * dim) + j + 1,
          ),
        );
      }
    }

    ///
    /// For WhiteSpace. Since [tiles] are sorted in order
    ///
    final space = tiles.removeLast();

    return PuzzleBoard<int>(
      tiles: tiles,
      xDim: dim,
      yDim: dim,
      whiteSpace: space.currentPos,
    );
  }

  static PuzzleBoard<int> correctSquare(int dim) {
    final List<Tile<int>> tiles = [];
    for (var i = 0; i < dim; i++) {
      for (var j = 0; j < dim; j++) {
        tiles.add(
          Tile(
            correctPos: BoardPosition(i, j),
            currentPos: BoardPosition(i, j),
            data: (i * dim) + j + 1,
          ),
        );
      }
    }

    ///
    /// For WhiteSpace. Since [tiles] are sorted in order
    ///
    final space = tiles.removeLast();

    return PuzzleBoard<int>(
      tiles: tiles,
      xDim: dim,
      yDim: dim,
      whiteSpace: space.currentPos,
    );
  }
}
