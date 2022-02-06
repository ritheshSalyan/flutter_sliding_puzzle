import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/depth_builder.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/input/keyboard_listner.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
                    child: Container(
                        transform: Matrix4.identity()..translate(20.0, 20.0, 0),
                        // color: Colors.white,
                        width:
                            (screensize.shortestSide * 0.75).clamp(100, 500.0),
                        height:
                            (screensize.shortestSide * 0.75).clamp(100, 500.0),
                        child: const BoardView()),
                  ),
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
          ..translate(-100.0, -100.0, 0)
          ..translate(-offset.dx, -offset.dy, 0)
          ..scale(1.5),
        child: WaveWidget(
          config: CustomConfig(
            gradients: [
              [Colors.red, const Color(0xEEF44336).withOpacity(0.5)],
              [
                Colors.red.shade600.withOpacity(0.5),
                const Color(0x77E57373).withOpacity(0.5)
              ],
              [
                Colors.orange.withOpacity(0.5),
                const Color(0x66FF9800).withOpacity(0.5)
              ],
              [
                Colors.yellow.withOpacity(0.7),
                const Color(0x55FFEB3B).withOpacity(0.5)
              ]
            ],
            durations: [35000, 19440, 10800, 6000],
            heightPercentages: [0.25, 0.2, 0.6, 1.0],
            // blur: const MaskFilter.blur(BlurStyle.solid, 10),
            gradientBegin: Alignment.bottomLeft,
            gradientEnd: Alignment.topRight,
          ),
          // colors: [
          //   Colors.white70,
          //   Colors.white54,
          //   Colors.white30,
          //   Colors.white24,
          // ],
          // durations: [
          //   32000,
          //   21000,
          //   18000,
          //   5000,
          // ],
          // waveAmplitude: 0,
          // heightPercentages: [0.25, 0.26, 0.28, 0.31],
          backgroundImage: const DecorationImage(
            image: AssetImage("assets/images/lava_a.jpg"
                // 'https://images.unsplash.com/photo-1600107363560-a2a891080c31?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=672&q=80',
                ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.softLight),
          ),
          size: size,
          // const Size(
          //   double.infinity,
          //   double.infinity,
          // ),
        ),
      );
    });
    // });
  }
}
