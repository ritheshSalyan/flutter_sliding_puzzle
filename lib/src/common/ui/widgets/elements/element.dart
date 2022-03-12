import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/helper/voxel/renderer.dart';
import 'package:sliding_puzzle/src/common/provider/voxel_mesh_provider.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';

class TopElementWidget extends ConsumerWidget {
  const TopElementWidget({Key? key, required this.element}) : super(key: key);

  final String element;
  // final Offset position;
  // final String mesh;

  @override
  Widget build(BuildContext context, ref) {
    return ref.watch(MeshProvider.provider(element)).when(
          data: (data) {
            return VoxelBuilder(
              mesh: data,
              rotationController: BoardRotationController(),
            );
          },
          error: (e, a) => Container(),
          loading: () => Container(),
        );

    // Container()
  }

  // Offset get position => element.position;

  // double get x => constraints.maxWidth * 0.8 * position.dx;
  // // (constraints.maxWidth / 2) - ((constraints.maxWidth / 2) * position.dx);
  // double get y =>
  //     (constraints.maxWidth * 0.9) *
  //     (position.dy); //+ (constraints.maxWidth / 2);
  // @override
  // double get centerX => x;

  // @override
  // double get centerY => y;
}

// class Tree extends StatefulWidget {
//   const Tree({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<Tree> createState() => _TreeState();
// }

// class _TreeState extends State<Tree> {
//   @override
//   Widget build(BuildContext context) {
//     // const treeHeight = 30.0;
//     return AspectRatio(
//       aspectRatio: 1,
//       child: LayoutBuilder(builder: (context, constraints) {
//         final width = constraints.maxWidth;
//         final treeHeight = width;
//         final trunkWidth = width / 4;
//         final leafDepth = width / 2;
//         return Stack(
//           clipBehavior: Clip.none,
//           alignment: Alignment.center,
//           children: [
//             CustomCube(
//               width: trunkWidth,
//               height: trunkWidth,
//               depth: treeHeight,
//               boardRotaioncontroller: BoardRotationController(),
//               faceWidgets: CubeFaceWidgets.all((context, size) => Container(
//                     width: size.width,
//                     height: size.height,
//                     color: Colors.grey,
//                   )),
//             ),
//             Transform(
//               transform: Matrix4.identity()
//                 ..translate(-(width - trunkWidth) / 2,
//                     -(width - trunkWidth) / 2, -(treeHeight + width)),
//               child: CustomCube(
//                 width: width,
//                 height: width,
//                 depth: leafDepth,
//                 depthOffset: treeHeight + leafDepth,
//                 boardRotaioncontroller: BoardRotationController(),
//                 faceWidgets: CubeFaceWidgets.all((context, size) => Container(
//                       width: size.width,
//                       height: size.height,
//                       color: Colors.green,
//                     )),
//               ),
//             ),
//             Transform(
//               transform: Matrix4.identity()
//                 ..translate(-(width - trunkWidth) / 2,
//                     -(width - trunkWidth) / 2, -(treeHeight + width * 2)),
//               child: CustomCube(
//                 width: width / 2,
//                 height: width / 2,
//                 depth: leafDepth,
//                 depthOffset: treeHeight + leafDepth * 2,
//                 boardRotaioncontroller: BoardRotationController(),
//                 faceWidgets: CubeFaceWidgets.all((context, size) => Container(
//                       width: size.width,
//                       height: size.height,
//                       color: Colors.green,
//                     )),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

// class TreeOne extends StatefulWidget {
//   const TreeOne({Key? key}) : super(key: key);

//   @override
//   State<TreeOne> createState() => _TreeOneState();
// }

// class _TreeOneState extends State<TreeOne> {
//   late final VoxelMesh mesh;
//   @override
//   void initState() {
//     mesh = VoxelMeshFactory(voxelTree).construct();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VoxelBuilder(
//         mesh: mesh, rotationController: BoardRotationController());
//   }
// }
