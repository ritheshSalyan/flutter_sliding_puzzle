import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sliding_puzzle/gen/assets.gen.dart';
import 'package:sliding_puzzle/src/common/ui/theme/app_theme.dart';
import 'package:sliding_puzzle/src/common/ui/theme/audio_theme.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/ice_theme/elements.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/jungle_theme/widgets/particles.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/elements/element.dart';

import 'colors.dart';
import 'painter/base_painter.dart';
import 'painter/tile_painter.dart';

AppTheme iceTheme = AppTheme(
  elements: IceLandElements.elements,
  backgroundColor: IceColorSystem.background,
  foregroundColor: IceColorSystem.accentColor,
  audios: AudioThemes(
      tileMove: Assets.audio.ice.tileMove,
      correctPos: Assets.audio.ice.correctPos,
      completion: Assets.audio.ice.completion,
      background: Assets.audio.ice.background),
  boardTheme: BoardTheme(
    baseTheme: CubeTheme.symetric(
      CubeFaceTheme(
        baseColor: IceColorSystem.baseColor, //LavaColorSystem.baseColor,
        // spotPainter: WavePainter(
        //   // percentValue: 50,
        //   // boxHeight: 100,
        //   waveColor: const Color(0xFF5d4843),
        // ),
        // spotColor: const Color(0xFF5d4843),
      ),
      CubeFaceTheme(
          baseColor: IceColorSystem.baseColor,
          spotPainter: LavaBasePainter(true
              // percentValue: 50,
              // boxHeight: 100,

              ),
          child: Image.asset(
            Assets.images.wave.path,
            fit: BoxFit.fill,
            color: Colors.white,
          )
          // spotColor: const Color(0xFF5d4843),
          ),
      CubeFaceTheme(
          baseColor: IceColorSystem.baseColor,
          spotPainter: LavaBasePainter(false
              // percentValue: 50,
              // boxHeight: 100,
              ),
          child: RotatedBox(
            quarterTurns: 3,
            child: Image.asset(
              Assets.images.wave.path,
              fit: BoxFit.fill,
              color: Colors.white,
            ),
          )
          // spotColor: const Color(0xFF5d4843),
          ),
    ),
    tileTheme: () {
      bool canHaveTree = Random().nextBool();
      int rotation = Random().nextInt(4);

      List<String> _elements = [];

      if (canHaveTree) {
        _elements.add(
          // TopElement(
          //   assetPath:
          IceLandElements.tree,
          //   position: Offset(0.1 + Random().nextDouble() * 0.8,
          //       0.1 + Random().nextDouble() * 0.8),
          // ),
        );
      }
      return CubeTheme.symetric(
          CubeFaceTheme(
              baseColor: IceColorSystem.tileBase,
              // spotPainter: LavaTilePainter(LavaColorSystem.tileSpot, false),
              child: Container(
                child: _elements.isEmpty
                    ? const Center()
                    : RotatedBox(
                        quarterTurns: rotation,
                        child: TopElementWidget(element: _elements.first)),
                color: Colors.white,
              )

              // spotColor: LavaColorSystem.tileSpot,
              ),
          CubeFaceTheme(
              baseColor: IceColorSystem.tileBase,
              spotPainter: LavaTilePainter(IceColorSystem.tileSpot, false),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Image.asset(
                      Assets.images.wave.path,
                      fit: BoxFit.contain,
                      color: Colors.white,
                    ),
                  ),
                ],
              )

              // spotColor: LavaColorSystem.tileSpot,
              ),
          CubeFaceTheme(
              baseColor: IceColorSystem.tileBase,
              spotPainter: LavaTilePainter(IceColorSystem.tileSpot, true),
              child: RotatedBox(
                quarterTurns: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Image.asset(
                        Assets.images.wave.path,
                        fit: BoxFit.contain,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )

              // spotColor: LavaColorSystem.tileSpot,
              ));
    },
    environment: CubeTheme.all(
      CubeFaceTheme(
        baseColor: Colors.transparent,
        child: const EnvironmentParticle(
          color: Color.fromARGB(206, 255, 255, 255),
          maxOpacity: 1.0,
        ),
      ),
    ),
  ),
);
