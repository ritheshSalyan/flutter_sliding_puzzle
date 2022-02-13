import 'package:flutter/cupertino.dart';
import 'package:sliding_puzzle/src/common/ui/theme/app_theme.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/painter/spot_painter.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/painter/wave_painter.dart';

AppTheme fireTheme = AppTheme(
    backgroundColor: const Color(0xFF4f1611),
    boardTheme: BoardTheme(
      baseTheme: CubeTheme.symetric(
        CubeFaceTheme(
          baseColor: const Color(0xFF8a2c0d),
          spotPainter: SpotPainter(const Color(0xFF5d4843)),
          // spotColor: const Color(0xFF5d4843),
        ),
        CubeFaceTheme(
          baseColor: const Color(0xFF8a2c0d),
          spotPainter: WavePainter(
              percentValue: 50,
              boxHeight: 100,
              waveColor: const Color(0xFF5d4843)),
          // spotColor: const Color(0xFF5d4843),
        ),
        CubeFaceTheme(
          baseColor: const Color(0xFF8a2c0d),
          spotPainter: WavePainter(
              percentValue: 50,
              boxHeight: 100,
              waveColor: const Color(0xFF5d4843)),
          // spotColor: const Color(0xFF5d4843),
        ),
      ),
      tileTheme: CubeTheme.symetric(
          CubeFaceTheme(
            baseColor: const Color(0xFF97857d),
            // spotPainter: SpotPainter(const Color(0xFF5d4843)),
            // spotColor: const Color(0xFF5d4843),
          ),
          CubeFaceTheme(
            baseColor: const Color(0xFF97857d),
            spotPainter: SpotPainter(const Color(0xFF5d4843)),
            // spotColor: const Color(0xFF5d4843),
          ),
          CubeFaceTheme(
            baseColor: const Color(0xFF97857d),
            spotPainter: SpotPainter(const Color(0xFF5d4843)),
            // spotColor: const Color(0xFF5d4843),
          )),
    ));
