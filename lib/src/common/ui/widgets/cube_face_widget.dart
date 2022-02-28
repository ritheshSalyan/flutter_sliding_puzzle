import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/common/ui/theme/app_theme.dart';

class CubeFaceWidget extends StatefulWidget {
  const CubeFaceWidget({Key? key, required this.cubeTheme, required this.size})
      : super(key: key);
  final CubeFaceTheme cubeTheme;
  final Size size;

  @override
  State<CubeFaceWidget> createState() => _CubeFaceWidgetState();
}

class _CubeFaceWidgetState extends State<CubeFaceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      color: widget.cubeTheme.baseColor,
      //  color: ref.watch(ThemeNotifier.provider),
      width: widget.size.width,
      height: widget.size.height,
      child: CustomPaint(
        painter: widget.cubeTheme.spotPainter,
        child: widget.cubeTheme.child ?? const Center(),
      ),
    );
  }
}
