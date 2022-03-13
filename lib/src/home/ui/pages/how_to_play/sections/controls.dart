import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';

class Controls extends StatelessWidget {
  const Controls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Controls",
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 50,
        ),
        // if(UniversalPlatform.isDesktopOrWeb) ...{
        const Divider(
          thickness: 2,
          endIndent: 30,
          indent: 30,
        ),
        Text(
          "Use Keys to move Blocks",
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        Column(
          children: [
            getKey(const Text("W")),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                getKey(const Text("A")),
                getKey(const Text("S")),
                getKey(const Text("D"))
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "OR",
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: [
            getKey(const Icon(Icons.keyboard_arrow_up)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                getKey(const Icon(Icons.keyboard_arrow_left)),
                getKey(const Icon(Icons.keyboard_arrow_down)),
                getKey(const Icon(Icons.keyboard_arrow_right))
              ],
            ),
          ],
        ),

        const Divider(
          thickness: 2,
          endIndent: 30,
          indent: 30,
        ),

        Text(
          "Tap on tiles to Move Tiles",
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getKey(const Icon(Icons.touch_app)),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        const Divider(
          thickness: 2,
          endIndent: 30,
          indent: 30,
        ),
        Text(
          "Use Gyro or swipe to turn board",
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getKey(const Icon(Icons.swipe)),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        const Divider(
          thickness: 2,
          endIndent: 30,
          indent: 30,
        ),
      ],
    );
  }

  Widget getKey(Widget key) {
    final rotationController = BoardRotationController()
      ..rotateTo(const Offset(0.2, -0.2));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DepthTransformer(
        rotationController: rotationController,
        child: CustomCube(
          boardRotaioncontroller: rotationController,
          depth: 50,
          width: 50,
          height: 50,
          faceWidgets: CubeFaceWidgets.symetric(
              (context, size) => Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.white,
                    child: Center(child: key),
                  ),
              (context, size) => Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.white,
                  ),
              (context, size) => Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.white,
                  )),
        ),
      ),
    );
  }
}
