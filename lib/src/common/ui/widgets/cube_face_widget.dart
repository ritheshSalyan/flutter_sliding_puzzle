import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/common/ui/theme/app_theme.dart';

class CubeFaceWidget extends StatelessWidget {
  const CubeFaceWidget({Key? key, required this.cubeTheme}) : super(key: key);
  final CubeFaceTheme cubeTheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cubeTheme.baseColor,
      //  color: ref.watch(ThemeNotifier.provider),
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: cubeTheme.spotPainter,
        child: const Center(),
      ),
    );
  }
}
