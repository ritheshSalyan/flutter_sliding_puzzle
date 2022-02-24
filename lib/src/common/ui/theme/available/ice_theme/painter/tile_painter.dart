import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/painter/gradient_painter.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/painter/spot_painter.dart';

import '../colors.dart';

class LavaTilePainter extends CustomPainter {
  late final SpotPainter spotPainter;
  late final SpotPainter basePatchPainter;
  late final GradientPainter gradientPainter;
  bool isVertical;
  LavaTilePainter(Color spotColor, this.isVertical) {
    spotPainter = SpotPainter(IceColorSystem.tileBase, noOfSpots: 4);
    basePatchPainter = SpotPainter(Colors.white, noOfSpots: 4);
    gradientPainter = GradientPainter(
      colors: [
        Colors.white,
        Colors.white,
        IceColorSystem.tileBase.withOpacity(0.5),
      ],
      stpes: [
        0.0,
        0.3,
        0.35,
      ],
    );
  }
  @override
  void paint(Canvas canvas, Size size) {
    // gradientPainter.paint(canvas, size, topToBottom: !isVertical);

    spotPainter.paint(
        canvas,
        Size(!isVertical ? size.width : size.width / 2,
            !isVertical ? size.height / 2 : size.height),
        from: Offset(!isVertical ? 0 : size.width / 2,
            !isVertical ? size.height / 2 : 0));
    basePatchPainter.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
