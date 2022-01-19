import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../puzzle.dart';

class BoardView extends ConsumerWidget {
  final PuzzleBoard board;
  const BoardView({Key? key, required this.board}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: board.xDim),
        itemCount: board.tiles.length + 1,
        itemBuilder: (context, index) {
          final tile = board.tileForPos(_getX(index), _getY(index));
          if (tile == null) return Container();
          return InkWell(
              onTap: () {
                ref.read(PuzzelProvider.provider).moveTile(tile);
                // log("Can Move ${tile.data} ${board.canMoveTile(tile)}");
              },
              child: TileBuilder(tile: tile));
        },
      ),
    );
  }

  int _getX(int index) => index ~/ board.xDim;
  int _getY(int index) => index % board.xDim;
}
