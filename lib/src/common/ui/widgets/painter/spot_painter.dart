import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:sliding_puzzle/src/common/util/number_extension.dart';

class SpotPainter {
  final Color spotColor;
  final int noOfSpots;
  SpotPainter(this.spotColor, {this.noOfSpots = 2}) {
    width = 0.2; //(Random().nextDouble() * 0.5).clamp(0.2, 0.5);
    height = 0.1; // (width * Random().nextDouble()).clamp(0.1, 0.5);
  }
  late final double width;
  late final double height;
  final List<Offset> positions = [];
  void paint(Canvas canvas, Size size, {Offset? from, Offset? to}) {
    if (noOfSpots != positions.length) {
      generateSpots(size);
    }

    for (var spot in positions) {
      var left = spot.dx * size.width;
      var top = spot.dy * size.height;
      var h = (size.height * height);
      var w = (size.width * width);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(
                (from?.dx ?? 0) + left,
                (from?.dy ?? 0) + top,
                w.clamp(w, size.width - w),
                h.clamp(h, size.height - h),
              ),
              const Radius.circular(10)),
          Paint()..color = spotColor);
    }
  }

  void generateSpots(Size size) {
    var random = Random();

    while (noOfSpots != positions.length) {
      final dx = random.nextDouble().map(
            0.0,
            1.0,
            positions.length - 1 / noOfSpots,
            positions.length / noOfSpots,
          );
      final dy = random.nextDouble();
      // .map(
      //       0.0,
      //       1.0,
      //       positions.length - 1 / noOfSpots,
      //       positions.length / noOfSpots,
      //     );

      positions.add(
          Offset(dx.clamp(width, 1 - width), dy.clamp(height, 1 - height)));
    }
  }
}
