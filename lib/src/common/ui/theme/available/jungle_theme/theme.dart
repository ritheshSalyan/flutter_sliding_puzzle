import 'dart:math';

import 'package:flutter/material.dart';
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
                                  left:
                                      (constraints.maxWidth - 30) * position.dx,
                                  top: (constraints.maxHeight - 30) *
                                      position.dy,
                                  child: const Tree())
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
    const treeHeight = 30.0;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomCube(
          width: 10,
          height: 10,
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
            ..translate(-15.0, -15.0, -(treeHeight + 20)),
          child: CustomCube(
            width: 40,
            height: 40,
            depth: 20,
            depthOffset: 20,
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
            ..translate(-5.0, -5.0, -(treeHeight * 2 + 20)),
          child: CustomCube(
            width: 20,
            height: 20,
            depth: 20,
            depthOffset: 40,
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
  }
}
