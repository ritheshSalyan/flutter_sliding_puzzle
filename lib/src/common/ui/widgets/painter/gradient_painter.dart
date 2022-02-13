import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class GradientPainter {
  final List<Color> colors;
  final List<double>? stpes;
  GradientPainter({
    required this.colors,
    this.stpes,
  });
  void paint(
    Canvas canvas,
    Size size, {
    bool leftToRight = false,
  }) {
    var isInverse = //false;
        leftToRight; // ? (size.width >= size.height) : (size.width <= size.height);
    Size newSize = size; //Size(size.shortestSide, size.longestSide);
    Paint wavePaint = Paint()
      ..shader = ui.Gradient.linear(
          isInverse
              ? newSize.bottomCenter(Offset.zero)
              : newSize.centerRight(Offset.zero),
          isInverse
              ? newSize.topCenter(Offset.zero)
              : newSize.centerLeft(Offset.zero),
          colors,
          stpes);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), wavePaint);
  }
}
