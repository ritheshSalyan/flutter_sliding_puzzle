import 'package:flutter/cupertino.dart';

class AppTheme {
  final Color backgroundColor;
  final BoardTheme boardTheme;

  AppTheme({
    required this.backgroundColor,
    required this.boardTheme,
  });
}

class BoardTheme {
  final CubeTheme baseTheme;
  final CubeTheme tileTheme;

  BoardTheme({required this.baseTheme, required this.tileTheme});
}

class CubeTheme {
  final CubeFaceTheme top;
  final CubeFaceTheme left;
  final CubeFaceTheme right;
  final CubeFaceTheme up;
  final CubeFaceTheme down;

  CubeTheme({
    required this.top,
    required this.left,
    required this.right,
    required this.up,
    required this.down,
  });

  factory CubeTheme.all(CubeFaceTheme faceTheme) {
    return CubeTheme(
        top: faceTheme,
        left: faceTheme,
        right: faceTheme,
        up: faceTheme,
        down: faceTheme);
  }

  factory CubeTheme.symetric(
      CubeFaceTheme top, CubeFaceTheme vertical, CubeFaceTheme horizontal) {
    return CubeTheme(
        top: top,
        left: horizontal,
        right: horizontal,
        up: vertical,
        down: vertical);
  }
}

class CubeFaceTheme {
  final Color baseColor;
  final CustomPainter? spotPainter;

  CubeFaceTheme({required this.baseColor, this.spotPainter});
}
