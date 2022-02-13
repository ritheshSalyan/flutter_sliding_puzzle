import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/jungle_theme/colos.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/painter/spot_painter.dart';

class JungleTileTopPainter extends CustomPainter {
  late final SpotPainter mudSpot;
  late final SpotPainter greenPath;

  JungleTileTopPainter() {
    greenPath = SpotPainter(
      JungleColorSystem.baseGreen,
      noOfSpots: Random().nextInt(3),
    );
    mudSpot = SpotPainter(
      JungleColorSystem.mudLight,
      noOfSpots: 1 + Random().nextInt(3),
    );
  }
  // final GradientPainter gradientPainter = GradientPainter(colors: [
  //   JungleColorSystem.tileGreen,
  //   JungleColorSystem.mudLight,
  //   JungleColorSystem.mudLight,
  //   JungleColorSystem.mudDark,
  // ], stpes: [
  //   0.25,
  //   0.25,
  //   0.75,
  //   0.75,
  // ], leftToRight: false);
  @override
  void paint(Canvas canvas, Size size) {
    // gradientPainter.paint(canvas, size);
    mudSpot.paint(canvas, size * 0.75);
    // canvas.save();

    // canvas.translate(0, size.height * 0.25);
    greenPath.paint(canvas, size);
    // canvas.restore();
  }

  @override
  bool shouldRepaint(JungleTileTopPainter oldDelegate) => true;
}
