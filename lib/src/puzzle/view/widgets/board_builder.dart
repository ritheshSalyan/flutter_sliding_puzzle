import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/theme/theme_provider.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/cube.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/cube_face_widget.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/depth_builder.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_controller.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';

import '../../puzzle.dart';

class BoardView extends HookConsumerWidget {
  const BoardView({
    Key? key,
  }) : super(key: key);

  // Offset _offset = Offset.zero;
  @override
  Widget build(BuildContext context, ref) {
    final board = ref.watch(BoardLogicController.provider);
    var rotationController =
        ref.watch(BoardUIController.provider).boardRotationController;
    return AbsorbPointer(
      absorbing: ref.watch(BoardUIController.provider).isCompleted,
      child: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: LayoutBuilder(builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;

                final tileWidth = (width / board.xDim);
                final tileHeight = (height / board.yDim);
                var list = List<TileBuilder>.from((ref
                        .read(BoardLogicController.provider)
                        .tiles
                      ..sort((a, b) => a.currentPos.compareTo(b.currentPos)))
                    .map((tile) {
                  return TileBuilder(
                    rotationController: rotationController,
                    tile: tile,
                    tileWidth: tileWidth,
                    tileHeight: tileHeight,
                  );
                }));
                var base = BoardBase(
                  rotationController: rotationController,
                  width: width,
                  height: height,
                );

                return DepthBuilder(
                    rotationController: rotationController,
                    builder: (context, offset) {
                      final angleY = (offset.dy);
                      final angleX = (offset.dx);
                      return Transform(
                        transform: Matrix4.identity()
                          // ..setEntry(3, 2, perspective)
                          ..rotateX(angleY)
                          ..rotateY(angleX)
                          ..translate(0.0, 0.0, 0),
                        alignment: FractionalOffset.center,
                        child: Stack(
                          children: [
                            base,
                            Stack(
                              clipBehavior: Clip.none,

                              ///
                              ///
                              /// reorder children based on view angle to avoid overlapping of widgets.
                              ///
                              ///
                              children: list
                                ..sort((a, b) =>
                                    b.tile.currentPos.y
                                            .compareTo(a.tile.currentPos.y) *
                                        -offset.dx.sign.toInt() +
                                    b.tile.currentPos.x
                                            .compareTo(a.tile.currentPos.x) *
                                        offset.dy.sign.toInt()),
                            )
                          ],
                        ),
                      );
                    });
                // );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class BoardBase extends ConsumerWidget {
  const BoardBase({
    Key? key,
    required this.width,
    required this.height,
    required this.rotationController,
  }) : super(key: key);
  final double width;
  final double height;
  final BoardRotationController rotationController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final depth = width * 0.25;
    return CustomCube(
      boardRotaioncontroller: rotationController,
      width: width,
      height: height,
      depth: depth,
      depthOffset: depth,
      faceWidgets: CubeFaceWidgets(
        topFace: (context, size) => CubeFaceWidget(
          cubeTheme: ref.watch(ThemeNotifier.provider).boardTheme.baseTheme.top,
          // color: const Color(0xFF97857d),
          // child: const Center(),
        ),
        leftFace: (context, size) => CubeFaceWidget(
          cubeTheme:
              ref.watch(ThemeNotifier.provider).boardTheme.baseTheme.left,
          // color: const Color(0xFF97857d),
          // child: const Center(),
        ),
        rightFace: (context, size) => CubeFaceWidget(
          cubeTheme:
              ref.watch(ThemeNotifier.provider).boardTheme.baseTheme.right,
          // color: const Color(0xFF97857d),
          // child: const Center(),
        ),
        upFace: (context, size) => CubeFaceWidget(
          cubeTheme: ref.watch(ThemeNotifier.provider).boardTheme.baseTheme.up,
          // color: const Color(0xFF97857d),
          // child: const Center(),
        ),
        downFace: (context, size) => CubeFaceWidget(
          cubeTheme:
              ref.watch(ThemeNotifier.provider).boardTheme.baseTheme.down,
          // color: const Color(0xFF97857d),
          // child: const Center(),
        ),
      ),
    );
  }
}
