import 'package:sliding_puzzle/helper/voxel/model/voxel_block.dart';
import 'package:sliding_puzzle/helper/voxel/model/voxel_mesh.dart';

class VoxelMeshFactory {
  final String text;

  VoxelMeshFactory(this.text);

  VoxelMesh construct() {
    final List<String> lines = text.split("\n");
    final List<VoxelBlock> blocks = [];
    int maxX = -1;
    int maxY = -1;
    int maxZ = -1;
    for (var line in lines) {
      final elements = line.split(" ");

      if (elements.length == 4) {
        final x = int.tryParse(elements[0])?.abs();
        final y = int.tryParse(elements[1])?.abs();
        final z = int.tryParse(elements[2])?.abs();
        final color = "FF" + elements[3];
        if (x != null && y != null && z != null && color.length > 2) {
          blocks.add(VoxelBlock(
              x: x,
              y: y.abs(),
              z: z.abs(),
              color: color,
              visibleFaces: VisibleFaces()));

          if (maxX < x) {
            maxX = x + 1;
          }
          if (maxY < y) {
            maxY = y + 1;
          }
          if (maxZ < z) {
            maxZ = z + 1;
          }
        }
      }
    }
    List<List<List<VoxelBlock?>>> blocksGridMatrix = List.generate(
        maxZ + 2,
        (i) => List.generate(
                maxY + 2,
                (index) =>
                    List<VoxelBlock?>.generate(maxX + 2, (i) => null).toList())
            .toList());
    List<VoxelBlock> visibleBlocks = [];

    for (var block in blocks) {
      blocksGridMatrix[block.z][block.y][block.x] = block;
    }
    for (var block in blocks) {
      final updated = _updateFaceCover(blocksGridMatrix, block);
      if (!updated.visibleFaces.isCompletelyCovered) {
        visibleBlocks.add(updated);
      }
    }
    return VoxelMesh(blocks: visibleBlocks, maxX: maxX, maxY: maxY, maxZ: maxZ);
  }

  VoxelBlock _updateFaceCover(
      List<List<List<VoxelBlock?>>> blocksGridMatrix, VoxelBlock block) {
    VisibleFaces visibleFaces = block.visibleFaces;

    if (block.x > 0 &&
        blocksGridMatrix[block.z][block.y][block.x - 1] != null) {
      visibleFaces = visibleFaces.copyWith(
        up: false,
      );
    }
    if (blocksGridMatrix[block.z][block.y][block.x + 1] != null) {
      visibleFaces = visibleFaces.copyWith(
        down: false,
      );
    }

    if (block.y > 0 &&
        blocksGridMatrix[block.z][block.y - 1][block.x] != null) {
      visibleFaces = visibleFaces.copyWith(
        left: false,
      );
    }
    if (blocksGridMatrix[block.z][block.y + 1][block.x] != null) {
      visibleFaces = visibleFaces.copyWith(
        right: false,
      );
    }

    // if (block.z > 0 &&
    //     blocksGridMatrix[block.x][block.y][block.z - 1] != null) {
    //   visibleFaces = visibleFaces.copyWith(
    //     bottom: false,
    //   );
    // }
    if (blocksGridMatrix[block.z + 1][block.y][block.x] != null) {
      visibleFaces = visibleFaces.copyWith(
        top: false,
      );
    }

    return block.copyWith(visibleFaces: visibleFaces);
  }
}
