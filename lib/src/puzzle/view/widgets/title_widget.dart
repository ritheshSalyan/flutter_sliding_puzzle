import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_provider.dart';

class TitleWidget extends ConsumerWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        Text(
          "Puzzle Hack",
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
        ),
        Text(
          ref.watch(BoardUIController.provider).moves.toString(),
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
