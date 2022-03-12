import 'dart:developer';

import 'package:defer_pointer/defer_pointer.dart';
import 'package:dream_xr/dream_xr.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../puzzle.dart';
import '../widgets/title_widget.dart';

class ARPuzzlePage extends ConsumerWidget {
  const ARPuzzlePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screensize = MediaQuery.of(context).size;
    // var sizedBox = ;
    return Material(
      child: DeferredPointerHandler(
        child: ImageARWidget(
            targetDB: TargetDB.asset("assets/marker/target_3.mind"),
            tagets: [
              ImageTarget(targetIndex: 0, children: [
                WidgetTargetNode.child(
                    position: const TransformPosition(0, 0.4),
                    child: Container(
                        color: Colors.white, child: const TitleWidget())),
                WidgetTargetNode(
                  position: const TransformPosition(0.1, -0.1),
                  builder: (context, transform) {
                    Future.delayed(const Duration(milliseconds: 10), () {
                      var offset = Offset(
                        transform.rotation.y,
                        transform.rotation.x,
                      );
                      log(offset.toString());
                      ref
                          .read(BoardUIController.provider)
                          .rotateBoardTo(offset);
                    });
                    return Container();
                  },
                ),
                WidgetTargetNode.child(
                    child: SizedBox(
                        width: screensize.width,
                        child: const BoardView(
                            // uiController: ref.watch(BoardUIController.provider),
                            )))
              ])
            ]),
      ),
    );
  }
}
