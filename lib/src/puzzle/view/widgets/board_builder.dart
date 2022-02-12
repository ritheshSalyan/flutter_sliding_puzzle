import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/cube.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/depth_builder.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_controller.dart';

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
        child: LayoutBuilder(builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          final tileWidth = (width / board.xDim);
          final tileHeight = (height / board.yDim);
          var list = List<TileBuilder>.from(
              (ref.read(BoardLogicController.provider).tiles
                    ..sort((a, b) => a.currentPos.compareTo(b.currentPos)))
                  .map((tile) {
            return TileBuilder(
              tile: tile,
              tileWidth: tileWidth,
              tileHeight: tileHeight,
            );
          }));
          var customCube = CustomCube(
            width: width,
            height: height,
            depth: 100,
            depthOffset: 100,
            faceWidgets: CubeFaceWidgets.all(Image.asset(
              "assets/images/lava_a.jpg",
              repeat: ImageRepeat.repeat,
              fit: BoxFit.cover,
              width: width,
              height: height,
            )),
          );
          return DepthBuilder(builder: (context, offset) {
            final angleY = (offset.dy) * 0.01;
            final angleX = (offset.dx) * -0.01;
            return Transform(
              transform: Matrix4.identity()
                // ..setEntry(3, 2, perspective)
                ..rotateX(angleY)
                ..rotateY(angleX)
                ..translate(0.0, 0.0, 0),
              alignment: FractionalOffset.center,
              child: Stack(
                children: [
                  Container(
                      // transform: Matrix4.identity()
                      //   ..setEntry(3, 2, perspective)
                      //   ..translate(0.0, 0.0, -50),
                      child: customCube),
                  // Image.asset(
                  //   "assets/images/lava_a.jpg",
                  //   width: double.maxFinite,
                  //   height: double.maxFinite,
                  //   fit: BoxFit.fill,
                  // ),
                  Container(
                    // transform: Matrix4.identity()..translate(0.0, 0.0, 10),
                    child: Stack(
                      clipBehavior: Clip.none,

                      ///
                      ///
                      /// reorder children based on view angle to avoid overlapping of widgets.
                      ///
                      ///
                      children: list
                        ..sort((a, b) =>
                            b.tile.currentPos.y.compareTo(a.tile.currentPos.y) *
                                offset.dx.sign.toInt() +
                            b.tile.currentPos.x.compareTo(a.tile.currentPos.x) *
                                offset.dy.sign.toInt()),
                    ),
                  )
                ],
              ),
            );
          });
          // );
        }),
      ),
    );
  }
}
