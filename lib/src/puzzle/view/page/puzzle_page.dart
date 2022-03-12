import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/input/board_input_wrapper.dart';
import 'package:sliding_puzzle/src/puzzle/view/widgets/title_widget.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../puzzle.dart';

class PuzzlePage extends ConsumerWidget {
  const PuzzlePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screensize = MediaQuery.of(context).size;
    return BoardInputWrapper(
      child: CommonScaffold(
        actions: const [
          GyroButton(),
        ],
        small: (context, constraints) {
          return Column(
            children: [
              const TitleWidget(),
              Expanded(
                child: _BoardSection(screensize: screensize),
              )
            ],
          );
        },
        medium: (context, constraints) {
          return CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                const TitleWidget(),
              ])),
              SliverFillRemaining(
                child: _BoardSection(screensize: screensize),
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
                child: _BoardSection(screensize: screensize),
              )
            ],
          );
        },
      ),
    );
  }
}

class _BoardSection extends ConsumerWidget {
  const _BoardSection({
    Key? key,
    required this.screensize,
  }) : super(key: key);

  final Size screensize;

  @override
  Widget build(BuildContext context, ref) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            // transform: Matrix4.identity()..translate(20.0, 20.0, 0),
            // color: Colors.white,
            width: (screensize.shortestSide * 0.75).clamp(100, 500.0),
            height: (screensize.shortestSide * 0.75).clamp(100, 500.0),
            child: DepthBuilder(
                rotationController: ref
                    .read(BoardUIController.provider)
                    .boardRotationController,
                builder: (context, offset) {
                  final angleY = (offset.dy);
                  final angleX = (offset.dx);
                  return Transform(
                      transform: Matrix4.identity()
                        // ..setEntry(3, 2, perspective)
                        ..rotateX(angleY)
                        ..rotateY(angleX)
                        ..translate(0.0, 0.0, 0),
                      alignment: FractionalOffset.center,
                      child: BoardView(
                        uiController: ref.read(BoardUIController.provider),
                      ));
                }),
          ),
        ),
      ],
    );
  }
}

class GyroButton extends ConsumerWidget {
  const GyroButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    if (UniversalPlatform.isAndroid ||
        UniversalPlatform.isIOS ||
        UniversalPlatform.isWeb) {
      return IconButton(
          onPressed: () {
            ref.read(BoardUIController.provider).toggleGyro();
          },
          icon: Icon(
            Icons.rotate_90_degrees_cw_outlined,
            color: ref.watch(BoardUIController.provider).gyroEnabled
                ? ref.watch(ThemeNotifier.provider).foregroundColor
                : Colors.grey,
          ));
    }
    return Container();
  }
}
