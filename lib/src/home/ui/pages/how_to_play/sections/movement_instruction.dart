import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/ui.dart';
import 'package:sliding_puzzle/src/home/viewmodel/homepage_viewmodel.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';
import 'package:universal_platform/universal_platform.dart';

class MovementInstructions extends ConsumerStatefulWidget {
  const MovementInstructions({Key? key}) : super(key: key);

  @override
  ConsumerState<MovementInstructions> createState() =>
      _MovementInstructionsState();
}

class _MovementInstructionsState extends ConsumerState<MovementInstructions> {
  late final BoardRotationController rotationController;
  late final CubeTheme cubeTheme;
  @override
  void initState() {
    cubeTheme = ref.read(ThemeNotifier.provider).boardTheme.tileTheme.call();
    rotationController =
        ref.read(HomePageViewModel.provider).boardRotationController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Text(
            "Board Rotation",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: constraints.biggest.shortestSide * 0.1,
          ),
          Text("Drag " +
              ((UniversalPlatform.isIOS ||
                      UniversalPlatform.isAndroid ||
                      UniversalPlatform.isWeb)
                  ? " Or Use Gyro "
                  : "") +
              "to rotate the piller"),
          SizedBox(
            height: constraints.biggest.shortestSide * 0.2,
          ),
          Expanded(
            child: GestureDetector(
              onPanUpdate: (details) {
                rotationController.rotateBy(
                    Offset(-details.delta.dx * 0.01, details.delta.dy * 0.01));
              },
              child: Center(
                  child: SizedBox(
                width: constraints.biggest.shortestSide / 2,
                child: DepthTransformer(
                    child: CustomCube(
                      boardRotaioncontroller: rotationController,
                      width: constraints.biggest.shortestSide / 4,
                      height: constraints.biggest.shortestSide / 4,
                      depth: constraints.biggest.shortestSide / 2,
                      depthOffset: 0,
                      faceWidgets: CubeFaceWidgets(
                        topFace: (context, size) => Stack(
                          children: [
                            CubeFaceWidget(
                              size: size,
                              cubeTheme: cubeTheme.top,
                            ),
                          ],
                        ),
                        leftFace: (context, size) => CubeFaceWidget(
                          size: size,
                          cubeTheme: cubeTheme.left,
                        ),
                        rightFace: (context, size) => CubeFaceWidget(
                          size: size,
                          cubeTheme: cubeTheme.right,
                        ),
                        upFace: (context, size) => CubeFaceWidget(
                          size: size,
                          cubeTheme: cubeTheme.up,
                        ),
                        downFace: (context, size) => CubeFaceWidget(
                          size: size,
                          cubeTheme: cubeTheme.down,
                        ),
                      ),
                    ),
                    rotationController: rotationController),
              )),
            ),
          ),
        ],
      );
    });
  }
}
