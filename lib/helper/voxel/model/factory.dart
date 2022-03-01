import 'dart:developer';

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

class ReducingAlgorithm {
  final Map<int, Map<int, Map<int, VoxelVertex>>> blockGrid = {};
  int startingX = 9999;
  int startingY = 9999;
  int startingZ = 9999;

  int maxX = -1;
  int maxY = -1;
  int maxZ = -1;
  ReducingAlgorithm(List<VoxelBlock> blocks) {
    for (var block in blocks) {
      blockGrid[block.z] ??= {};
      blockGrid[block.z]![block.y] ??= {};
      blockGrid[block.z]![block.y]![block.x] = VoxelVertex(block);

      if (block.x < startingX) {
        startingX = block.x;
      }
      if (block.y < startingY) {
        startingY = block.y;
      }
      if (block.z < startingZ) {
        startingZ = block.z;
      }

      if (block.x >= maxX) {
        maxX = block.x + 1;
      }
      if (block.y >= maxY) {
        maxY = block.y + 1;
      }
      if (block.z >= maxZ) {
        maxZ = block.z + 1;
      }
    }
  }

  List<VoxelChunk> construct() {
    List<VoxelChunk> chunks = [];
    VoxelVertex? start;
    VoxelVertex? end;
    int x = startingX - 1;
    int y = startingY;
    int z = startingZ;

    for (; z < maxZ + 1;) {
      start = null;
      for (var interZ = z; interZ < maxZ && start == null; interZ++) {
        for (var interY = startingY; interY < maxY && start == null; interY++) {
          for (var interX = startingX;
              interX < maxX && start == null;
              interX++) {
            final block = blockGrid[interZ]?[interY]?[interX];
            if (block != null && !block.isVisited) start = block;
          }
        }
      }

      if (start == null) break;
      x = start.block.x;
      y = start.block.y;
      z = start.block.z;
      end = start;

      ////
      ///
      /// Expand Via X Axis
      ///
      while (start.block.color == end?.block.color && x < maxX) {
        final newBlock = blockGrid[z]?[y]?[x + 1];

        if (newBlock == null || newBlock.isVisited) break;

        end = newBlock;
        x++;
      }
      ////
      ///
      /// Expand Via Y Axis
      ///
      while (start.block.color == end?.block.color && y < maxY) {
        bool isAccepted = true;
        for (var interX = start.block.x; interX < x + 1; interX++) {
          final intermeidateBlock = blockGrid[z]?[y + 1]?[interX];
          if (intermeidateBlock == null ||
              intermeidateBlock.block.color != start.block.color ||
              intermeidateBlock.isVisited) {
            isAccepted = false;
            break;
          }
        }

        if (isAccepted) {
          end = blockGrid[z]?[y + 1]?[x] ?? end;
          y++;
        } else {
          // end = blockGrid[z]?[y]?[x] ?? end;

          break;
        }
      }

      ////
      ///
      /// Expand Via Z Axis
      ///
      while (start.block.color == end?.block.color && z < maxZ) {
        bool isAccepted = true;

        for (var interY = start.block.y; interY < y + 1; interY++) {
          for (var interX = start.block.x; interX < x + 1; interX++) {
            final intermeidateBlock = blockGrid[z + 1]?[interY]?[interX];
            if (intermeidateBlock == null ||
                intermeidateBlock.block.color != start.block.color ||
                intermeidateBlock.isVisited) {
              isAccepted = false;
              break;
            }
          }
          if (!isAccepted) break;
        }

        if (isAccepted) {
          end = blockGrid[z + 1]?[y]?[x] ?? end;
          z++;
        } else {
          break;
        }
      }

      chunks.add(VoxelChunk(start.block, end!.block, start.block.color));
      for (var interZ = start.block.z; interZ < z + 1; interZ++) {
        for (var interY = start.block.y; interY < y + 1; interY++) {
          for (var interX = start.block.x; interX <= x; interX++) {
            log("For Chunk ${start.block} to ${end.block} Containes Vertex => $interX $interY $interZ");
            blockGrid[interZ]?[interY]?[interX]?.markIncluded();
          }
        }
      }
    }

    log(chunks.toString());
    return chunks;
  }

  List<BlockChunkLine> _identify1DChunks(Map<int, VoxelVertex> currentRow) {
    List<BlockChunkLine> chunks = [];
    BlockChunkLine currentChunk = BlockChunkLine();
    for (var vertex in currentRow.values) {
      final block = vertex.block;
      if (currentChunk.canAddBlock(block)) {
        currentChunk.addBlock(block);
      } else {
        chunks.add(currentChunk);
        currentChunk = BlockChunkLine();
        currentChunk.addBlock(block);
      }
    }
    if (currentChunk.blocks.isNotEmpty) {
      chunks.add(currentChunk);
    }

    return chunks;
  }
}

class VoxelChunk {
  final VoxelBlock start;
  final VoxelBlock end;
  final String chunkValue;
  VoxelChunk(
    this.start,
    this.end,
    this.chunkValue,
  );

  int get width => end.x - start.x + 1;
  int get height => end.y - start.y + 1;
  int get depth => end.z - start.z + 1;

  @override
  String toString() =>
      'VoxelChunk(start: $start, end: $end, chunkValue: $chunkValue)';
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
