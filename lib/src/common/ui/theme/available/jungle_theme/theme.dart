import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/gen/assets.gen.dart';
import 'package:sliding_puzzle/helper/depth/depth_resolver.dart';
import 'package:sliding_puzzle/helper/voxel/renderer.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/common/provider/voxel_mesh_provider.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/jungle_theme/elements.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';
import 'package:sliding_puzzle/src/puzzle/provider/provider.dart';

import '../../audio_theme.dart';

AppTheme jungleTheme = AppTheme(
  elements: [
    ...JungleThemeElements.elements,
  ],
  backgroundColor: JungleColorSystem.backgroundColor,
  foregroundColor: JungleColorSystem.accentColor,
  audios: AudioThemes(
      tileMove: Assets.audio.nature.tileMove,
      correctPos: Assets.audio.nature.correctPos,
      completion: Assets.audio.nature.completion,
      background: Assets.audio.nature.background),
  boardTheme: BoardTheme(
    baseTheme: CubeTheme.symetric(
      CubeFaceTheme(
        baseColor: JungleColorSystem.baseGreen,
        spotPainter: JungleBaseTopPainter(),
      ),
      CubeFaceTheme(
        baseColor: JungleColorSystem.baseGreen,
        spotPainter: JungleBaseSidePainter(true),
      ),
      CubeFaceTheme(
        baseColor: JungleColorSystem.baseGreen,
        spotPainter: JungleBaseSidePainter(false),
      ),
    ),
    tileTheme: () {
      bool canHaveTree = Random().nextBool();

      List<TopElement> _elements = [];

      if (canHaveTree) {
        _elements.add(
          TopElement(
            assetPath: JungleThemeElements.tree,
            position: Offset(0.1 + Random().nextDouble() * 0.8,
                0.1 + Random().nextDouble() * 0.8),
          ),
        );
      }
      bool canHaveRock = Random().nextBool();
      if (canHaveRock && _elements.isEmpty) {
        _elements.add(
          TopElement(
            assetPath: JungleThemeElements.rock,
            position: Offset(0.1 + Random().nextDouble() * 0.8,
                0.1 + Random().nextDouble() * 0.8),
          ),
        );
      }
      return CubeTheme.symetric(
          CubeFaceTheme(
            baseColor: JungleColorSystem.tileGreen,
            spotPainter: JungleTileTopPainter(),
            child: _elements.isEmpty
                ? Container()
                : LayoutBuilder(builder: (context, constraints) {
                    // dev.log("Rbuild $constraints ");
                    List<_TopElements> elementWidgets = [];
                    for (var position in _elements) {
                      elementWidgets.add(_TopElements(
                        constraints: constraints,
                        element: position,
                      ));
                    }
                    return Consumer(builder: (context, ref, widget) {
                      return DepthResolver(
                        objects: elementWidgets,
                        rotationController: ref
                            .watch(BoardUIController.provider)
                            .boardRotationController,
                      );
                    });
                    // return Container(
                    //   color: Colors.red,
                    //   child: Stack(
                    //     clipBehavior: Clip.none,
                    //     children: [],
                    //   ),
                    // );
                  }),
          ),
          CubeFaceTheme(
            baseColor: JungleColorSystem.tileGreen,
            spotPainter: JungleTileSidePainter(true),
          ),
          CubeFaceTheme(
            baseColor: JungleColorSystem.tileGreen,
            spotPainter: JungleTileSidePainter(false),
          ));
    },
    environment: CubeTheme.all(
      CubeFaceTheme(
        baseColor: Colors.transparent,
        // child:
        //  const EnvironmentParticle(
        //   color: Colors.amber,
        // ),
      ),
    ),
  ),
);

class TopElement {
  final String assetPath;
  final Offset position;

  TopElement({required this.assetPath, required this.position});
}

class _TopElements extends ConsumerWidget with DepthObject {
  const _TopElements(
      {Key? key, required this.constraints, required this.element})
      : super(key: key);

  final BoxConstraints constraints;
  final TopElement element;
  // final Offset position;
  // final String mesh;

  @override
  Widget build(BuildContext context, ref) {
    return ref.watch(MeshProvider.provider(element.assetPath)).when(
          data: (data) {
            return Transform(
              alignment: Alignment.bottomRight,
              transform: Matrix4.identity()
                ..translate(
                  x,
                  y,
                ),
              child: SizedBox(
                width: constraints.maxWidth * 0.5,
                height: constraints.maxHeight * 0.5,
                child: VoxelBuilder(
                  mesh: data,
                  rotationController: BoardRotationController(),
                ),
              ),
            );
          },
          error: (e, a) => Container(),
          loading: () => Container(),
        );

    // Container()
  }

  Offset get position => element.position;

  double get x => constraints.maxWidth * 0.8 * position.dx;
  // (constraints.maxWidth / 2) - ((constraints.maxWidth / 2) * position.dx);
  double get y =>
      (constraints.maxWidth * 0.9) *
      (position.dy); //+ (constraints.maxWidth / 2);
  @override
  double get centerX => x;

  @override
  double get centerY => y;
}

// class Tree extends StatefulWidget {
//   const Tree({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<Tree> createState() => _TreeState();
// }

// class _TreeState extends State<Tree> {
//   @override
//   Widget build(BuildContext context) {
//     // const treeHeight = 30.0;
//     return AspectRatio(
//       aspectRatio: 1,
//       child: LayoutBuilder(builder: (context, constraints) {
//         final width = constraints.maxWidth;
//         final treeHeight = width;
//         final trunkWidth = width / 4;
//         final leafDepth = width / 2;
//         return Stack(
//           clipBehavior: Clip.none,
//           alignment: Alignment.center,
//           children: [
//             CustomCube(
//               width: trunkWidth,
//               height: trunkWidth,
//               depth: treeHeight,
//               boardRotaioncontroller: BoardRotationController(),
//               faceWidgets: CubeFaceWidgets.all((context, size) => Container(
//                     width: size.width,
//                     height: size.height,
//                     color: Colors.grey,
//                   )),
//             ),
//             Transform(
//               transform: Matrix4.identity()
//                 ..translate(-(width - trunkWidth) / 2,
//                     -(width - trunkWidth) / 2, -(treeHeight + width)),
//               child: CustomCube(
//                 width: width,
//                 height: width,
//                 depth: leafDepth,
//                 depthOffset: treeHeight + leafDepth,
//                 boardRotaioncontroller: BoardRotationController(),
//                 faceWidgets: CubeFaceWidgets.all((context, size) => Container(
//                       width: size.width,
//                       height: size.height,
//                       color: Colors.green,
//                     )),
//               ),
//             ),
//             Transform(
//               transform: Matrix4.identity()
//                 ..translate(-(width - trunkWidth) / 2,
//                     -(width - trunkWidth) / 2, -(treeHeight + width * 2)),
//               child: CustomCube(
//                 width: width / 2,
//                 height: width / 2,
//                 depth: leafDepth,
//                 depthOffset: treeHeight + leafDepth * 2,
//                 boardRotaioncontroller: BoardRotationController(),
//                 faceWidgets: CubeFaceWidgets.all((context, size) => Container(
//                       width: size.width,
//                       height: size.height,
//                       color: Colors.green,
//                     )),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

// class TreeOne extends StatefulWidget {
//   const TreeOne({Key? key}) : super(key: key);

//   @override
//   State<TreeOne> createState() => _TreeOneState();
// }

// class _TreeOneState extends State<TreeOne> {
//   late final VoxelMesh mesh;
//   @override
//   void initState() {
//     mesh = VoxelMeshFactory(voxelTree).construct();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VoxelBuilder(
//         mesh: mesh, rotationController: BoardRotationController());
//   }
// }
