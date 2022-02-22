import 'package:flutter/cupertino.dart';

class BoardRotationController {
  final ValueNotifier<Offset> boardAngle =
      ValueNotifier(const Offset(-0.2, -0.2));
  Offset _previousValue = const Offset(-0.2, -0.2);
  Offset get previousValue => _previousValue;

  static const minAngle = Offset(-0.75, -0.75);
  static const maxAngle = Offset(0.75, 0.75);

  void rotateBy(Offset offset) {
    double x = offset.dx;
    double y = offset.dy;
    boardAngle.value += Offset(x, y);
  }

  void rotateTo(Offset offset) {
    double x = offset.dx;
    double y = offset.dy;
    boardAngle.value = Offset(x, y);
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
