import 'package:flutter/cupertino.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/painter/spot_painter.dart';

class LavaTilePainter extends CustomPainter {
  late final SpotPainter spotPainter;
  LavaTilePainter(Color spotColor) {
    spotPainter = SpotPainter(spotColor);
  }
  @override
  void paint(Canvas canvas, Size size) {
    spotPainter.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
