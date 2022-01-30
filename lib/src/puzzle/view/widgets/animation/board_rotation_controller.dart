import 'package:flutter/cupertino.dart';

class BoardRotationController {
  final ValueNotifier<Offset> boardAngle = ValueNotifier(Offset.zero);
  Offset _previousValue = Offset.zero;
  Offset get previousValue => _previousValue;

  final minAngle = -25.0;
  final maxAngle = 25.0;
  void rotateBy(Offset offset) {
    double x = 0;
    double y = 0;
    Offset currentAngle = boardAngle.value;
    if ((currentAngle.dx + offset.dx < maxAngle) &&
        (currentAngle.dx + offset.dx > minAngle)) {
      x = offset.dx;
    }
    if ((currentAngle.dy + offset.dy < maxAngle) &&
        (currentAngle.dy + offset.dy > minAngle)) {
      y = offset.dy;
    }
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
