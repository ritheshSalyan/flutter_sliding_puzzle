import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/painter/gradient_painter.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/painter/spot_painter.dart';

import '../colos.dart';

class JungleBaseSidePainter extends CustomPainter {
  final SpotPainter mudSpot = SpotPainter(
    JungleColorSystem.mudLight,
  );
  final SpotPainter greenPath = SpotPainter(
    JungleColorSystem.baseGreen,
  );
  final GradientPainter gradientPainter = GradientPainter(
    colors: [
      JungleColorSystem.baseGreen,
      JungleColorSystem.mudLight,
      JungleColorSystem.mudLight,
      JungleColorSystem.mudDark,
    ],
    stpes: [
      0.25,
      0.25,
      0.75,
      0.75,
    ],
  );

  final bool isVertical;
  JungleBaseSidePainter(this.isVertical);
  @override
  void paint(Canvas canvas, Size size) {
    gradientPainter.paint(canvas, size, topToBottom: isVertical);
    mudSpot.paint(canvas, size * 0.75);
    canvas.save();

    canvas.translate(0, size.height * 0.25);
    greenPath.paint(canvas, size * 0.75);
    canvas.restore();
  }

  @override
  bool shouldRepaint(JungleBaseSidePainter oldDelegate) => false;
}
