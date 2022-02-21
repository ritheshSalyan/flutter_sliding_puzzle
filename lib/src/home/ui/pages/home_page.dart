import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/app_module.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/jungle_theme/jungle_theme.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/lava_theme/fire_theme.dart';
import 'package:sliding_puzzle/src/common/ui/theme/theme_provider.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/scaffold.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return CommonScaffold(
      large: (context, constraints) => Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Modular.to.pushNamed(AppModule.game);
              },
              child: const Text("Play Game")),
          ElevatedButton(
            onPressed: () {
              Modular.to.pushNamed(AppModule.argame);
            },
            child: const Text("Play Game"),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(ThemeNotifier.provider.notifier)
                      .changeTheme(jungleTheme);
                },
                child: const Text("Jungle"),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(ThemeNotifier.provider.notifier)
                      .changeTheme(fireTheme);
                },
                child: const Text("Lava"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
