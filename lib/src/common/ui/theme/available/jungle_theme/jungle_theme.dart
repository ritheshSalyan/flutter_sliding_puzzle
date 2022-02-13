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
    tileTheme: () => CubeTheme.symetric(
        CubeFaceTheme(
            baseColor: JungleColorSystem.tileGreen,
            spotPainter: JungleTileTopPainter()),
        CubeFaceTheme(
          baseColor: JungleColorSystem.tileGreen,
          spotPainter: JungleTileSidePainter(true),
        ),
        CubeFaceTheme(
          baseColor: JungleColorSystem.tileGreen,
          spotPainter: JungleTileSidePainter(false),
        )),
  ),
);
