import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart';

import 'package:sliding_puzzle/helper/voxel/model/voxel_block.dart';
import 'package:sliding_puzzle/helper/voxel/model/voxel_mesh.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';

import '../depth/depth_resolver.dart';
import 'model/voxel_chunk.dart';

class VoxelBuilder extends StatefulWidget {
  const VoxelBuilder({
    Key? key,
    required this.mesh,
    required this.rotationController,
  }) : super(key: key);
  final VoxelMesh mesh;
  final BoardRotationController rotationController;

  @override
  State<VoxelBuilder> createState() => _VoxelBuilderState();
}

class _VoxelBuilderState extends State<VoxelBuilder> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(builder: (context, snapshot) {
        final perBlockWidth = snapshot.maxWidth / (widget.mesh.maxX + 1);

        final List<_VoxelChild> children = [];
        if (widget.mesh.chunks.isEmpty) {
          for (var block in widget.mesh.blocks) {
            children.add(_VoxelBlock(
                perBlockWidth: perBlockWidth,
                block: block,
                boardRotationController: widget.rotationController));
          }
        } else {
          for (var block in widget.mesh.chunks) {
            children.add(_VoxelChunkBuilder(
                perBlockWidth: perBlockWidth,
                color: Color(int.parse(block.chunkValue, radix: 16)),
                // material.Colors.accents[
                //     Random().nextInt(material.Colors.accents.length - 1)],
                chunk: block,
                boardRotationController: widget.rotationController));
          }
        }
        return DepthResolver(
          rotationController: widget.rotationController,
          objects: children,
        );
        // return Stack(
        //   children: children,
        // );
        // return DepthBuilder(
        //     rotationController: widget.rotationController,
        //     builder: (context, original) {
        //       final offset = original.clamp(BoardRotationController.minAngle,
        //           BoardRotationController.maxAngle);
        //       final angleY = (offset.dy);
        //       final angleX = (offset.dx);
        //       final cameraMatrix = Matrix4.identity()
        //         // ..translate(width, height, 0)
        //         ..multiply(Matrix4.identity()
        //           ..setEntry(3, 2, perspective)
        //           ..rotateX(angleY)
        //           ..rotateY(angleX));
        //       // final start = DateTime.now();

        //       // final sorted = []createZOrder(children, cameraMatrix);

        //       List<Widget> sortedBlocks = children;
        //       // dev.log("Z Order => $sorted");

        //       // for (var i in sorted) {
        //       //   sortedBlocks.add(children[i]);
        //       // }
        //       // final end = DateTime.now();
        //       // log("$start to $end => ${end.difference(start)} for ${sortedBlocks.length}");
        //       return Stack(
        //         children: sortedBlocks,
        //       );
        //     });
      }),
    );
  }

  // List<int> createZOrder(
  //   List<_VoxelChild> _positions,
  //   Matrix4 matrix,
  // ) {
  //   final renderOrder = <int, double>{};
  //   final pos = Vector3.zero();
  //   for (int i = 0; i < _positions.length; i++) {
  //     var tmp = matrix.multiplied(_positions[i].transform);
  //     pos.x = _positions[i].center.dx * 1.0;

  //     /// Side
  //     pos.y = _positions[i].center.dy * 1.0;

  //     /// Side
  //     pos.z = _positions[i].z;
  //     var t = tmp.transform3(pos).z;
  //     renderOrder[i] = t;
  //   }

  //   return renderOrder.keys.toList(growable: false)
  //     ..sort((a, b) => renderOrder[b]!.compareTo(renderOrder[a]!));
  // }
}

mixin _VoxelChild on DepthObject {
  Matrix4 get transform;
  Offset get center;
  @override
  double get centerX => center.dx;
  @override
  double get centerY => center.dy;

  @override
  get centerZ => z;
  double get z;
}

class _VoxelChunkBuilder extends StatelessWidget with DepthObject, _VoxelChild {
  const _VoxelChunkBuilder({
    Key? key,
    required this.perBlockWidth,
    required this.chunk,
    required this.color,
    required this.boardRotationController,
  }) : super(key: key);
  final double perBlockWidth;
  final VoxelChunk chunk;
  final Color color;
  @override
  Offset get center => Offset(
        chunk.end.x * 1.0, // chunk.start.x * 1.0 + chunk.width / 2,
        chunk.end.y * 1.0, // chunk.start.y * 1.0 + chunk.height / 2,
      );
  final BoardRotationController boardRotationController;

  @override
  Matrix4 get transform => Matrix4.identity()
    ..translate(
      perBlockWidth * chunk.start.x - perBlockWidth / 2,
      perBlockWidth * chunk.start.y - perBlockWidth / 2,
      // -perBlockWidth * (chunk.start.z),
    );

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: transform,
      child: CustomCube(
        width: perBlockWidth * chunk.width,
        height: perBlockWidth * chunk.height,
        depth: perBlockWidth * chunk.depth,
        depthOffset: -perBlockWidth * chunk.start.z, //(perBlockWidth),
        // showCubeFace: ShowCubeFace(
        //   topFace: block.visibleFaces.top,
        //   downFace: block.visibleFaces.down,
        //   upFace: block.visibleFaces.up,
        //   leftFace: block.visibleFaces.left,
        //   rightFace: block.visibleFaces.right,
        // ),
        faceWidgets: CubeFaceWidgets.all((context, size) => Container(
            color: color // Color(int.parse(chunk.chunkValue, radix: 16)),
            )),
        boardRotaioncontroller: boardRotationController,
      ),
    );
  }

  @override
  double get z => -(chunk.end.z * 1.0); //- perBlockWidth * (chunk.height / 2);
}

class _VoxelBlock extends StatelessWidget with DepthObject, _VoxelChild {
  const _VoxelBlock({
    Key? key,
    required this.perBlockWidth,
    required this.block,
    required this.boardRotationController,
  }) : super(key: key);
  final double perBlockWidth;
  @override
  Offset get center => Offset(block.x * 1.0, block.y * 1.0);
  @override
  double get z => block.z * -1.0;
  final VoxelBlock block;
  final BoardRotationController boardRotationController;

  @override
  Matrix4 get transform => Matrix4.identity()
    ..translate(
      perBlockWidth * block.y - perBlockWidth / 2,
      perBlockWidth * block.x - perBlockWidth / 2,
      -perBlockWidth * (block.z),
    );
  @override
  Widget build(BuildContext context) {
    return Container(
      transform: transform,
      child: CustomCube(
        width: perBlockWidth,
        height: perBlockWidth,
        depth: perBlockWidth,
        depthOffset: (perBlockWidth),
        showCubeFace: ShowCubeFace(
          topFace: block.visibleFaces.top,
          downFace: block.visibleFaces.down,
          upFace: block.visibleFaces.up,
          leftFace: block.visibleFaces.left,
          rightFace: block.visibleFaces.right,
        ),
        faceWidgets: CubeFaceWidgets.all((context, size) => Container(
              color: Color(int.parse(block.color, radix: 16)),
            )),
        boardRotaioncontroller: boardRotationController,
      ),
    );
  }
}

// class Combiner {
//   void combine(VoxelMesh mesh) {
//     Map<String, List<VoxelBlock>> colorGroup = {};

//     Map<int, List<VoxelBlock>> group = {};
//     final vertexGrouping = List<List<int>>.filled(
//         mesh.maxX + 1, List<int>.filled(mesh.maxY + 1, -1));

//     int startingX = double.maxFinite.toInt();
//     int startingY = double.maxFinite.toInt();

//     final blockLayout = List<List<List<VoxelBlock?>>>.filled(
//         mesh.maxX + 1,
//         List<List<VoxelBlock?>>.filled(
//             mesh.maxY + 1, List<VoxelBlock?>.filled(mesh.maxZ + 1, null)));

//     for (var item in mesh.blocks) {}
//   }

//   List<VoxelBlock> getAdjecentSimilar(
//       List<List<List<VoxelBlock?>>> pointCloud, VoxelBlock current) {
//     List<VoxelBlock> nearby = [];

//     if (pointCloud[current.x][current.y][current.z - 1] != null &&
//         pointCloud[current.x][current.y][current.z - 1]!.color ==
//             current.color) {
//       nearby.add(pointCloud[current.x][current.y][current.z - 1]!);
//       nearby.addAll(getAdjecentSimilar(
//         pointCloud,
//         pointCloud[current.x][current.y][current.z - 1]!,
//       ));
//     }
//     if (pointCloud[current.x][current.y][current.z + 1] != null &&
//         pointCloud[current.x][current.y][current.z + 1]!.color ==
//             current.color) {
//       nearby.add(pointCloud[current.x][current.y][current.z + 1]!);
//       nearby.addAll(getAdjecentSimilar(
//         pointCloud,
//         pointCloud[current.x][current.y][current.z - 1]!,
//       ));
//     }
//     if (pointCloud[current.x][current.y - 1][current.z] != null &&
//         pointCloud[current.x][current.y - 1][current.z]!.color ==
//             current.color) {
//       nearby.add(pointCloud[current.x][current.y - 1][current.z]!);
//       nearby.addAll(getAdjecentSimilar(
//         pointCloud,
//         pointCloud[current.x][current.y][current.z - 1]!,
//       ));
//     }
//     if (pointCloud[current.x][current.y + 1][current.z] != null &&
//         pointCloud[current.x][current.y + 1][current.z]!.color ==
//             current.color) {
//       nearby.add(pointCloud[current.x][current.y + 1][current.z]!);
//       nearby.addAll(getAdjecentSimilar(
//         pointCloud,
//         pointCloud[current.x][current.y][current.z - 1]!,
//       ));
//     }
//     if (pointCloud[current.x - 1][current.y][current.z] != null &&
//         pointCloud[current.x - 1][current.y][current.z]!.color ==
//             current.color) {
//       nearby.add(pointCloud[current.x - 1][current.y][current.z]!);
//       nearby.addAll(getAdjecentSimilar(
//         pointCloud,
//         pointCloud[current.x][current.y][current.z - 1]!,
//       ));
//     }
//     if (pointCloud[current.x + 1][current.y][current.z] != null &&
//         pointCloud[current.x + 1][current.y][current.z]!.color ==
//             current.color) {
//       nearby.add(pointCloud[current.x + 1][current.y][current.z]!);
//       nearby.addAll(getAdjecentSimilar(
//         pointCloud,
//         pointCloud[current.x][current.y][current.z - 1]!,
//       ));
//     }
//     return nearby;
//   }
// }
