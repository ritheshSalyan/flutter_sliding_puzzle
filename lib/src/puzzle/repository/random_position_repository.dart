import 'dart:math';

import 'package:sliding_puzzle/src/puzzle/model/position.dart';

class RandomPositionRepository {
  final int maxX;
  final int maxY;
  RandomPositionRepository({
    required this.maxX,
    required this.maxY,
  }) {
    _initialize();
  }

  final List<BoardPosition> possiblePositions = [];
  void _initialize() {
    for (var i = 0; i < maxX; i++) {
      for (var j = 0; j < maxY; j++) {
        possiblePositions.add(BoardPosition(i, j));
      }
    }

    possiblePositions.shuffle();
  }

  BoardPosition generateRandomPosition() {
    if (possiblePositions.length == 1) return possiblePositions.removeLast();
    int pos = Random().nextInt(possiblePositions.length);
    return possiblePositions.removeAt(pos);
  }
}
