import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/painter/spot_painter.dart';

import '../colos.dart';

class JungleBaseTopPainter extends CustomPainter {
  final SpotPainter mudSpot = SpotPainter(
    JungleColorSystem.mudLight,
  );
  final SpotPainter greenPath = SpotPainter(
    JungleColorSystem.tileGreen,
  );
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
  bool shouldRepaint(JungleBaseTopPainter oldDelegate) => false;
}
