// import 'package:sliding_puzzle/src/puzzle/model/model.dart';

// import '../../../extensions/extensions.dart';
// import '../../commands/board_command.dart';

// class MoveTile implements PuzzleCommand {
//   final Tile? tile;
//   PuzzleBoard board;
//   MoveTile._(this.tile, this.board);

//   factory MoveTile.left(PuzzleBoard board) {
//     return MoveTile._(board.getLeftMoveableTile(), board);
//   }
//   factory MoveTile.right(PuzzleBoard board) {
//     return MoveTile._(board.getRightMoveableTile(), board);
//   }
//   factory MoveTile.up(PuzzleBoard board) {
//     return MoveTile._(board.geTopMoveableTile(), board);
//   }
//   factory MoveTile.down(PuzzleBoard board) {
//     return MoveTile._(board.getBottomMoveableTile(), board);
//   }
//   factory MoveTile.tile(PuzzleBoard board, Tile tile) {
//     return MoveTile._(tile, board);
//   }

//   @override
//   void execute() {
//     if (tile != null) {
//       board.moveTile(tile!);
//     }
//   }

//   @override
//   String getName() {
//     return "Move Tile";
//   }

//   @override
//   void undo() {
//   }
// }
