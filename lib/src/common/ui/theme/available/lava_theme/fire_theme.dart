import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/common/ui/theme/app_theme.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/jungle_theme/widgets/particles.dart';

import 'colors.dart';
import 'painter/base_painter.dart';
import 'painter/tile_painter.dart';

AppTheme fireTheme = AppTheme(
  backgroundColor: LavaColorSystem.background,
  boardTheme: BoardTheme(
    baseTheme: CubeTheme.symetric(
      CubeFaceTheme(
        baseColor: LavaColorSystem.baseColor, //LavaColorSystem.baseColor,
        // spotPainter: WavePainter(
        //   // percentValue: 50,
        //   // boxHeight: 100,
        //   waveColor: const Color(0xFF5d4843),
        // ),
        // spotColor: const Color(0xFF5d4843),
      ),
      CubeFaceTheme(
        baseColor: LavaColorSystem.baseColor,
        spotPainter: LavaBasePainter(true
            // percentValue: 50,
            // boxHeight: 100,

            ),
        // spotColor: const Color(0xFF5d4843),
      ),
      CubeFaceTheme(
        baseColor: LavaColorSystem.baseColor,
        spotPainter: LavaBasePainter(false
            // percentValue: 50,
            // boxHeight: 100,
            ),
        // spotColor: const Color(0xFF5d4843),
      ),
    ),
    tileTheme: () => CubeTheme.symetric(
        CubeFaceTheme(
          baseColor: LavaColorSystem.tileBase,
          spotPainter: LavaTilePainter(LavaColorSystem.tileSpot),
          // spotColor: LavaColorSystem.tileSpot,
        ),
        CubeFaceTheme(
          baseColor: LavaColorSystem.tileBase,
          spotPainter: LavaTilePainter(LavaColorSystem.tileSpot),
          // spotColor: LavaColorSystem.tileSpot,
        ),
        CubeFaceTheme(
          baseColor: LavaColorSystem.tileBase,
          spotPainter: LavaTilePainter(LavaColorSystem.tileSpot),
          // spotColor: LavaColorSystem.tileSpot,
        )),
    environment: CubeTheme.all(CubeFaceTheme(
        baseColor: Colors.transparent, child: const EnvironmentParticle())),
  ),
);
