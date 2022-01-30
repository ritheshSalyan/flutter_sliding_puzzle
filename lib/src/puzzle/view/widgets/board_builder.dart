import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_controller.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_provider.dart';

import '../../puzzle.dart';

class BoardView extends StatefulHookConsumerWidget {
  const BoardView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends ConsumerState<BoardView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    ref.read(BoardUIController.provider).createAnimationControllers(this);
    super.initState();
  }

  // Offset _offset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    final board = ref.watch(BoardLogicController.provider);
    // final boardController = ref.watch(BoardUIController.provider);
    return Center(
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
            children: List<Widget>.from(
                (ref.read(BoardLogicController.provider).tiles
                      ..sort((a, b) => a.currentPos.compareTo(b.currentPos)))
                    .map((tile) {
              // var animationController2 = ref
              //     .read(BoardUIController.provider)
              //     .animationControllers
              //     .idelTilesController
              //     .animationController;
              // int random =
              //     Random().nextInt(15) * (Random().nextBool() ? -1 : 1);
              // double top = tileHeight * tile.currentPos.x;
              // //  +    (5 + random) * animationController2.value;
              // double left = tileWidth * tile.currentPos.y;
              // +    (5 + random) * animationController2.value;
              // return ValueListenableBuilder<Offset>(
              //     valueListenable:
              //         boardController.boardRotationController.boardAngle,
              //     builder: (context, _offset, child) {
              return TileBuilder(
                tile: tile,
                tileWidth: tileWidth,
                tileHeight: tileHeight,
              );
              // });
              // return AnimatedBuilder(
              //     animation: animationController2,
              // child: TileBuilder(
              //   tile: tile,
              //   tileWidth: tileWidth,
              //   tileHeight: tileHeight,
              //   offset: _offset,
              // ),
              //     builder: (context, child) {
              // double top = tileHeight * tile.currentPos.x +
              //     (5 + random) * animationController2.value;
              // double left = tileWidth * tile.currentPos.y +
              //     (5 + random) * animationController2.value;
              //       return Positioned(
              //         top: top,
              //         left: left,
              //         child: child!,
              //       );
              //     });
            })),
          );
          // );
        }),
      ),
    );
  }
}
