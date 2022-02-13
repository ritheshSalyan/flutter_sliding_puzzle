import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class StepPainter extends CustomPainter {
  final List<Color> waveColor;

  StepPainter({required this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    var isInverse = (size.width > size.height);
    double width = size.width;
    double height = size.height;
    final newSize = Size(size.longestSide, size.shortestSide);
    Paint wavePaint = Paint()
      ..shader = ui.Gradient.linear(
          isInverse
              ? size.bottomCenter(Offset.zero)
              : size.centerRight(Offset.zero),
          isInverse
              ? size.topCenter(Offset.zero)
              : size.centerLeft(Offset.zero),
          waveColor,
          // [
          //   Colors.brown[900]!,
          //   Colors.brown,
          // ],
          [0.5, 0.5]);
    // const waveDepth = 0.7;

    // double _percent = percentValue / 100.0;

    // Path path = Path();
    // path.moveTo(0.0, _baseHeight);
    // for (double i = 0.0; i < width; i++) {
    //   path.lineTo(i,
    //       _baseHeight + sin((i / width * 2 * pi) + (waveDepth * 2 * pi)) * 8);
    // }

    // path.lineTo(width, height);
    // path.lineTo(0.0, height);
    // path.close();
    // canvas.drawPath(path, wavePaint);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
