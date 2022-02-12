import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/responsive/responsive_builder.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/input/board_input_wrapper.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/title_widget.dart';

import '../../puzzle.dart';

class PuzzlePage extends ConsumerWidget {
  const PuzzlePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screensize = MediaQuery.of(context).size;
    return DeferredPointerHandler(
      child: Scaffold(
        appBar: AppBar(),
        body: BoardInputWrapper(
          // controller: ref.watch(BoardUIController.provider),
          // child: GestureDetector(
          //   behavior: HitTestBehavior.translucent,
          //   onPanUpdate: (details) {
          //     ref
          //         .read(BoardUIController.provider)
          //         .rotateBoardBy(details.delta);

          //     // setState(() => _offset += details.delta);
          //   },
          //   onPanEnd: (details) {
          //     ref.read(BoardUIController.provider).resetRotation();
          //   },
          child: ResponsiveBuilder(
            small: (context, constraints) {
              return CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    const TitleWidget(),
                  ])),
                  SliverFillRemaining(
                    child: Center(
                      child: SizedBox(
                        // transform: Matrix4.identity()..translate(20.0, 20.0, 0),
                        // color: Colors.white,
                        width:
                            (screensize.shortestSide * 0.75).clamp(100, 500.0),
                        height:
                            (screensize.shortestSide * 0.75).clamp(100, 500.0),
                        child: const BoardView(),
                      ),
                    ),
                  )
                ],
              );
            },
            large: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(child: TitleWidget()),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: SizedBox(
                        // transform: Matrix4.identity()..translate(20.0, 20.0, 0),
                        // color: Colors.white,
                        width:
                            (screensize.shortestSide * 0.75).clamp(100, 500.0),
                        height:
                            (screensize.shortestSide * 0.75).clamp(100, 500.0),
                        child: const BoardView(),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          // Row(
          //   children: [
          // Expanded(child: Container()),
          // const Background(),

          //   ],
          // ),
          // )
        ),
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
      ),
    );
  }
}
