import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class EnvironmentParticle extends StatefulWidget {
  const EnvironmentParticle(
      {Key? key, required this.color, this.maxOpacity = 0.4})
      : super(key: key);
  final Color color;
  final double maxOpacity;
  @override
  _EnvironmentParticleState createState() => _EnvironmentParticleState();
}

class _EnvironmentParticleState extends State<EnvironmentParticle>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      vsync: this,
      behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
              baseColor: widget.color,
              opacityChangeRate: 0.1,
              spawnMaxSpeed: 100,
              spawnMinSpeed: 5,
              particleCount: 20,
              maxOpacity: widget.maxOpacity)),
      child: Container(),
    );
  }
}
