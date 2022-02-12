import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/model/model.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_controller.dart';

class TileStateNotifier extends StateNotifier<TileState> {
  static final provider =
      StateNotifierProvider.family<TileStateNotifier, TileState, BoardPosition>(
          (ref, position) {
    return TileStateNotifier(ref
        .watch(BoardLogicController.provider)
        .tiles
        .firstWhere((tile) => tile.correctPos == position)
        .currentPos);
  });

  TileStateNotifier(BoardPosition initialPosition)
      : super(TileIdleState(initialPosition));

  void changeState(
      BoardPosition currentPosition, BoardPosition previousPosition) {
    state = TileMovementState(currentPosition, previousPosition);
  }

  void startAnimation(BoardPosition currentPosition) {
    state =  StartTileState(currentPosition);
  }

  void onCompleteAnimation() {
    state = TileIdleState(state.currentPosition);
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
