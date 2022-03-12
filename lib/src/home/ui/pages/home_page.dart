import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/app_module.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/home/viewmodel/homepage_viewmodel.dart';
import 'package:universal_platform/universal_platform.dart';

import '../widgets/buttons.dart';
import 'how_to_play.dart';
import 'settings.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // VoxelMesh mesh = VoxelMeshFactory(voxelTree).construct();
    final viewModel = ref.watch(HomePageViewModel.provider);
    return CommonScaffold(
      small: (context, constraints) => Column(
        children: [
          const Center(child: HomePageTitle()),
          Expanded(child: HomePageActionButtons(viewModel: viewModel)),
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
            child: const Text("Play")),
        if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) ...[
          const SizedBox(
            height: 20,
          ),
          PuzzleFilledButton(
            rotationController: viewModel.boardRotationController,
            onTap: () {
              Modular.to.pushNamed(AppModule.argame);
            },
            child: const Text("Play in AR"),
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
                        child: Settings(),
                      ));
            },
            child: const Text("Settings")),
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
