import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/puzzle/provider/difficuly_level.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';

class Settings extends ConsumerWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return CommonScaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBar(),
      large: (context, constraints) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Settings",
              style: context.textTheme.displaySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Select Theme",
              style: context.textTheme.bodyLarge,
            ),
            Wrap(
              runAlignment: WrapAlignment.spaceEvenly,
              alignment: WrapAlignment.spaceEvenly,
              runSpacing: 20,
              children: [
                ThemeSelector(
                  appTheme: jungleTheme,
                  lable: "Enviornment",
                ),
                ThemeSelector(
                  appTheme: iceTheme,
                  lable: "Ice Age",
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     ref
                //         .read(ThemeNotifier.provider.notifier)
                //         .changeTheme(context, jungleTheme);
                //   },
                //   child: const Text("Jungle"),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     ref
                //         .read(ThemeNotifier.provider.notifier)
                //         .changeTheme(context, iceTheme);
                //   },
                //   child: const Text("Ice"),
                // ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Select Difficulty",
              style: context.textTheme.bodyLarge,
            ),
            Wrap(
              runAlignment: WrapAlignment.spaceEvenly,
              alignment: WrapAlignment.spaceEvenly,
              runSpacing: 20,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                DifficultyStage(
                  level: DifficulyLevel.easy,
                  lable: "Easy",
                ),
                DifficultyStage(
                  level: DifficulyLevel.medium,
                  lable: "Medium",
                ),
                DifficultyStage(
                  level: DifficulyLevel.hard,
                  lable: "Hard",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
  var boardRotationController = BoardRotationController();
  late final CubeTheme tileTheme;
  @override
  void initState() {
    boardRotationController.rotateTo(const Offset(0.25, -0.25));
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
                rotationController: boardRotationController,
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
                  boardRotaioncontroller: boardRotationController,
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

class DifficultyStage extends ConsumerWidget {
  const DifficultyStage({
    Key? key,
    required this.lable,
    required this.level,
  }) : super(key: key);
  final String lable;
  final DifficulyLevel level;
  @override
  Widget build(BuildContext context, ref) {
    var isSelected = ref.watch(DifficultyNotifier.provider) == level;
    return InkWell(
      onTap: () {
        ref.read(DifficultyNotifier.provider.notifier).changeDifficulty(level);
      },
      child: Chip(
        backgroundColor: isSelected
            ? ref.watch(ThemeNotifier.provider).foregroundColor
            : null,
        avatar: isSelected ? const Icon(Icons.check) : null,
        label: Text(lable),
      ),
    );
  }
}
