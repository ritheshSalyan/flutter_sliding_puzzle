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
                      transform: Matrix4.identity()
                        ..translate(-offset.dx * 0.5, -offset.dy * 0.5, 0),
                      child: Image.asset(
                        "assets/images/lava_a.jpg",
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

              // return DepthBuilder(
              //   builder: (context, offset) {

                  ////TODO: Optimize this.
                  return Stack(
                    children: List<Widget>.from((ref
                            .read(BoardLogicController.provider)
                            .tiles
                            ..sort((a,b)=>a.currentPos.compareTo(b.currentPos))
                          // ..sort((a, b) => b.currentPos.y.compareTo(a.currentPos.y) * offset.dx.sign.toInt() +b.currentPos.x.compareTo(a.currentPos.x) * offset.dy.sign.toInt()
                          // )
                          )
                        .map((tile) {
                      return TileBuilder(
                        key: ValueKey(tile.correctPos),
                        tile: tile,
                        tileWidth: tileWidth,
                        tileHeight: tileHeight,
                      );
                    })),
                  );
              //   }
              // );
              // );
            }),
          ],
        ),
      ),
    );
  }
}
