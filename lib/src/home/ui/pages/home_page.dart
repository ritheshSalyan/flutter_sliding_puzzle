import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sliding_puzzle/app_module.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      large: (context, constraints) => Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Modular.to.pushNamed(AppModule.game);
              },
              child: const Text("Play Game"))
        ],
      ),
    );
  }
}
