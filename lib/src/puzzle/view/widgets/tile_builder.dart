import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/puzzle/model/model.dart';

class TileBuilder extends StatelessWidget {
  final Tile tile;
  const TileBuilder({Key? key, required this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(color: Colors.blue),
      ),
      child: Center(
        child: Text("${tile.data}"),
      ),
    );
  }
}
