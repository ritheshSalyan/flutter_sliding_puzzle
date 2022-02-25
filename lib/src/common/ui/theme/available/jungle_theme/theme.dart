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
            child: LayoutBuilder(
                builder: (context, constraints) => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        for (var position in treePositions) ...{
                          Positioned(
                              left: (constraints.maxWidth - 30) * position.dx,
                              top: (constraints.maxHeight - 30) * position.dy,
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
    environment: CubeTheme.all(CubeFaceTheme(
        baseColor: Colors.transparent,
        child: const EnvironmentParticle(
          color: Colors.amber,
        ))),
  ),
);

class Tree extends StatelessWidget {
  const Tree({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomCube(
          width: 10,
          height: 10,
          depth: 30,
          boardRotaioncontroller: BoardRotationController(),
          faceWidgets: CubeFaceWidgets.all((context, size) => Container(
                width: size.width,
                height: size.height,
                color: Colors.brown,
              )),
        ),
        Transform(
          transform: Matrix4.identity()..translate(-5.0, -5.0, -40),
          child: CustomCube(
            width: 20,
            height: 20,
            depth: 40,
            depthOffset: 20,
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
