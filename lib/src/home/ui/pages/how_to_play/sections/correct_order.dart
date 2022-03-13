import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/helper/depth/depth_resolver.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';
import 'package:sliding_puzzle/src/puzzle/provider/state_provider/tile_state.dart';
import 'package:sliding_puzzle/src/puzzle/puzzle.dart';

class OrderOfBoard extends StatelessWidget {
  const OrderOfBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Text(
            "Correct Order Of Board",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: constraints.biggest.shortestSide * 0.2,
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: constraints.biggest.shortestSide / 2,
                child: const CorrectBoard(),
              ),
            ),
          ),
          const Text("Above is the Correct Order of Board, Drag to rotate"),
          SizedBox(
            height: constraints.biggest.shortestSide * 0.2,
          ),
        ],
      );
    });
  }
}

class CorrectBoard extends ConsumerWidget {
  const CorrectBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var rotationController =
        ref.watch(BoardUIController.provider).boardRotationController;
    return GestureDetector(
      onPanUpdate: (details) {
        rotationController.rotateBy(
            Offset(-details.delta.dx * 0.01, details.delta.dy * 0.01));
      },
      child: DepthTransformer(
        rotationController: rotationController,
        child: AbsorbPointer(
          absorbing: true,
          child: Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: LayoutBuilder(builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final height = constraints.maxHeight;

                    final tileWidth =
                        (width / ref.watch(BoardUIController.provider).xDim);
                    final tileHeight =
                        (height / ref.watch(BoardUIController.provider).yDim);
                    var list = List<DummyCorrectPiller>.from((ref
                            .read(BoardUIController.provider)
                            .boardController
                            .tiles
                          ..sort(
                              (a, b) => a.currentPos.compareTo(b.currentPos)))
                        .map((tile) {
                      return DummyCorrectPiller(
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
                    var environment = CustomCube(
                        enableShadow: false,
                        width: width,
                        height: height,
                        depth: (list.length + 1) * tileWidth * 0.4,
                        faceWidgets: CubeFaceWidgets(
                          topFace: (context, size) => CubeFaceWidget(
                            size: size,
                            cubeTheme: ref
                                .watch(ThemeNotifier.provider)
                                .boardTheme
                                .environment
                                .top,
                            // color: const Color(0xFF97857d),
                            // child: const Center(),
                          ),
                          leftFace: (context, size) => CubeFaceWidget(
                            size: size,
                            cubeTheme: ref
                                .watch(ThemeNotifier.provider)
                                .boardTheme
                                .environment
                                .left,
                            // color: const Color(0xFF97857d),
                            // child: const Center(),
                          ),
                          rightFace: (context, size) => CubeFaceWidget(
                            size: size,
                            cubeTheme: ref
                                .watch(ThemeNotifier.provider)
                                .boardTheme
                                .environment
                                .right,
                            // color: const Color(0xFF97857d),
                            // child: const Center(),
                          ),
                          upFace: (context, size) => CubeFaceWidget(
                            size: size,
                            cubeTheme: ref
                                .watch(ThemeNotifier.provider)
                                .boardTheme
                                .environment
                                .up,
                            // color: const Color(0xFF97857d),
                            // child: const Center(),
                          ),
                          downFace: (context, size) => CubeFaceWidget(
                            size: size,
                            cubeTheme: ref
                                .watch(ThemeNotifier.provider)
                                .boardTheme
                                .environment
                                .down,
                            // color: const Color(0xFF97857d),
                            // child: const Center(),
                          ),
                        ),
                        boardRotaioncontroller: rotationController);
                    // return DepthBuilder(
                    //     rotationController: rotationController,
                    //     builder: (context, offset) {
                    // final angleY = (offset.dy);
                    // final angleX = -(offset.dx);
                    return Stack(
                      clipBehavior: Clip.none,

                      ///
                      ///
                      /// reorder children based on view angle to avoid overlapping of widgets.
                      ///
                      ///
                      children: [
                        base,
                        DepthResolver(
                            objects: list,
                            rotationController: rotationController),
                        // ...list
                        //   ..sort((a, b) =>
                        //       b.tile.currentPos.y
                        //               .compareTo(a.tile.currentPos.y) *
                        //           angleX.sign.toInt() +
                        //       b.tile.currentPos.x
                        //               .compareTo(a.tile.currentPos.x) *
                        //           angleY.sign.toInt()),
                        environment
                      ],
                    );
                    // });
                    // );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DummyCorrectPiller extends ConsumerWidget with DepthObject {
  const DummyCorrectPiller(
      {Key? key,
      required this.tile,
      required this.tileHeight,
      required this.tileWidth,
      required this.rotationController})
      : super(key: key);
  final Tile tile;
  final double tileHeight;
  final double tileWidth;
  final BoardRotationController rotationController;

  @override
  double get centerX => (tile.correctPos.y) * 1.0;

  @override
  double get centerY => (tile.correctPos).x * 1.0;
  // final MovablePosition _movablePosition = MovablePosition.none;
  double top(BoardPosition position) => tileHeight * position.x;
  double left(BoardPosition position) => tileWidth * position.y;
  int get index => tile.correctPos.x * 3 + tile.correctPos.y;
  @override
  Widget build(BuildContext context, ref) {
    final space = tileWidth * 0.15;
    var depth = (index + 1) * tileWidth * 0.25;
    return Positioned(
      top: top(tile.correctPos),
      left: left(tile.correctPos),
      child: CustomCube(
        boardRotaioncontroller: rotationController,
        width: tileWidth - space,
        height: tileHeight - space,
        depth: depth,
        depthOffset: 0,
        faceWidgets: CubeFaceWidgets(
          topFace: (context, size) => Stack(
            children: [
              CubeFaceWidget(
                size: size,
                cubeTheme: ref
                    .watch(TileStateNotifier.provider(tile.correctPos))
                    .style
                    .top,
              ),
              Container(
                child: const Center(),
                color: Colors.grey
                    .withOpacity(((index + 1) / 40).clamp(0.02, 0.4)),
              ),
            ],
          ),
          leftFace: (context, size) => CubeFaceWidget(
            size: size,
            cubeTheme: ref
                .watch(TileStateNotifier.provider(tile.correctPos))
                .style
                .left,
          ),
          rightFace: (context, size) => CubeFaceWidget(
            size: size,
            cubeTheme: ref
                .watch(TileStateNotifier.provider(tile.correctPos))
                .style
                .right,
          ),
          upFace: (context, size) => CubeFaceWidget(
            size: size,
            cubeTheme:
                ref.watch(TileStateNotifier.provider(tile.correctPos)).style.up,
          ),
          downFace: (context, size) => CubeFaceWidget(
            size: size,
            cubeTheme: ref
                .watch(TileStateNotifier.provider(tile.correctPos))
                .style
                .down,
          ),
        ),
      ),
    );
  }
}
