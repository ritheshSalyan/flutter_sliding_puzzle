import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_controller.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/depth_builder.dart';

import '../../puzzle.dart';


class BoardView extends HookConsumerWidget {
  const BoardView({
    Key? key,
  }) : super(key: key);

  // Offset _offset = Offset.zero;
  @override
  Widget build(BuildContext context, ref) {
    final board = ref.watch(BoardLogicController.provider);

    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            DepthBuilder(
                builder: (context, offset) => Transform(
                      transform: Matrix4.identity()..translate(-20.0, -20.0),
                      child: Image.asset(
                        "assets/images/lava.jpg",
                        fit: BoxFit.fill,
                        width: double.maxFinite,
                        height: double.maxFinite,
                      ),
                    )),
            LayoutBuilder(builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;

              const space = 30;

              final tileWidth = (width / board.xDim);
              final tileHeight = (height / board.yDim);
              var list = List<TileBuilder>.from(
                  (ref.read(BoardLogicController.provider).tiles
                        ..sort((a, b) => a.currentPos.compareTo(b.currentPos)))
                      .map((tile) {
                return TileBuilder(
                  // key: ValueKey(tile.correctPos),
                  tile: tile,
                  tileWidth: tileWidth,
                  tileHeight: tileHeight,
                );
              }));
              return DepthBuilder(builder: (context, offset) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: list
                    ..sort((a, b) =>
                        b.tile.currentPos.y.compareTo(a.tile.currentPos.y) *
                            offset.dx.sign.toInt() +
                        b.tile.currentPos.x.compareTo(a.tile.currentPos.x) *
                            offset.dy.sign.toInt()),
                );
              });
              // );
            }),
          ],
        ),
      ),
    );
  }
}
