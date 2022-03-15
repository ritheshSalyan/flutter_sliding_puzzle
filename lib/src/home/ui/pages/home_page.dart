import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/app_module.dart';
import 'package:sliding_puzzle/gen/assets.gen.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/home/viewmodel/homepage_viewmodel.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

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
              Navigator.of(
                context,
              ).push(MaterialPageRoute(
                  builder: (context) => const DifficultySelection(
                        route: AppModule.game,
                      )));
            },
            child: const Text("Play")),
        if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) ...[
          const SizedBox(
            height: 20,
          ),
          PuzzleFilledButton(
            rotationController: viewModel.boardRotationController,
            onTap: () async {
              Navigator.of(
                context,
              ).push(
                MaterialPageRoute(
                  builder: (context) => const DifficultySelection(
                    route: AppModule.argame,
                  ),
                ),
              );
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
        const GetAppsOnWidget()

        // PuzzleFilledButton(
        //     rotationController: viewModel.boardRotationController,
        //     onTap: () {
        //       showDialog(
        //           context: context,
        //           builder: (context) => Dialog(
        //                 backgroundColor: Colors.transparent,
        //                 elevation: 0,
        //                 child: AlertDialog(
        //                   title: const Text("Get It On"),
        //                   content: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                     children: [
        //                       IconButton(
        //                         onPressed: () {
        // launch(
        //     "https://play.google.com/store/apps/details?id=dev.dsi.slidez");
        //                         },
        //                         icon: const Icon(Icons.android),
        //                       ),
        //                       IconButton(
        //                         onPressed: () {
        //                           launch(
        //                               "https://drive.google.com/file/d/1pJUuiTLJ5B3EA9DrDe3tMgcjeRvOx8Oj/view?usp=sharing");
        //                         },
        //                         icon: const Icon(Icons.laptop_windows),
        //                       ),
        //                     ],
        //                   ),
        //                   actions: [
        //                     TextButton(
        //                         onPressed: () {
        //                           Navigator.pop(context);
        //                         },
        //                         child: const Text("Close"))
        //                   ],
        //                 ),
        //               ));
        //     },
        //     child: const Text("Get Apps")),
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

class GetAppsOnWidget extends StatelessWidget {
  const GetAppsOnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (UniversalPlatform.isWeb) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              launch(
                  "https://play.google.com/store/apps/details?id=dev.dsi.slidez");
            },
            child: Assets.images.getOnPlaystore.image(width: 200),
          ),
          InkWell(
            onTap: () {
              launch("https://puzzlehack.b-cdn.net/Slide_Z_Windows.zip");
            },
            child: Assets.images.windows.image(width: 200),
          )
        ],
      );
    }
    return Container();
  }
}
