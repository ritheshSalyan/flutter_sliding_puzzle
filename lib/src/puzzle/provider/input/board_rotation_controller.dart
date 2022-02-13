import 'package:flutter/cupertino.dart';

class BoardRotationController {
  final ValueNotifier<Offset> boardAngle =
      ValueNotifier(const Offset(-20, -20));
  Offset _previousValue = const Offset(-20, -20);
  Offset get previousValue => _previousValue;

  static const minAngle = Offset(-50.0, -50.0);
  static const maxAngle = Offset(50.0, 50.0);

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

  void updatePrevious(Offset value) {
    _previousValue = value;
  }
}
