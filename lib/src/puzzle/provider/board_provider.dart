import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/animation/custom_animation_controller.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/keyboard/keyboard_controller.dart';
import 'package:sliding_puzzle/src/puzzle/provider/tile_state.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/animation/board_rotation_controller.dart';

import '../puzzle.dart';
import 'board_controller.dart';
import 'input/gyro/gyro_controller.dart';
import 'observer/state_tracker.dart';

class BoardUIController extends ChangeNotifier
    with StackTracker<PuzzleBoard>, KeyboardController, GyroController {
  final Ref _ref;
  BoardUIController(
    this._ref,
  ) {
    initializeGyro();
  }

  static final provider = ChangeNotifierProvider<BoardUIController>((ref) {
    return BoardUIController(ref);
  });
  late AnimationControllers animationControllers;
  final BoardRotationController boardRotationController =
      BoardRotationController();
  void createAnimationControllers(TickerProvider vsync) {
    // animationControllers = AnimationControllers.create(vsync);
  }

  void shuffle() {
    _ref.refresh(BoardLogicController.provider);
  }

  void moveTile(Tile tile) {
    saveState(_ref.read(BoardLogicController.provider));
    final previousPos = tile.currentPos;
    final camMove =
        _ref.read(BoardLogicController.provider.notifier).moveTile(tile);
    if (camMove) {
      final newTile = _ref
          .read(BoardLogicController.provider)
          .tiles
          .firstWhere((element) => element.correctPos == tile.correctPos);
      _ref.read(TileStateNotifier.provider(tile.correctPos).notifier).state =
          TileState(newTile.currentPos, previousPosition: previousPos);
    }
  }

  BoardLogicController get boardController =>
      _ref.read(BoardLogicController.provider.notifier);

  @override
  void moveUp() {
    var moveUp = boardController.moveUp();
    if (moveUp != null) moveTile(moveUp);
  }

  @override
  void moveDown() {
    var tile = boardController.moveDown();
    if (tile != null) {
      moveTile(tile);
    }
  }

  @override
  void moveLeft() {
    var tile = boardController.moveLeft();
    if (tile != null) {
      moveTile(tile);
    }
  }

  @override
  void moveRight() {
    var tile = boardController.moveRight();
    if (tile != null) {
      moveTile(tile);
    }
  }

  void rotateBoardBy(Offset offset) {
    boardRotationController.rotateBy(offset);
  }

  void resetRotation() {
    boardRotationController.reset();
  }

  final _sensitivity = 10.0;

  @override
  void onGyroChange(Offset offset) {
    if (offset.dx.abs() == 0 && offset.dy.abs() == 0) return;
    // log("Gyro Event: $offset ");
    rotateBoardBy(offset * -10);
  }

  @override
  void dispose() {
    super.dispose();
    cancelGyro();
    animationControllers.idelTilesController.animationController.dispose();
  }
}
