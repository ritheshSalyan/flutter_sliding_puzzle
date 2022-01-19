import 'package:flutter/foundation.dart';

import 'model.dart';

class PuzzleBoard<T> {
  final List<Tile<T>> tiles;
  final int xDim;
  final int yDim;
  final BoardPosition whiteSpace;
  PuzzleBoard({
    required this.tiles,
    required this.xDim,
    required this.yDim,
    required this.whiteSpace,
  });

  PuzzleBoard<T> copyWith({
    List<Tile<T>>? tiles,
    int? xDim,
    int? yDim,
    BoardPosition? whiteSpace,
  }) {
    return PuzzleBoard<T>(
      tiles: tiles ?? this.tiles,
      xDim: xDim ?? this.xDim,
      yDim: yDim ?? this.yDim,
      whiteSpace: whiteSpace ?? this.whiteSpace,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PuzzleBoard<T> &&
      listEquals(other.tiles, tiles) &&
      other.xDim == xDim &&
      other.yDim == yDim &&
      other.whiteSpace == whiteSpace;
  }

  @override
  int get hashCode {
    return tiles.hashCode ^
      xDim.hashCode ^
      yDim.hashCode ^
      whiteSpace.hashCode;
  }
}
