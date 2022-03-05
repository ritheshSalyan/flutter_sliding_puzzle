import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/app_module.dart';
import 'package:sliding_puzzle/helper/voxel/model/factory.dart';
import 'package:sliding_puzzle/helper/voxel/model/voxel_mesh.dart';
import 'package:sliding_puzzle/helper/voxel/parser/voxlib/input_stream.dart';
import 'package:sliding_puzzle/helper/voxel/parser/voxlib/vox_reader.dart';
import 'package:sliding_puzzle/helper/voxel/renderer.dart';
import 'package:sliding_puzzle/helper/voxel/test_tree.dart';
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
        ElevatedButton(
          onPressed: () async {
            final bytes = await rootBundle.load("assets/models/monu2.vox");
           final file =  VoxReader(InputStream(bytes,"All File content: ")).read();

           final palette = file.getPalette();
            // VoxelMesh mesh = VoxelMeshFactory(testTree2).construct();
            // // final chunks = ReducingAlgorithm(mesh.blocks).construct();
            // showDialog(
            //   context: context,
            //   builder: (context) => Dialog(
            //     child: Scaffold(
            //       body: Center(
            //         child: SizedBox(
            //           width: 100,
            //           child: DepthTransformer(
            //               rotationController: viewModel.boardRotationController,
            //               child: VoxelBuilder(
            //                   mesh: mesh,
            //                   rotationController:
            //                       viewModel.boardRotationController)),
            //         ),
            //       ),
            //     ),
            //   ),
            // );
          },
          child: const Text("Test"),
        )
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
