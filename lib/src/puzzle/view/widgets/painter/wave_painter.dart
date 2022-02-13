import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  double percentValue;
  double boxHeight;
  Color waveColor;

  WavePainter(
      {required this.percentValue,
      required this.boxHeight,
      required this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    double width = (size.width > size.height) ? size.width : size.height;
    double height = (size.height > size.width) ? size.height : size.width;

    Paint wavePaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(width / 2, 0),
        Offset(width / 2, height),
        [
          Colors.blueAccent,
          Colors.redAccent,
        ],
      );
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
