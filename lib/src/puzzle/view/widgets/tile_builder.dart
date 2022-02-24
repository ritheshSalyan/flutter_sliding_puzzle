import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/theme/theme_provider.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/cube.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/cube_face_widget.dart';
import 'package:sliding_puzzle/src/puzzle/provider/difficuly_level.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';
import 'package:sliding_puzzle/src/puzzle/provider/state_provider/tile_state.dart';

import '../../puzzle.dart';

class TileBuilder extends HookConsumerWidget {
  final Tile tile;
  const TileBuilder({
    Key? key,
    required this.tile,
    required this.tileHeight,
    required this.tileWidth,
    required this.rotationController,
  }) : super(key: key);
  final double tileHeight;
  final double tileWidth;
  final BoardRotationController rotationController;
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
              ? Duration(milliseconds: 2000 + 100 * index)
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
        Future.delayed(Duration(milliseconds: 1000 * index)).then((value) {
          _animationController
              .forward(from: tileState.progress)
              .whenComplete(() {
            ref
                .read(TileStateNotifier.provider(tile.correctPos))
                .completeEndAnimation();
          });
        });
      }
      return null;
    });

    if (tileState is StartTileState ||
        tileState is CompleteProgressTileState ||
        tileState is TileMovementState) {
      if (!_animationController.isAnimating) {
        _animationController.forward(from: tileState.progress);
      }
    }
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
    var isInCorrectPos = tile.correctPos == tile.currentPos;
    final space = (isInCorrectPos &&
            ref.watch(DifficultyNotifier.provider) != DifficulyLevel.hard)
        ? tileWidth * 0.05
        : tileWidth * 0.15;

    var depth = (index + 1) * tileWidth * 0.25;
    Animation<double> heightTween = tileState is StartTileState
        ? Tween(begin: 1.0, end: depth).animate(CurvedAnimation(
            parent: _animationController,
            curve: Curves.linearToEaseOut,
          ))
        : tileState is CompleteProgressTileState
            ? TweenSequence<double>([
                TweenSequenceItem(
                    tween: Tween<double>(
                      begin: depth,
                      end: (tileState.noOfTiles + 1) * tileWidth / 4,
                    ),
                    weight: 40),
                TweenSequenceItem(
                    tween: ConstantTween(
                        (tileState.noOfTiles + 1) * tileWidth / 4),
                    weight: 20),
                TweenSequenceItem(
                    tween: Tween<double>(
                      begin: (tileState.noOfTiles + 1) * tileWidth / 4,
                      end: 1.0,
                    ),
                    weight: 40),
              ]).animate(CurvedAnimation(
                parent: _animationController,
                curve: Curves.bounceOut,
              ))
            : AlwaysStoppedAnimation(
                (tileState is CompleteTileState) ? 1.0 : depth,
              );
    if (tileState is StartTileState || tileState is CompleteProgressTileState) {
      heightTween.addListener(() {
        tileState.updateProgress(_animationController.value);
      });
    }

    final faceChild =
        ref.watch(DifficultyNotifier.provider) == DifficulyLevel.easy
            ? (isInCorrectPos
                ? Icon(
                    Icons.check,
                    color: ref.watch(ThemeNotifier.provider).foregroundColor,
                  )
                : Text(
                    "${index + 1}",
                    style: TextStyle(
                      color: ref.watch(ThemeNotifier.provider).foregroundColor,
                    ),
                  ))
            : const SizedBox();
    return AnimatedBuilder(
      animation: positionTween,
      child: AnimatedBuilder(
          animation: heightTween,
          builder: (context, snapshot) {
            return CustomCube(
              boardRotaioncontroller: rotationController,
              width: tileWidth - space,
              height: tileHeight - space,
              depth: heightTween.value,
              depthOffset: 0,
              faceWidgets: CubeFaceWidgets(
                topFace: (context, size) => Stack(
                  children: [
                    CubeFaceWidget(
                      cubeTheme: ref
                          .watch(TileStateNotifier.provider(tile.correctPos))
                          .style
                          .top,
                    ),
                    Container(
                      child: Center(
                        child: faceChild,
                      ),
                      color: Colors.blueGrey
                          .withOpacity(((index + 1) / 40).clamp(0.02, 0.4)),
                    ),
                  ],
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
