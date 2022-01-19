import 'package:collection/collection.dart';

import '../model/model.dart';
import 'extensions.dart';

extension BoardGetterMethods on PuzzleBoard {
  Tile? tileForPos(int x, int y) {
    return tiles.firstWhereOrNull(
        (element) => element.currentPos == BoardPosition(x, y));
  }

  bool isComplete() {
    return tiles
        .where((element) => element.correctPos == element.currentPos)
        .isEmpty;
  }

  bool canMoveTile(Tile tile) {
    final tilePosition = tile.currentPos;

    return tilePosition.isAdjucent(whiteSpace);
  }

  Tile? getLeftMoveableTile() {
    return tiles.firstWhereOrNull(
      (element) => element.currentPos.isImmidiateLeft(whiteSpace),
    );
  }
  Tile? getRightMoveableTile() {
    return tiles.firstWhereOrNull(
      (element) => element.currentPos.isImmidiateRight(whiteSpace),
    );
  }
  Tile? geTopMoveableTile() {
    return tiles.firstWhereOrNull(
      (element) => element.currentPos.isImmidiateTop(whiteSpace),
    );
  }
  Tile? getBottomMoveableTile() {
    return tiles.firstWhereOrNull(
      (element) => element.currentPos.isImmidiateBottom(whiteSpace),
    );
  }
}
