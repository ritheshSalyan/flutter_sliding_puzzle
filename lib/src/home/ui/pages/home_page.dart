import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/app_module.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/ice_theme/theme.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/jungle_theme/jungle_theme.dart';
import 'package:sliding_puzzle/src/common/ui/theme/theme_provider.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/scaffold.dart';
import 'package:sliding_puzzle/src/home/viewmodel/homepage_viewmodel.dart';
import 'package:universal_platform/universal_platform.dart';

import '../widgets/buttons.dart';
import 'how_to_play.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.watch(HomePageViewModel.provider);
    return CommonScaffold(
      small: (context, constraints) => Column(
        children: [
          const HomePageTitle(),
          Expanded(child: HomePageActionButtons(viewModel: viewModel)),

          // SliverFillRemaining(
          //   child: HomePageActionButtons(viewModel: viewModel),
          // ),

          const HomePageThemeButtons(),
        ],
      ),
      large: (context, constraints) => Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Expanded(child: Center(child: HomePageTitle())),
              HomePageThemeButtons(),
            ],
          )),
          Expanded(
              child: Center(
            child: HomePageActionButtons(viewModel: viewModel),
          ))
        ],
      ),
    );
  }
}

class HomePageThemeButtons extends ConsumerWidget {
  const HomePageThemeButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            ref
                .read(ThemeNotifier.provider.notifier)
                .changeTheme(context, jungleTheme);
          },
          child: const Text("Jungle"),
        ),
        ElevatedButton(
          onPressed: () {
            ref
                .read(ThemeNotifier.provider.notifier)
                .changeTheme(context, iceTheme);
          },
          child: const Text("Ice"),
        ),
      ],
    );
  }
}

class HomePageActionButtons extends StatelessWidget {
  const HomePageActionButtons({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final HomePageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PuzzleFilledButton(
            rotationController: viewModel.boardRotationController,
            onTap: () {
              Modular.to.pushNamed(AppModule.game);
            },
            child: const Text("Play Game")),
        if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) ...[
          const SizedBox(
            height: 20,
          ),
          PuzzleFilledButton(
            rotationController: viewModel.boardRotationController,
            onTap: () {
              Modular.to.pushNamed(AppModule.argame);
            },
            child: const Text("AR Mode"),
          ),
        ],
        const SizedBox(
          height: 20,
        ),
        PuzzleFilledButton(
            rotationController: viewModel.boardRotationController,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => const Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: HowToPlay(),
                      ));
            },
            child: const Text("How to play")),
      ],
    );
  }
}

class HomePageTitle extends StatelessWidget {
  const HomePageTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Puzzle Hack",
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
    );
  }
}
