import '../model/model.dart';
import 'random_position_repository.dart';

class BoardRepository<T> {
  final PuzzleBoard<T> board;

  BoardRepository(this.board);

  static BoardRepository<int> square(int dim) {
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
    tiles.removeLast();

    return BoardRepository<int>(
        PuzzleBoard<int>(tiles: tiles, xDim: dim, yDim: dim));
  }
}
