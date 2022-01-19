import 'package:flutter/foundation.dart';

import 'package:sliding_puzzle/src/puzzle/model/tiles.dart';

class PuzzleBoard<T> {
  final List<Tile<T>> tiles;
  final int xDim;
  final int yDim;

  PuzzleBoard({required this.tiles, required this.xDim, required this.yDim});

  PuzzleBoard<T> copyWith({
    List<Tile<T>>? tiles,
    int? xDim,
    int? yDim,
  }) {
    return PuzzleBoard<T>(
      tiles: tiles ?? this.tiles,
      xDim: xDim ?? this.xDim,
      yDim: yDim ?? this.yDim,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PuzzleBoard<T> &&
      listEquals(other.tiles, tiles) &&
      other.xDim == xDim &&
      other.yDim == yDim;
  }

  @override
  int get hashCode => tiles.hashCode ^ xDim.hashCode ^ yDim.hashCode;
}
