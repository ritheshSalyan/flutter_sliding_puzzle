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

  void onCompleteAnimation() {
    state = TileIdleState(state.currentPosition);
    notifyListeners();
  }
}

abstract class TileState {
  final BoardPosition currentPosition;

  TileState(
    this.currentPosition,
  );
}

class TileIdleState extends TileState {
  TileIdleState(BoardPosition currentPosition) : super(currentPosition);
}

class StartTileState extends TileState {
  StartTileState(BoardPosition currentPosition) : super(currentPosition);
}

class TileMovementState extends TileState {
  final BoardPosition previousPosition;

  TileMovementState(BoardPosition currentPosition, this.previousPosition)
      : super(currentPosition);
}
