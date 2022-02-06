import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/model/model.dart';
import 'package:sliding_puzzle/src/puzzle/provider/tile_state.dart';

import '../../puzzle.dart';
import 'painter/custom_cube.dart';

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

    var positionTween = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linearToEaseOut,
    ));

    return AnimatedBuilder(
      animation: positionTween,
      child: InkWell(
        child: //DepthBuilder(builder: (context, offset) {
            // return CanvasTouchDetector(
            //   builder: (context,) {

            CustomCube(
          width: tileWidth - 30,
          height: tileHeight - 30,
          depth: (index + 1) * tileWidth,
          offsetY: (tile.currentPos.y - 2) * 3,
          offsetX: (tile.currentPos.x - 2) * 3,
          onTap: () {
            ref.read(BoardUIController.provider).moveTile(tile);
            // log("Can Move ${tile.data} ${board.canMoveTile(tile)}");
          },
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
                  (positionTween.value);
        }

        double getLeft() {
          if (tileState.currentPosition == tileState.previousPosition) {
            return left(tileState.currentPosition);
          }
          return left(tileState.previousPosition) +
              tileWidth *
                  (tileState.currentPosition.y - tileState.previousPosition.y)
                      .sign *
                  (positionTween.value);
        }

        return Positioned(top: getTop(), left: getLeft(), child: child!);
      },
    );
  }
}
