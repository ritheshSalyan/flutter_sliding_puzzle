import '../puzzle.dart';

extension PositionUtils on BoardPosition {
  bool isAdjucent(BoardPosition position) {
    return isImmidiateLeftOrRight(position) || isImmidiateTopOrBottom(position);
  }

  bool isImmidiateLeftOrRight(BoardPosition position) {
    return (isImmidiateLeft(position) || isImmidiateRight(position));
  }

  bool isImmidiateTopOrBottom(BoardPosition position) {
    return (isImmidiateTop(position) || isImmidiateBottom(position));
  }

  bool isImmidiateLeft(BoardPosition position) {
    return y == position.y + 1 && x == position.x;
  }

  bool isImmidiateRight(BoardPosition position) {
    return y == position.y - 1 && x == position.x;
  }

  bool isImmidiateTop(BoardPosition position) {
    return x == position.x + 1 && y == position.y;
  }

  bool isImmidiateBottom(BoardPosition position) {
    return x == position.x - 1 && y == position.y;
  }
}
