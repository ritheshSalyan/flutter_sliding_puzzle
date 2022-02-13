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
    bool topToBottom = false,
  }) {
    Paint wavePaint = Paint()
      ..shader = ui.Gradient.linear(
          topToBottom
              ? size.bottomCenter(Offset.zero)
              : size.centerRight(Offset.zero),
          topToBottom
              ? size.topCenter(Offset.zero)
              : size.centerLeft(Offset.zero),
          colors,
          stpes);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), wavePaint);
  }
}
