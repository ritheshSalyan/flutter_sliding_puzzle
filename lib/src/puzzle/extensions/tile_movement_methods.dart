import 'package:sliding_puzzle/src/puzzle/model/board.dart';

import '../puzzle.dart';

extension TileMovementMethods<T> on PuzzleBoard {
  PuzzleBoard moveTile(Tile tile) {
    if (!canMoveTile(tile)) return this;

    final temp = whiteSpace;
    final tilePos = tile.currentPos;

    final newTile = tile.copyWith(currentPos: temp);

    tiles.remove(tile);
    tiles.add(newTile);
    return copyWith(tiles: tiles, whiteSpace: tilePos);
  }

  
}
