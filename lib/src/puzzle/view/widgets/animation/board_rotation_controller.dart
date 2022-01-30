import 'package:flutter/cupertino.dart';

class BoardRotationController {
  final ValueNotifier<Offset> boardAngle = ValueNotifier(Offset.zero);
  Offset _previousValue = Offset.zero;
  Offset get previousValue => _previousValue;
  void rotateBy(Offset offset) {
    double x = 0;
    double y = 0;
    Offset currentAngle = boardAngle.value;
    if ((currentAngle.dx + offset.dx < 21) &&
        (currentAngle.dx + offset.dx > -21)) {
      x = offset.dx;
    }
    if ((currentAngle.dy + offset.dy < 21) &&
        (currentAngle.dy + offset.dy > -21)) {
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
