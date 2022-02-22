
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class EnvironmentParticle extends StatefulWidget {
  const EnvironmentParticle({
    Key? key,
  }) : super(key: key);
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
          options: const ParticleOptions(
              baseColor: Colors.amber,
              opacityChangeRate: 0.1,
              spawnMaxSpeed: 100,
              spawnMinSpeed: 5,
              particleCount: 20,
              maxOpacity: 0.4)),
      child: Container(),
    );
  }
}
