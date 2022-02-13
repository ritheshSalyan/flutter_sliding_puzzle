import 'package:sliding_puzzle/src/common/ui/theme/available/jungle_theme/colos.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/jungle_theme/painter/tile_side_painter.dart';

import '../../app_theme.dart';
import 'painter/base_side_painter.dart';
import 'painter/base_top_painter.dart';
import 'painter/tile_top_painter.dart';

AppTheme jungleTheme = AppTheme(
  backgroundColor: JungleColorSystem.backgroundColor,
  boardTheme: BoardTheme(
    baseTheme: CubeTheme.symetric(
      CubeFaceTheme(
        baseColor: JungleColorSystem.baseGreen, //LavaColorSystem.baseColor,
        spotPainter: JungleBaseTopPainter(),
        // spotPainter: WavePainter(
        //   // percentValue: 50,
        //   // boxHeight: 100,
        //   waveColor: const Color(0xFF5d4843),
        // ),
        // spotColor: const Color(0xFF5d4843),
      ),
      CubeFaceTheme(
        baseColor: JungleColorSystem.baseGreen,
        spotPainter: JungleBaseSidePainter(),
        // spotPainter: LavaBasePainter(
        //     // percentValue: 50,
        //     // boxHeight: 100,

        //     ),
        // spotColor: const Color(0xFF5d4843),
      ),
      CubeFaceTheme(
        baseColor: JungleColorSystem.baseGreen,
        spotPainter: JungleBaseSidePainter(),

        // spotPainter: LavaBasePainter(
        //     // percentValue: 50,
        //     // boxHeight: 100,
        //     ),
        // spotColor: const Color(0xFF5d4843),
      ),
    ),
    tileTheme: () => CubeTheme.symetric(
        CubeFaceTheme(
            baseColor: JungleColorSystem.tileGreen,
            spotPainter: JungleTileTopPainter()
            // spotPainter: LavaTilePainter(LavaColorSystem.tileSpot),
            // spotColor: LavaColorSystem.tileSpot,
            ),
        CubeFaceTheme(
          baseColor: JungleColorSystem.tileGreen,
          spotPainter: JungleTileSidePainter(),
          // spotColor: JungleColorSystem.baseGreen,
        ),
        CubeFaceTheme(
          baseColor: JungleColorSystem.tileGreen,
          spotPainter: JungleTileSidePainter(),
          // spotColor: LavaColorSystem.tileSpot,
        )),
  ),
);
