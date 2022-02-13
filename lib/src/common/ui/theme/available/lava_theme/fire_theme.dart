import 'package:sliding_puzzle/src/common/ui/theme/app_theme.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/painter/spot_painter.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/painter/step_painter.dart';

import 'colors.dart';

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
        spotPainter: StepPainter(
          // percentValue: 50,
          // boxHeight: 100,
          waveColor: [
            LavaColorSystem.baseColor,
            LavaColorSystem.baseGlow,
          ],
        ),
        // spotColor: const Color(0xFF5d4843),
      ),
      CubeFaceTheme(
        baseColor: LavaColorSystem.baseColor,
        spotPainter: StepPainter(
            // percentValue: 50,
            // boxHeight: 100,
            waveColor: [
              LavaColorSystem.baseColor,
              LavaColorSystem.baseGlow,
            ]),
        // spotColor: const Color(0xFF5d4843),
      ),
    ),
    tileTheme: () => CubeTheme.symetric(
        CubeFaceTheme(
          baseColor: LavaColorSystem.tileBase,
          spotPainter: SpotPainter(LavaColorSystem.tileSpot),
          // spotColor: LavaColorSystem.tileSpot,
        ),
        CubeFaceTheme(
          baseColor: LavaColorSystem.tileBase,
          spotPainter: SpotPainter(LavaColorSystem.tileSpot),
          // spotColor: LavaColorSystem.tileSpot,
        ),
        CubeFaceTheme(
          baseColor: LavaColorSystem.tileBase,
          spotPainter: SpotPainter(LavaColorSystem.tileSpot),
          // spotColor: LavaColorSystem.tileSpot,
        )),
  ),
);
