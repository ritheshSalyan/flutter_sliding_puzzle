import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/animation/custom_animation_controller.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/keyboard/keyboard_controller.dart';

import '../puzzle.dart';
import 'board_controller.dart';
import 'observer/state_tracker.dart';

class BoardUIController extends ChangeNotifier
    with StackTracker<PuzzleBoard>, KeyboardController {
  final Ref _ref;
  BoardUIController(
    this._ref,
  );

  static final provider = ChangeNotifierProvider<BoardUIController>((ref) {
    return BoardUIController(ref);
  });
  late AnimationControllers animationControllers;

  void createAnimationControllers(TickerProvider vsync) {
    animationControllers = AnimationControllers.create(vsync);
  }

  void shuffle() {
    _ref.refresh(BoardLogicController.provider);
  }

  void moveTile(Tile tile) {
    saveState(_ref.read(BoardLogicController.provider));
    _ref.read(BoardLogicController.provider.notifier).moveTile(tile);
  }

  BoardLogicController get boardController =>
      _ref.read(BoardLogicController.provider.notifier);

  @override
  void moveUp() {
    boardController.moveUp();
  }

  @override
  void moveDown() {
    boardController.moveDown();
  }

  @override
  void moveLeft() {
    boardController.moveLeft();
  }

  @override
  void moveRight() {
    boardController.moveRight();
  }
}
