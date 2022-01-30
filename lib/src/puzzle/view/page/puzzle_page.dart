import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_controller.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/depth_builder.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/input/keyboard_listner.dart';

import '../../puzzle.dart';

class PuzzlePage extends ConsumerWidget {
  const PuzzlePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomKeyboardActionListner(
          controller: ref.watch(BoardUIController.provider),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanUpdate: (details) {
              ref
                  .read(BoardUIController.provider)
                  .boardRotationController
                  .rotateBy(details.delta);

              // setState(() => _offset += details.delta);
            },
            onPanEnd: (details) {
              ref
                  .read(BoardUIController.provider)
                  .boardRotationController
                  .reset();
            },
            child: Stack(
              children: const [
                Background(),
                Center(
                    child:
                        SizedBox(width: 500, height: 500, child: BoardView())),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(BoardUIController.provider).shuffle();
        },
      ),
      bottomNavigationBar: Row(
        children: [
          IconButton(
              onPressed: () {
                log(ref
                    .read(BoardLogicController.provider.notifier)
                    .moveLeft()
                    .toString());
              },
              icon: const Icon(Icons.arrow_left)),
          IconButton(
              onPressed: () {
                log("${ref.read(BoardLogicController.provider.notifier).moveRight()}");
              },
              icon: const Icon(Icons.arrow_right)),
          IconButton(
              onPressed: () {
                log(ref
                    .read(BoardLogicController.provider.notifier)
                    .moveUp()
                    .toString());
              },
              icon: const Icon(Icons.arrow_upward)),
          IconButton(
              onPressed: () {
                log(ref
                    .read(BoardLogicController.provider.notifier)
                    .moveDown()
                    .toString());
              },
              icon: const Icon(Icons.arrow_downward)),
        ],
      ),
    );
  }
}

class Background extends HookConsumerWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var size = MediaQuery.of(context).size;
    final boardController = ref.watch(BoardUIController.provider);

    // return
    //  ValueListenableBuilder<Offset>(
    //     valueListenable: boardController.boardRotationController.boardAngle,
    // builder: (context, snapshot, _) {
    return DepthBuilder(builder: (context, offset) {
      // log("DepthBuilder : $offset");
      return Transform(
        transform: Matrix4.identity()
          ..translate(-20.0, -20.0, 0)
          ..translate(-offset.dx * 0.5, -offset.dy * 0.5, 0)
          ..scale(1.5),
        child: Image.asset(
          "assets/images/rock.jpg",
          width: size.width * 1.5,
          height: size.height * 1.5,
          // fit: BoxFit.cover,
          // fit: BoxFit.fill,
          repeat: ImageRepeat.repeat,
        ),
      );
    });
    // });
  }
}
