import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/cube.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/cube_face_widget.dart';
import 'package:sliding_puzzle/src/puzzle/model/model.dart';
import 'package:sliding_puzzle/src/puzzle/provider/state_provider/tile_state.dart';

import '../../puzzle.dart';

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
    var tileState =
        ref.watch(TileStateNotifier.provider(tile.correctPos)).state;
    final _animationController = useAnimationController(
      duration:
          tileState is StartTileState || tileState is CompleteProgressTileState
              ? const Duration(milliseconds: 1000)
              : const Duration(milliseconds: 500),
    );

    useValueChanged(tileState, (_, void __) {
      if (tileState is TileMovementState &&
          tileState.currentPosition != tileState.previousPosition) {
        _animationController
            .forward(from: tileState.progress)
            .whenCompleteOrCancel(() {
          ref
              .read(TileStateNotifier.provider(tile.correctPos).notifier)
              .onCompleteAnimation();
          _animationController.reset();
        });
      } else if (tileState is StartTileState) {
        _animationController
            .forward(from: tileState.progress)
            .whenCompleteOrCancel(() {
          ref
              .read(TileStateNotifier.provider(tile.correctPos))
              .onCompleteAnimation();
          _animationController.reset();
        });
      } else if (tileState is CompleteProgressTileState) {
        _animationController
            .forward(from: tileState.progress)
            .whenCompleteOrCancel(() {
          ref
              .read(TileStateNotifier.provider(tile.correctPos))
              .onCompleteAnimation();
          _animationController.reset();
        });
      }
      return null;
    });
    Animation<double> positionTween = tileState is TileMovementState
        ? Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _animationController,
            curve: Curves.linearToEaseOut,
          ))
        : const AlwaysStoppedAnimation(1.0);
    if (tileState is TileMovementState) {
      positionTween.addListener(() {
        tileState.updateProgress(positionTween.value);
      });
    }
    final space = tile.correctPos == tile.currentPos
        ? tileWidth * 0.05
        : tileWidth * 0.15;

    var depth = (index + 1) * tileWidth / 4;
    Animation<double> heightTween = tileState is StartTileState
        ? Tween(begin: 1.0, end: depth).animate(CurvedAnimation(
            parent: _animationController,
            curve: Curves.linearToEaseOut,
          ))
        : tileState is CompleteProgressTileState
            ? Tween(
                    begin: depth,
                    end: (tileState.noOfTiles + 1) * tileWidth / 4)
                .animate(CurvedAnimation(
                parent: _animationController,
                curve: Curves.linearToEaseOut,
              ))
            : AlwaysStoppedAnimation((tileState is CompleteTileState)
                ? ((tileState).noOfTiles + 1) * tileWidth / 4
                : depth);
    if (tileState is StartTileState || tileState is CompleteProgressTileState) {
      heightTween.addListener(() {
        tileState.updateProgress(positionTween.value);
      });
    }
    return AnimatedBuilder(
      animation: positionTween,
      child: AnimatedBuilder(
          animation: heightTween,
          builder: (context, snapshot) {
            return CustomCube(
              width: tileWidth - space,
              height: tileHeight - space,
              depth: heightTween.value,
              depthOffset: 0,
              faceWidgets: CubeFaceWidgets(
                topFace: (context, size) => CubeFaceWidget(
                  cubeTheme: ref
                      .watch(TileStateNotifier.provider(tile.correctPos))
                      .style
                      .top,
                ),
                leftFace: (context, size) => CubeFaceWidget(
                  cubeTheme: ref
                      .watch(TileStateNotifier.provider(tile.correctPos))
                      .style
                      .left,
                ),
                rightFace: (context, size) => CubeFaceWidget(
                  cubeTheme: ref
                      .watch(TileStateNotifier.provider(tile.correctPos))
                      .style
                      .right,
                ),
                upFace: (context, size) => CubeFaceWidget(
                  cubeTheme: ref
                      .watch(TileStateNotifier.provider(tile.correctPos))
                      .style
                      .up,
                ),
                downFace: (context, size) => CubeFaceWidget(
                  cubeTheme: ref
                      .watch(TileStateNotifier.provider(tile.correctPos))
                      .style
                      .down,
                ),
              ),
              onTap: () {
                ref.read(BoardUIController.provider).moveTile(tile);
                // log("Can Move ${tile.data} ${board.canMoveTile(tile)}");
              },
            );
          }),
      builder: (BuildContext context, Widget? child) {
        double getTop() {
          if (tileState is! TileMovementState) {
            return top(tileState.currentPosition);
          }
          return top(tileState.previousPosition) +
              tileHeight *
                  (tileState.currentPosition.x - tileState.previousPosition.x)
                      .sign *
                  (positionTween.value);
        }

        double getLeft() {
          if (tileState is! TileMovementState) {
            return left(tileState.currentPosition);
          }
          return left(tileState.previousPosition) +
              tileWidth *
                  (tileState.currentPosition.y - tileState.previousPosition.y)
                      .sign *
                  (positionTween.value);
        }

        return Positioned(
            top: getTop() + space / 2,
            left: getLeft() + space / 2,
            child: child!);
      },
    );
  }
}
