import 'package:flutter/cupertino.dart';
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
      : super(TileState(initialPosition));

  void changeState(TileState state) {
    this.state = state;
  }

  void onCompleteAnimation() {
    state = TileState(state.currentPosition);
  }
}

class TileState {
  final BoardPosition currentPosition;
  late final BoardPosition previousPosition;
  TileState(this.currentPosition, {BoardPosition? previousPosition}) {
    this.previousPosition = previousPosition ?? currentPosition;
  }
}

// class IdleTileState extends TileState {
//   @override
//   BoardPosition get currentPosition => BoardPosition(1, 1);

//   IdleTileState();
// }

// abstract class TileMovementState extends TileState {
//   Offset get position;
// }
