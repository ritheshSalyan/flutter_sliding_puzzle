import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/gyro/gyro_controller.dart';

class HomePageViewModel extends ChangeNotifier with GyroController {
  static final provider = ChangeNotifierProvider<HomePageViewModel>((ref) {
    return HomePageViewModel();
  });
  HomePageViewModel() {
    initializeGyro();
  }
  BoardRotationController boardRotationController = BoardRotationController();

  final _sensitivity = 0.5;

  @override
  void onGyroChange(Offset offset) {
    if ((offset.dx.abs() == 0 && offset.dy.abs() == 0)) {
      return;
    }
    // log("Gyro Event: $offset ");
    boardRotationController.rotateBy(
        Offset(offset.dx * _sensitivity * 1, offset.dy * _sensitivity * 1));
  }
}
