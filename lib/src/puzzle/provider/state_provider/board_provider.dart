import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/keyboard/keyboard_controller.dart';
import 'package:sliding_puzzle/src/puzzle/provider/state_provider/tile_state.dart';

import '../../puzzle.dart';
import '../board_controller.dart';
import '../input/gyro/gyro_controller.dart';
import '../observer/state_tracker.dart';

enum PageMode {
  ar,
  widget,
}

class BoardUIController extends ChangeNotifier
    with StackTracker<PuzzleBoard>, KeyboardController, GyroController {
  final Ref _ref;
  BoardUIController(
    this._ref,
  ) {
    initializeGyro();
    shuffle();
  }

  static final provider = ChangeNotifierProvider<BoardUIController>((ref) {
    return BoardUIController(ref);
  });
  final BoardRotationController boardRotationController =
      BoardRotationController();
  PageMode _mode = PageMode.widget;

  PageMode get mode => _mode;

  void changeMode(PageMode mode) {
    _mode = mode;
  }

  void shuffle() {
    _ref.refresh(BoardLogicController.provider);
    isCompleted = boardController.isComplete();
    clearStack();
    notifyListeners();
    _playStartAnimation();
  }

  void _playStartAnimation() {
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      for (var tile in boardController.tiles) {
        _ref
            .read(TileStateNotifier.provider(tile.correctPos).notifier)
            .startAnimation(tile.currentPos);
      }
    });
  }

  void moveTile(Tile tile) {
    if (isCompleted) return;
    saveState(_ref.read(BoardLogicController.provider));
    final previousPos = tile.currentPos;
    final camMove =
        _ref.read(BoardLogicController.provider.notifier).moveTile(tile);
    if (camMove) {
      final newTile = _ref
          .read(BoardLogicController.provider)
          .tiles
          .firstWhere((element) => element.correctPos == tile.correctPos);
      _ref
          .read(TileStateNotifier.provider(tile.correctPos).notifier)
          .changeState(newTile.currentPos, previousPos);
      bool completed = boardController.isComplete();
      isCompleted = completed;
      notifyListeners();
      if (completed) {
        triggerEndAnimation();
      }
    }
  }

  void triggerEndAnimation() {
    for (var tile in boardController.tiles) {
      _ref
          .read(TileStateNotifier.provider(tile.correctPos).notifier)
          .endAnimation(boardController.tiles.length);
    }
  }

  bool isCompleted = false;

  BoardLogicController get boardController =>
      _ref.read(BoardLogicController.provider.notifier);

  @override
  void moveUp() {
    var moveUp = boardController.getMoveUpTile();
    if (moveUp != null) moveTile(moveUp);
  }

  @override
  void moveDown() {
    var tile = boardController.getMoveDownTile();
    if (tile != null) {
      moveTile(tile);
    }
  }

  @override
  void moveLeft() {
    var tile = boardController.getMoveLeftTile();
    if (tile != null) {
      moveTile(tile);
    }
  }

  @override
  void moveRight() {
    var tile = boardController.getMoveRightTile();
    if (tile != null) {
      moveTile(tile);
    }
  }

  void rotateBoardBy(Offset offset) {
    boardRotationController.rotateBy(offset);
  }

  void rotateBoardTo(Offset offset) {
    boardRotationController.rotateTo(offset);
  }

  void resetRotation() {
    boardRotationController.reset();
  }

  final _sensitivity = 0.5;

  @override
  void onGyroChange(Offset offset) {
    if ((offset.dx.abs() == 0 && offset.dy.abs() == 0) || mode == PageMode.ar) {
      return;
    }
    // log("Gyro Event: $offset ");
    rotateBoardBy(
        Offset(offset.dx * _sensitivity * 1, offset.dy * _sensitivity * 1));
  }

  @override
  void dispose() {
    super.dispose();
    cancelGyro();
  }
}
