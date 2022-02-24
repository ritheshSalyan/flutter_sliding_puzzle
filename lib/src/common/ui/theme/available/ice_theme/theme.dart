import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/common/ui/theme/app_theme.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/jungle_theme/widgets/particles.dart';

import 'colors.dart';
import 'painter/base_painter.dart';
import 'painter/tile_painter.dart';

AppTheme iceTheme = AppTheme(
  backgroundColor: IceColorSystem.background,
  foregroundColor: IceColorSystem.accentColor,
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
            "assets/images/wave.png",
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
              "assets/images/wave.png",
              fit: BoxFit.fill,
              color: Colors.white,
            ),
          )
          // spotColor: const Color(0xFF5d4843),
          ),
    ),
    tileTheme: () => CubeTheme.symetric(
        CubeFaceTheme(
            baseColor: IceColorSystem.tileBase,
            // spotPainter: LavaTilePainter(LavaColorSystem.tileSpot, false),
            child: Container(
              child: const Center(),
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
                    "assets/images/wave.png",
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
                      "assets/images/wave.png",
                      fit: BoxFit.contain,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )

            // spotColor: LavaColorSystem.tileSpot,
            )),
    environment: CubeTheme.all(CubeFaceTheme(
        baseColor: Colors.transparent,
        child: const EnvironmentParticle(
          color: Colors.white,
          maxOpacity: 1.0,
        ))),
  ),
);
