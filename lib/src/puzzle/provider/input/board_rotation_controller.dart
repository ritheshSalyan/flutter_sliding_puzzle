import 'package:flutter/cupertino.dart';

class BoardRotationController {
  final ValueNotifier<Offset> boardAngle = ValueNotifier(Offset.zero);
  Offset _previousValue = const Offset(10, 10);
  Offset get previousValue => _previousValue;

  static const minAngle = -50.0;
  static const maxAngle = 50.0;
  void rotateBy(Offset offset) {
    double x = offset.dx; // 0;
    double y = offset.dy; //0;
    // Offset currentAngle = boardAngle.value;
    // if ((currentAngle.dx + offset.dx < maxAngle) &&
    //     (currentAngle.dx + offset.dx > minAngle)) {
    //   x = offset.dx;
    // }
    // if ((currentAngle.dy + offset.dy < maxAngle) &&
    //     (currentAngle.dy + offset.dy > minAngle)) {
    //   y = offset.dy;
    // }
    _previousValue = boardAngle.value;
    boardAngle.value += Offset(x, y);
  }

  void rotateX(double x) {
    rotateBy(Offset(x, 0));
  }

  void rotateY(double y) {
    rotateBy(Offset(0, y));
  }

  void reset() {
    _previousValue = boardAngle.value;

    boardAngle.value = Offset.zero;
  }
}
