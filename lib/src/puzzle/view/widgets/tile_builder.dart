import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/model/model.dart';

import '../../puzzle.dart';
import 'painter/cube_painter.dart';

class TileBuilder extends ConsumerWidget {
  final Tile tile;
  const TileBuilder({
    Key? key,
    required this.tile,
    required this.tileHeight,
    required this.tileWidth,
    required this.offset,
  }) : super(key: key);
  final double tileHeight;
  final double tileWidth;
  final Offset offset;

  // final MovablePosition _movablePosition = MovablePosition.none;

  double get top => tileHeight * tile.currentPos.x;
  double get left => tileWidth * tile.currentPos.y;
  int get index => tile.correctPos.x * 4 + tile.correctPos.y;
  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      width: tileWidth,
      height: tileHeight,
      child: InkWell(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        // onPanStart: (details) {
        //   _movablePosition = ref
        //       .read(BoardLogicController.provider)
        //       .getMovablePosition(tile);
        // },
        // onPanUpdate: (details) {
        //   final delta = details.delta;

        //   switch (_movablePosition) {
        //     case MovablePosition.top:
        //       if (top + delta.dy > top) {
        //         extraOffset += Offset(0, delta.dy);
        //       }
        //       break;
        //     case MovablePosition.down:
        //       if (top + delta.dy < top) {
        //         extraOffset += Offset(0, delta.dy);
        //       }
        //       break;
        //     case MovablePosition.left:
        //       if (left + delta.dx > left) {
        //         extraOffset += Offset(delta.dx, 0);
        //       }
        //       break;
        //     case MovablePosition.right:
        //       if (left + delta.dx < left) {
        //         extraOffset += Offset(delta.dx, 0);
        //       }
        //       break;
        //     case MovablePosition.none:
        //       // TODO: Handle this case.
        //       break;
        //   }
        //   setState(() {});
        // },
        // onPanEnd: (details) {
        //   if ((extraOffset.dx.abs() > tileWidth / 2) ||
        //       (extraOffset.dy.abs() > tileHeight / 2)) {
        //     ref.read(BoardAnimationController.provider).moveTile(tile);
        //   }
        //   extraOffset = Offset.zero;
        //   setState(() {});
        // },
        onTap: () {
          ref.read(BoardUIController.provider).moveTile(tile);
          // log("Can Move ${tile.data} ${board.canMoveTile(tile)}");
        },
        child: CustomPaint(
          foregroundPainter: CubePainter(
              angleX: -0.01 * offset.dx,
              angleY: 0.01 * offset.dy,
              colors: [
                const Color.fromARGB(255, 255, 255, 0),
                const Color.fromARGB(255, 255, 255, 0),
                const Color.fromARGB(255, 255, 255, 0),
                const Color.fromARGB(255, 255, 255, 0),
                const Color.fromARGB(255, 255, 255, 0),
                const Color.fromARGB(255, 255, 255, 0),
              ],
              index: index),
        ),
        //  Container(
        //   decoration: BoxDecoration(
        //     color: Colors.red,
        //     border: Border.all(color: Colors.blue),
        //   ),
        //   child: Center(
        //     child: Text("${tile.data}"),
        //   ),
        // ),
      ),
    );
  }
}
