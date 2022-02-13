import 'package:flutter/cupertino.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/painter/gradient_painter.dart';

import '../colors.dart';

class LavaBasePainter extends CustomPainter {
  late final GradientPainter gradientPainter;
  LavaBasePainter() {
    gradientPainter = GradientPainter(colors: [
      LavaColorSystem.baseColor,
      LavaColorSystem.baseGlow,
    ], stpes: [
      0.5,
      0.5
    ]);
  }

  @override
  void paint(Canvas canvas, Size size) {
    gradientPainter.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
