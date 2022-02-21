import 'package:defer_pointer/defer_pointer.dart';
import 'package:dream_xr/dream_xr.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../puzzle.dart';

class ARPuzzlePage extends ConsumerWidget {
  const ARPuzzlePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screensize = MediaQuery.of(context).size;
    var sizedBox = const BoardView();
    return DeferredPointerHandler(
      child: ImageARWidget(
          targetDB: TargetDB.asset("assets/marker/target_3.mind"),
          tagets: [
            ImageTarget(targetIndex: 0, children: [
              WidgetTargetChild(
                position: const TransformPosition(0.1, -0.1),
                builder: (context, transform) {
                  ref.read(BoardUIController.provider).rotateBoardTo(
                      Offset(transform.rotation.y, transform.rotation.x));
                  return SizedBox(width: screensize.width, child: sizedBox);
                },
              )
            ])
          ]),
      // child: CommonScaffold(
      //   small: (context, constraints) {
      //     return Column(
      //       children: [
      //         InkWell(
      //             onTap: () {
      //               ref.read(BoardUIController.provider).triggerEndAnimation();
      //             },
      //             child: const TitleWidget()),
      //         Expanded(
      //           child: Center(
      //             child: SizedBox(
      //               // transform: Matrix4.identity()..translate(20.0, 20.0, 0),
      //               // color: Colors.white,
      //               width: (screensize.shortestSide * 0.75).clamp(100, 500.0),
      //               height: (screensize.shortestSide * 0.75).clamp(100, 500.0),
      //               child: const BoardView(),
      //             ),
      //           ),
      //         )
      //       ],
      //     );
      //   },
      //   medium: (context, constraints) {
      //     return CustomScrollView(
      //       slivers: [
      //         SliverList(
      //             delegate: SliverChildListDelegate([
      //           const TitleWidget(),
      //         ])),
      //         SliverFillRemaining(
      //           child: Center(
      //             child: SizedBox(
      //               // transform: Matrix4.identity()..translate(20.0, 20.0, 0),
      //               // color: Colors.white,
      //               width: (screensize.shortestSide * 0.75).clamp(100, 500.0),
      //               height: (screensize.shortestSide * 0.75).clamp(100, 500.0),
      //               child: const BoardView(),
      //             ),
      //           ),
      //         )
      //       ],
      //     );
      //   },
      //   large: (context, constraints) {
      //     return Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         const Expanded(child: TitleWidget()),
      //         Expanded(
      //           flex: 2,
      //           child: Center(
      //             child: SizedBox(
      //               // transform: Matrix4.identity()..translate(20.0, 20.0, 0),
      //               // color: Colors.white,
      //               width: (screensize.shortestSide * 0.75).clamp(100, 500.0),
      //               height: (screensize.shortestSide * 0.75).clamp(100, 500.0),
      //               child: const BoardView(),
      //             ),
      //           ),
      //         )
      //       ],
      //     );
      //   },
      // ),
    );
  }
}
