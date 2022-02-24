import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/theme/app_theme.dart';
import 'package:sliding_puzzle/src/common/ui/theme/theme_provider.dart';
import 'package:sliding_puzzle/src/puzzle/model/model.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_controller.dart';

class TileStateNotifier extends ChangeNotifier {
  static final provider =
      ChangeNotifierProvider.family<TileStateNotifier, BoardPosition>(
          (ref, position) {
    return TileStateNotifier(
      ref
          .read(BoardLogicController.provider)
          .tiles
          .firstWhere((tile) => tile.correctPos == position)
          .currentPos,
      ref.watch(ThemeNotifier.provider).boardTheme.tileTheme.call(),
    );
  });
  final CubeTheme style;
  TileStateNotifier(BoardPosition initialPosition, this.style)
      : state = TileIdleState(initialPosition);
  TileState state;
  void changeState(
      BoardPosition currentPosition, BoardPosition previousPosition) {
    state = TileMovementState(currentPosition, previousPosition);
    notifyListeners();
  }

  void startAnimation(BoardPosition currentPosition) {
    state = StartTileState(currentPosition);
    notifyListeners();
  }

  void endAnimation(int noOftiles) {
    state = CompleteProgressTileState(state.currentPosition, noOftiles);
    notifyListeners();
  }

  void onCompleteAnimation() {
    if (state is CompleteProgressTileState) {
      state = CompleteTileState(state.currentPosition,
          (state as CompleteProgressTileState).noOfTiles);
    } else {
      state = TileIdleState(state.currentPosition);
    }
    notifyListeners();
  }

  void completeEndAnimation() {
    if (state is! CompleteProgressTileState) return;
    state = CompleteTileState(
        state.currentPosition, (state as CompleteProgressTileState).noOfTiles);
    notifyListeners();
  }
}

abstract class TileState with AnimationProgressMixin {
  final BoardPosition currentPosition;

  TileState(
    this.currentPosition,
  );
}

class TileIdleState extends TileState {
  TileIdleState(BoardPosition currentPosition) : super(currentPosition);
}

class StartTileState extends TileState with AnimationProgressMixin {
  StartTileState(BoardPosition currentPosition) : super(currentPosition);
}

class TileMovementState extends TileState with AnimationProgressMixin {
  final BoardPosition previousPosition;

  TileMovementState(BoardPosition currentPosition, this.previousPosition)
      : super(currentPosition);
}

class CompleteProgressTileState extends TileState with AnimationProgressMixin {
  final int noOfTiles;

  CompleteProgressTileState(BoardPosition currentPosition, this.noOfTiles)
      : super(currentPosition);
}

class CompleteTileState extends TileState {
  final int noOfTiles;
  CompleteTileState(BoardPosition currentPosition, this.noOfTiles)
      : super(currentPosition);
}

mixin AnimationProgressMixin {
  double progress = 0;
  void updateProgress(double value) {
    progress = value;
  }
}
