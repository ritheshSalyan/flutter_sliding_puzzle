import 'dart:math';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  Animation<double> waveAnimation;
  double percentValue;
  double boxHeight;
  Color waveColor;

  WavePainter(
      {required this.waveAnimation, required this.percentValue, required this.boxHeight, required this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    double width = (size.width != null) ? size.width : 200;
    double height = (size.height != null) ? size.height : 200;

    Paint wavePaint = Paint()..color = waveColor;



    double _percent = percentValue / 100.0;
    double _baseHeight =
        (boxHeight / 2);// + (_textHeight / 2) - (_percent * _textHeight);

    Path path = Path();
    path.moveTo(0.0, _baseHeight);
    for (double i = 0.0; i < width; i++) {
      path.lineTo(
          i,
          _baseHeight +
              sin((i / width * 2 * pi) + (waveAnimation.value * 2 * pi)) * 8);
    }

    path.lineTo(width, height);
    path.lineTo(0.0, height);
    path.close();
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}