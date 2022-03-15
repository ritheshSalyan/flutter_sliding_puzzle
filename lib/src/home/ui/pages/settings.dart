import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/home/viewmodel/homepage_viewmodel.dart';

class ThemeSelector extends ConsumerStatefulWidget {
  const ThemeSelector({
    Key? key,
    required this.appTheme,
    required this.lable,
  }) : super(key: key);
  final AppTheme appTheme;
  final String lable;

  @override
  ConsumerState<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends ConsumerState<ThemeSelector> {
  late final CubeTheme tileTheme;
  @override
  void initState() {
    // boardRotationController.rotateTo(const Offset(0.25, -0.25));
    tileTheme = widget.appTheme.boardTheme.tileTheme.call();

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return LayoutBuilder(builder: (context, snapshot) {
      var width = snapshot.maxWidth.clamp(10.0, 75.0);
      var height = snapshot.maxHeight.clamp(10.0, 75.0);
      var theme = ref.watch(ThemeNotifier.provider);
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
            border: theme == widget.appTheme
                ? Border.all(color: theme.foregroundColor)
                : null),
        width: width * 2,
        height: height * 2,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Transform.translate(
              offset: Offset(width / 2, height / 2),
              child: DepthTransformer(
                rotationController: ref
                    .watch(HomePageViewModel.provider)
                    .boardRotationController,
                child: CustomCube(
                  onTap: () {
                    ref
                        .read(ThemeNotifier.provider.notifier)
                        .changeTheme(context, widget.appTheme);
                  },
                  width: width,
                  height: height,
                  depth: width,
                  depthOffset: width / 2,
                  faceWidgets: CubeFaceWidgets(
                    topFace: (context, size) {
                      return CubeFaceWidget(
                        size: size,
                        cubeTheme: tileTheme.top,
                      );
                    },
                    leftFace: (context, size) => CubeFaceWidget(
                      size: size,
                      cubeTheme: tileTheme.left,
                    ),
                    rightFace: (context, size) => CubeFaceWidget(
                      size: size,
                      cubeTheme: tileTheme.right,
                    ),
                    upFace: (context, size) => CubeFaceWidget(
                      size: size,
                      cubeTheme: tileTheme.up,
                    ),
                    downFace: (context, size) => CubeFaceWidget(
                      size: size,
                      cubeTheme: tileTheme.down,
                    ),
                  ),
                  boardRotaioncontroller: ref
                      .watch(HomePageViewModel.provider)
                      .boardRotationController,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(widget.lable),
            )
          ],
        ),
      );
    });
  }
}
