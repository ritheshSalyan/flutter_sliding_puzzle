import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/depth_builder.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/input/keyboard_listner.dart';

import '../../puzzle.dart';

class PuzzlePage extends ConsumerWidget {
  const PuzzlePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomKeyboardActionListner(
          controller: ref.watch(BoardUIController.provider),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanUpdate: (details) {
              ref.read(BoardUIController.provider).rotateBoardBy(details.delta);

              // setState(() => _offset += details.delta);
            },
            onPanEnd: (details) {
              ref.read(BoardUIController.provider).resetRotation();
            },
            child: Stack(
              children: [
                const Background(),
                DeferredPointerHandler(
                  child: Center(
                      child: SizedBox(
                          width: (screensize.shortestSide * 0.75)
                              .clamp(100, 500.0),
                          height: (screensize.shortestSide * 0.75)
                              .clamp(100, 500.0),
                          child: const BoardView())),
                ),
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
                ref.read(BoardUIController.provider).moveLeft();
              },
              icon: const Icon(Icons.arrow_left)),
          IconButton(
              onPressed: () {
                ref.read(BoardUIController.provider).moveRight();
              },
              icon: const Icon(Icons.arrow_right)),
          IconButton(
              onPressed: () {
                ref.read(BoardUIController.provider).moveUp();
              },
              icon: const Icon(Icons.arrow_upward)),
          IconButton(
              onPressed: () {
                ref.read(BoardUIController.provider).moveDown();
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
    // final boardController = ref.watch(BoardUIController.provider);

    // return
    //  ValueListenableBuilder<Offset>(
    //     valueListenable: boardController.boardRotationController.boardAngle,
    // builder: (context, snapshot, _) {
    return DepthBuilder(builder: (context, offset) {
      // log("DepthBuilder : $offset");
      return Transform(
        transform: Matrix4.identity()
          ..translate(-20.0, -20.0, 0)
          ..translate(-offset.dx, -offset.dy, 0)
          ..scale(1.5),
        child: Image.asset(
          "assets/images/lava_a.jpg",
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
