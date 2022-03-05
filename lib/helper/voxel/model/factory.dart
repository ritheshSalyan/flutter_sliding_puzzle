import 'dart:developer';

import 'package:sliding_puzzle/helper/voxel/model/voxel_block.dart';
import 'package:sliding_puzzle/helper/voxel/model/voxel_mesh.dart';

import '../parser/optimizer/greedy_meshing.dart';

class VoxelMeshFactory {
  final String text;

  VoxelMeshFactory(this.text);

  VoxelMesh construct() {
    final List<String> lines = text.split("\n");
    final List<VoxelBlock> blocks = [];
    int maxX = -1;
    int maxY = -1;
    int maxZ = -1;
    int minX = 999;
    int minY = 999;
    int minZ = 999;
    for (var line in lines) {
      final elements = line.split(" ");

      if (elements.length == 4) {
        final x = int.tryParse(elements[0]);
        final y = int.tryParse(elements[1]);
        final z = int.tryParse(elements[2]);
        final color = "FF" + elements[3];
        if (x != null && y != null && z != null && color.length > 2) {
          blocks.add(VoxelBlock(
              x: x, y: y, z: z, color: color, visibleFaces: VisibleFaces()));

          if (maxX < x) {
            maxX = x;
          }
          if (maxY < y) {
            maxY = y;
          }
          if (maxZ < z) {
            maxZ = z;
          }
          if (minX > x) {
            minX = x;
          }
          if (minY > y) {
            minY = y;
          }
          if (minZ > z) {
            minZ = z;
          }
        }
      }
    }
    List<VoxelBlock> shiftedBlocks = [];
    if (minX < 0 || minY < 0 || minZ < 0) {
      ///
      ///
      /// Shifting everything to positive side
      ///
      ///
      for (var item in blocks) {
        shiftedBlocks.add(
          item.copyWith(
            x: minX < 0 ? minX.abs() + item.x : item.x,
            y: minY < 0 ? minY.abs() + item.y : item.y,
            z: minZ < 0 ? minZ.abs() + item.z : item.z,
          ),
        );
      }

      maxX = minX < 0 ? minX.abs() + maxX : maxX;
      maxY = minY < 0 ? minY.abs() + maxY : maxY;
      maxZ = minZ < 0 ? minZ.abs() + maxZ : maxZ;
    } else {
      shiftedBlocks.addAll(blocks);
    }
    // List<List<List<VoxelBlock?>>> blocksGridMatrix = List.generate(
    //     maxZ + 2,
    //     (i) => List.generate(
    //             maxY + 2,
    //             (index) =>
    //                 List<VoxelBlock?>.generate(maxX + 2, (i) => null).toList())
    //         .toList());
    // List<VoxelBlock> visibleBlocks = [];

    // List<List<List<VoxelBlock?>>> visibleblocksGridMatrix = List.generate(
    //   maxZ + 2,
    //   (i) => List.generate(
    //     maxY + 2,
    //     (index) => List<VoxelBlock?>.generate(
    //       maxX + 2,
    //       (i) => null,
    //     ),
    //   ),
    // );
    // for (var block in blocks) {
    //   blocksGridMatrix[block.z][block.y][block.x] = block;
    // }
    // for (var block in blocks) {
    //   final updated = _updateFaceCover(blocksGridMatrix, block);
    //   if (!updated.visibleFaces.isCompletelyCovered) {
    //     visibleBlocks.add(updated);
    //     visibleblocksGridMatrix[block.z][block.y][block.x] = updated;
    //   }
    // }

    return VoxelMesh(
        blocks: blocks,
        maxX: maxX,
        maxY: maxY,
        maxZ: maxZ,
        chunks: ReducingAlgorithm(blocks).construct());
  }

  // List<List<VoxelBlock>> _groupInXAxis(List<VoxelBlock?> blocks) {}

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


class VoxelVertex {
  final VoxelBlock block;
  bool isVisited = false;

  VoxelVertex(this.block);
  void markIncluded() {
    isVisited = true;
  }
}

class BlockChunkPlane {
  final List<BlockChunkLine> rows = [];

  BlockChunkLine? lowestLine;
  BlockChunkLine? endLine;

  String? chunkValue;

  bool canAddLine(BlockChunkLine line) {
    if (chunkValue == null) return true;
    if (lowestLine == null || endLine == null) return true;
    if ((line.endA!.isAdjecentOnY(lowestLine!.endA!) &&
            line.endB!.isAdjecentOnY(lowestLine!.endB!)) ||
        (line.endA!.isAdjecentOnY(endLine!.endA!) &&
            line.endB!.isAdjecentOnY(endLine!.endB!))) {
      return line.chunkValue == chunkValue;
    }
    return false;
  }

  void addLine(BlockChunkLine line) {
    final canAdd = canAddLine(line);
  }
}

class BlockChunkLine {
  final List<VoxelBlock> blocks = [];

  VoxelBlock? endA;
  VoxelBlock? endB;
  String? chunkValue;
  bool canAddBlock(VoxelBlock block) {
    if (chunkValue == null) return true;
    if (endA == null || endB == null) return true;

    return (endA!.isAdjecentOnX(block) || endA!.isAdjecentOnX(block)) &&
        (chunkValue == block.color);
  }

  void addBlock(VoxelBlock block) {
    bool canAdd = canAddBlock(block);
    if (!canAdd) return;

    blocks.add(block);

    endA = blocks.fold(
        (endA ?? blocks.first),
        (previousValue, element) =>
            previousValue!.x < element.x ? previousValue : element);
    endB = blocks.fold(
        (endB ?? blocks.first),
        (previousValue, element) =>
            previousValue!.x > element.x ? previousValue : element);
    // log("End A= ${endA?.x}   End B= ${endB?.x}");
  }
}

extension BlockUtils on VoxelBlock {
  bool isAdjecentOnX(VoxelBlock block) {
    return isSameYAxis(block) &&
        isSameZAxis(block) &&
        (block.x == x - 1 || block.x == x + 1);
  }

  bool isAdjecentOnY(VoxelBlock block) {
    return isSameXAxis(block) &&
        isSameZAxis(block) &&
        (block.y == y - 1 || block.y == y + 1);
  }

  bool isAdjecentOnZ(VoxelBlock block) {
    return isSameYAxis(block) &&
        isSameXAxis(block) &&
        (block.z == z - 1 || block.z == z + 1);
  }

  bool isSameXAxis(VoxelBlock block) {
    return block.x == x;
  }

  bool isSameYAxis(VoxelBlock block) {
    return block.y == y;
  }

  bool isSameZAxis(VoxelBlock block) {
    return block.z == z;
  }
}
