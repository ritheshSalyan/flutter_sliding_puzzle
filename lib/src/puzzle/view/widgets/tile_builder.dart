import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/model/model.dart';
import 'package:sliding_puzzle/src/puzzle/provider/tile_state.dart';

import '../../puzzle.dart';
import 'depth_builder.dart';
import 'painter/cube_painter.dart';

class TileBuilder extends HookConsumerWidget {
  final Tile tile;
  const TileBuilder({
    Key? key,
    required this.tile,
    required this.tileHeight,
    required this.tileWidth,
  }) : super(key: key);
  final double tileHeight;
  final double tileWidth;
  // final MovablePosition _movablePosition = MovablePosition.none;

  double top(BoardPosition position) => tileHeight * position.x;
  double left(BoardPosition position) => tileWidth * position.y;
  int get index => tile.correctPos.x * 4 + tile.correctPos.y;
  @override
  Widget build(BuildContext context, ref) {
    final _animationController =
        useAnimationController(duration: const Duration(milliseconds: 250));
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        // _animationController.reverse();

      }
    });
    var tileState = ref.watch(TileStateNotifier.provider(tile.correctPos));
    useValueChanged(tileState, (_, void __) {
      if (tileState.currentPosition != tileState.previousPosition) {
        _animationController.forward(from: 0).whenCompleteOrCancel(() {
          ref
              .read(TileStateNotifier.provider(tile.correctPos).notifier)
              .onCompleteAnimation();
          _animationController.reset();
        });
      }
      //  return null;
    });

    var animate = ColorTween(begin: Colors.red, end: Colors.blue)
        .animate(_animationController);

    return AnimatedBuilder(
      animation: _animationController,
      child: SizedBox(
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
          child: AnimatedBuilder(
              animation: animate,
              builder: (context, snapshot) {
                return DepthBuilder(builder: (context, offset) {
                  return CustomPaint(
                    foregroundPainter: CubePainter(
                        angleX: -0.01 * offset.dx,
                        angleY: 0.01 * offset.dy,
                        colors: [
                          animate.value ??
                              const Color.fromARGB(255, 255, 255, 0),
                          animate.value ??
                              const Color.fromARGB(255, 255, 255, 0),
                          animate.value ??
                              const Color.fromARGB(255, 255, 255, 0),
                          animate.value ??
                              const Color.fromARGB(255, 255, 255, 0),
                          animate.value ??
                              const Color.fromARGB(255, 255, 255, 0),
                          animate.value ??
                              const Color.fromARGB(255, 255, 255, 0),
                        ],
                        index: index),
                  );
                });
              }),
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
      ),
      builder: (BuildContext context, Widget? child) {
        double getTop() {
          if (tileState.currentPosition == tileState.previousPosition) {
            return top(tileState.currentPosition);
          }
          return top(tileState.previousPosition) +
              tileHeight *
                  (tileState.currentPosition.x - tileState.previousPosition.x)
                      .sign *
                  (_animationController.value);
        }

        double getLeft() {
          if (tileState.currentPosition == tileState.previousPosition) {
            return left(tileState.currentPosition);
          }
          return left(tileState.previousPosition) +
              tileWidth *
                  (tileState.currentPosition.y - tileState.previousPosition.y)
                      .sign *
                  (_animationController.value);
        }

        return Positioned(top: getTop(), left: getLeft(), child: child!);
      },
    );
  }
}
