import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sliding_puzzle/gen/assets.gen.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/jungle_theme/elements.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/elements/element.dart';

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
      bool canHaveTree = true;
      int rotation = Random().nextInt(4);

      /// Random().nextBool();

      List<String> _elements = [];

      if (canHaveTree) {
        _elements.add(
          // TopElement(
          //   assetPath:
          JungleThemeElements.tree,
          //   position: Offset(0.1 + Random().nextDouble() * 0.8,
          //       0.1 + Random().nextDouble() * 0.8),
          // ),
        );
      }
      // bool canHaveRock = Random().nextBool();
      // if (canHaveRock && _elements.isEmpty) {
      //   _elements.add(
      //     // TopElement(
      //     //   assetPath:
      //       JungleThemeElements.rock,
      //     //   position: Offset(0.1 + Random().nextDouble() * 0.8,
      //     //       0.1 + Random().nextDouble() * 0.8),
      //     // ),
      //   );
      // }
      return CubeTheme.symetric(
          CubeFaceTheme(
              baseColor: JungleColorSystem.tileGreen,
              spotPainter: JungleTileTopPainter(),
              child: _elements.isEmpty
                  ? Container()
                  : RotatedBox(
                      quarterTurns: rotation,
                      child: TopElementWidget(element: _elements.first),
                    )
              // LayoutBuilder(builder: (context, constraints) {
              //     // dev.log("Rbuild $constraints ");
              //     List<TopElementWidget> elementWidgets = [];
              //     for (var position in _elements) {
              //       elementWidgets.add(TopElementWidget(
              //         constraints: constraints,
              //         element: position,
              //       ));
              //     }
              //     return Consumer(builder: (context, ref, widget) {
              //       return DepthResolver(
              //         objects: elementWidgets,
              //         rotationController: ref
              //             .watch(BoardUIController.provider)
              //             .boardRotationController,
              //       );
              //     });
              //     // return Container(
              //     //   color: Colors.red,
              //     //   child: Stack(
              //     //     clipBehavior: Clip.none,
              //     //     children: [],
              //     //   ),
              //     // );
              //   }

              //   ),
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
