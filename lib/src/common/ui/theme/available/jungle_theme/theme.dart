import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sliding_puzzle/helper/voxel/model/factory.dart';
import 'package:sliding_puzzle/helper/voxel/model/voxel_mesh.dart';
import 'package:sliding_puzzle/helper/voxel/renderer.dart';
import 'package:sliding_puzzle/helper/voxel/test_tree.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';

AppTheme jungleTheme = AppTheme(
  backgroundColor: JungleColorSystem.backgroundColor,
  foregroundColor: JungleColorSystem.accentColor,
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
      final noOftrees = Random().nextBool() ? 1 : 0;
      List<Offset> treePositions = [];
      for (var i = 0; i < noOftrees; i++) {
        treePositions.add(Offset(Random().nextDouble(), Random().nextDouble()));
      }
      VoxelMesh mesh = VoxelMeshFactory(voxelTree).construct();
      return CubeTheme.symetric(
          CubeFaceTheme(
            baseColor: JungleColorSystem.tileGreen,
            spotPainter: JungleTileTopPainter(),
            child: treePositions.isEmpty
                ? Container()
                : LayoutBuilder(
                    builder: (context, constraints) => Stack(
                          clipBehavior: Clip.none,
                          children: [
                            for (var position in treePositions) ...{
                              Positioned(
                                  right: 0,
                                  // (constraints.maxWidth ) * position.dy,
                                  bottom: 0,
                                  // (constraints.maxHeight) *position.dx,
                                  child: SizedBox(
                                      width: constraints.maxWidth / 2,
                                      child: VoxelBuilder(
                                        mesh: mesh,
                                        rotationController:
                                            BoardRotationController(),
                                      )))
                            }
                          ],
                        )),
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

class Tree extends StatefulWidget {
  const Tree({
    Key? key,
  }) : super(key: key);

  @override
  State<Tree> createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  @override
  Widget build(BuildContext context) {
    // const treeHeight = 30.0;
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        final treeHeight = width;
        final trunkWidth = width / 4;
        final leafDepth = width / 2;
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            CustomCube(
              width: trunkWidth,
              height: trunkWidth,
              depth: treeHeight,
              boardRotaioncontroller: BoardRotationController(),
              faceWidgets: CubeFaceWidgets.all((context, size) => Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.grey,
                  )),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(-(width - trunkWidth) / 2,
                    -(width - trunkWidth) / 2, -(treeHeight + width)),
              child: CustomCube(
                width: width,
                height: width,
                depth: leafDepth,
                depthOffset: treeHeight + leafDepth,
                boardRotaioncontroller: BoardRotationController(),
                faceWidgets: CubeFaceWidgets.all((context, size) => Container(
                      width: size.width,
                      height: size.height,
                      color: Colors.green,
                    )),
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(-(width - trunkWidth) / 2,
                    -(width - trunkWidth) / 2, -(treeHeight + width * 2)),
              child: CustomCube(
                width: width / 2,
                height: width / 2,
                depth: leafDepth,
                depthOffset: treeHeight + leafDepth * 2,
                boardRotaioncontroller: BoardRotationController(),
                faceWidgets: CubeFaceWidgets.all((context, size) => Container(
                      width: size.width,
                      height: size.height,
                      color: Colors.green,
                    )),
              ),
            ),
          ],
        );
      }),
    );
  }
}
