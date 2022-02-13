import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class GradientPainter {
  final List<Color> colors;
  final List<double>? stpes;
  bool leftToRight;
  GradientPainter({
    required this.colors,
    this.stpes,
    this.leftToRight = true,
  });
  void paint(Canvas canvas, Size size) {
    var isInverse =
        leftToRight ? (size.width >= size.height) : (size.width < size.height);
    Paint wavePaint = Paint()
      ..shader = ui.Gradient.linear(
          isInverse
              ? size.bottomCenter(Offset.zero)
              : size.centerRight(Offset.zero),
          isInverse
              ? size.topCenter(Offset.zero)
              : size.centerLeft(Offset.zero),
          colors,
          stpes);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), wavePaint);
  }
}
