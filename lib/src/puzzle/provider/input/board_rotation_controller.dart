import 'package:flutter/cupertino.dart';

class BoardRotationController {
  final ValueNotifier<Offset> boardAngle =
      ValueNotifier(const Offset(-20, -20));
  Offset _previousValue = const Offset(-20, -20);
  Offset get previousValue => _previousValue;

  static const minAngle = Offset(-50.0, -50.0);
  static const maxAngle = Offset(50.0, 50.0);

  void rotateBy(Offset offset) {
    double x = offset.dx;
    double y = offset.dy;
    boardAngle.value += Offset(x, y);
  }

  void rotateX(double x) {
    rotateBy(Offset(x, 0));
  }

  void rotateY(double y) {
    rotateBy(Offset(0, y));
  }

  void reset() {
    boardAngle.value = Offset.zero;
  }

  void updatePrevious(Offset value) {
    _previousValue = value;
  }
}
