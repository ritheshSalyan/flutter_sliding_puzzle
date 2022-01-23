import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/extensions/extensions.dart';
import 'package:sliding_puzzle/src/puzzle/model/model.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_controller.dart';

import '../../puzzle.dart';

class TileBuilder extends ConsumerStatefulWidget {
  final Tile tile;
  const TileBuilder({
    Key? key,
    required this.tile,
    required this.tileHeight,
    required this.tileWidth,
  }) : super(key: key);
  final double tileHeight;
  final double tileWidth;

  @override
  ConsumerState<TileBuilder> createState() => _TileBuilderState();
}

class _TileBuilderState extends ConsumerState<TileBuilder> {
  Offset extraOffset = Offset.zero;
  MovablePosition _movablePosition = MovablePosition.none;

  double get top =>
      widget.tileHeight * widget.tile.currentPos.x + extraOffset.dy;
  double get left =>
      widget.tileWidth * widget.tile.currentPos.y + extraOffset.dx;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      // key: ValueKey(widget.tile.correctPos.x *
      //         ref.read(BoardLogicController.provider).xDim +
      //     widget.tile.correctPos.y),
      // duration: const Duration(milliseconds: 250),
      top: top,
      left: left,
      child: SizedBox(
        width: widget.tileWidth,
        height: widget.tileHeight,
        child: GestureDetector(
          onPanStart: (details) {
            _movablePosition = ref
                .read(BoardLogicController.provider)
                .getMovablePosition(widget.tile);
          },
          onPanUpdate: (details) {
            final delta = details.delta;

            switch (_movablePosition) {
              case MovablePosition.top:
                if (top + delta.dy > top) {
                  extraOffset += Offset(0, delta.dy);
                }
                break;
              case MovablePosition.down:
                if (top + delta.dy < top) {
                  extraOffset += Offset(0, delta.dy);
                }
                break;
              case MovablePosition.left:
                if (left + delta.dx > left) {
                  extraOffset += Offset(delta.dx, 0);
                }
                break;
              case MovablePosition.right:
                if (left + delta.dx < left) {
                  extraOffset += Offset(delta.dx, 0);
                }
                break;
              case MovablePosition.none:
                // TODO: Handle this case.
                break;
            }
            setState(() {});
          },
          onPanEnd: (details) {
            if ((extraOffset.dx.abs() > widget.tileWidth / 2) ||
                (extraOffset.dy.abs() > widget.tileHeight / 2)) {
              ref.read(BoardAnimationController.provider).moveTile(widget.tile);
            }
            extraOffset = Offset.zero;
            setState(() {});
          },
          onTap: () {
            ref.read(BoardAnimationController.provider).moveTile(widget.tile);
            // log("Can Move ${tile.data} ${board.canMoveTile(tile)}");
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(color: Colors.blue),
            ),
            child: Center(
              child: Text("${widget.tile.data}"),
            ),
          ),
        ),
      ),
    );
  }
}
