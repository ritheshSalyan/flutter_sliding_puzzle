import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_controller.dart';

import '../../puzzle.dart';

class BoardView extends ConsumerWidget {
  const BoardView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    final board = ref.watch(BoardLogicController.provider);
    return Center(
      child: SizedBox(
        width: 500,
        height: 500,
        child: AspectRatio(
          aspectRatio: 1,
          child: LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            const space = 30;

            final tileWidth = (width / board.xDim);
            // -(space * (board.xDim - 1));
            final tileHeight = (height / board.yDim);
            // -(space * (board.yDim - 1));

            // return GridView.builder(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: board.xDim),
            //   itemCount: board.tiles.length + 1,
            //   itemBuilder:
            return Stack(
              children: List<Widget>.from(board.tiles.map((tile) {
                return TileBuilder(
                  tile: tile,
                  tileWidth: tileWidth,
                  tileHeight: tileHeight,
                );
              })),
            );
            // );
          }),
        ),
      ),
    );
  }
}
