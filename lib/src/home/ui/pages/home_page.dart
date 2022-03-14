import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/app_module.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/home/viewmodel/homepage_viewmodel.dart';
import 'package:sliding_puzzle/src/puzzle/provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import '../widgets/buttons.dart';
import 'difficulty_selection.dart';
import 'how_to_play/how_to_play.dart';
import 'settings.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // VoxelMesh mesh = VoxelMeshFactory(voxelTree).construct();
    // final viewModel = ref.watch(HomePageViewModel.provider);
    return CommonScaffold(
      small: (context, constraints) => Column(
        children: const [
          Center(child: HomePageTitle()),
          Expanded(child: HomePageActionButtons()),
          ThemeMenu(),

          // Expanded(
          //     child: DepthTransformer(
          //         rotationController: viewModel.boardRotationController,
          //         child: SizedBox(
          //             width: 100,
          //             height: 100,
          //             child: VoxelBuilder(
          //               mesh: mesh,
          //               rotationController: viewModel.boardRotationController,
          //             )))),

          // SliverFillRemaining(
          //   child: HomePageActionButtons(viewModel: viewModel),
          // ),
        ],
      ),
      large: (context, constraints) => Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Expanded(child: Center(child: HomePageTitle())),
              ThemeMenu(),
            ],
          )),
          const Expanded(
              child: Center(
            child: HomePageActionButtons(),
          )),
        ],
      ),
    );
  }
}

class ThemeMenu extends StatelessWidget {
  const ThemeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Wrap(
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
    );
  }
}

class HomePageActionButtons extends ConsumerWidget {
  const HomePageActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.watch(HomePageViewModel.provider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PuzzleFilledButton(
            rotationController: viewModel.boardRotationController,
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) => const DifficultySelection());

            },
            child: const Text("Play")),
        if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) ...[
          const SizedBox(
            height: 20,
          ),
          PuzzleFilledButton(
            rotationController: viewModel.boardRotationController,
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) => const DifficultySelection());
            },
            child: const Text("Play in AR"),
          ),
        ],
        const SizedBox(
          height: 20,
        ),
        PuzzleFilledButton(
            rotationController: viewModel.boardRotationController,
            onTap: () async {
              showDialog(
                  context: context, builder: (context) => const HowToPlay());
            },
            child: const Text("How to play")),
        const SizedBox(
          height: 20,
        ),
        // PuzzleFilledButton(
        //     rotationController: viewModel.boardRotationController,
        //     onTap: () {
        //       showDialog(
        //           context: context,
        //           builder: (context) => const Dialog(
        //                 backgroundColor: Colors.transparent,
        //                 elevation: 0,
        //                 child: Settings(),
        //               ));
        //     },
        //     child: const Text("Settings")),
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
      "Slide Z",
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
    );
  }
}


