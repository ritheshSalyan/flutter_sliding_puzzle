import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/puzzle/model/board.dart';
import 'package:sliding_puzzle/src/puzzle/model/model.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/tile_builder.dart';

class BoardView extends StatelessWidget {
  final PuzzleBoard board;
  const BoardView({Key? key, required this.board}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: board.xDim),
        itemCount: board.tiles.length + 1,
        itemBuilder: (context, index) {
          final tile = board.tiles.firstWhereOrNull((element) =>
              element.currentPos ==
              BoardPosition(index ~/ board.xDim, index % board.xDim));
          if (tile == null) return Container();
          return TileBuilder(tile: tile);
        },
      ),
    );
  }
}
