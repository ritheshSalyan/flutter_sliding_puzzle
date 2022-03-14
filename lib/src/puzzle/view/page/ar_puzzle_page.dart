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
        child: Stack(
          children: [
            ImageARWidget(
                targetDB: //TargetDB.asset(Assets.marker.logo),
                    TargetDB.network("https://puzzlehack.b-cdn.net/logo.mind"),
                tagets: [
                  ImageTarget(targetIndex: 0, children: [
                    // WidgetTargetNode.child(
                    //   position: const TransformPosition(0, 0.4),
                    //   child: Container(
                    //     color: Colors.white,
                    //     child: const TitleWidget(),
                    //   ),
                    // ),
                    WidgetTargetNode(
                      position: const TransformPosition(0.1, -0.1),
                      scale: const TransformScale(0.75, 0.75, 0.75),
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
                        return SizedBox(
                          width: screensize.width,
                          child: const BoardView(
                              // uiController: ref.watch(BoardUIController.provider),
                              ),
                        );
                      },
                    ),
                    // WidgetTargetNode.child(
                    //   child: SizedBox(
                    //     width: screensize.width,
                    //     child: const BoardView(
                    //         // uiController: ref.watch(BoardUIController.provider),
                    //         ),
                    //   ),
                    // )
                  ])
                ]),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: screensize.longestSide * 0.2,
                child: Container(
                  color: Colors.white,
                  child: const TitleWidget(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
