import 'dart:developer';

import 'package:sliding_puzzle/helper/voxel/model/factory.dart';

import '../../model/voxel_block.dart';
import '../../model/voxel_chunk.dart';

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
    int x = startingX;
    int y = startingY;
    int z = startingZ;

    for (; z < maxZ + 1;) {
      start = null;
      for (var interZ = startingZ; interZ < maxZ && start == null; interZ++) {
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

        if (newBlock == null ||
            newBlock.isVisited ||
            newBlock.block.color != start.block.color) break;

        end = newBlock;
        x = end.block.x;
      }
      ////
      ///
      /// Expand Via Y Axis
      ///
      while (start.block.color == end!.block.color && y < maxY) {
        bool isAccepted = true;

        ///
        ///Check whether we can accept current Row
        ///
        for (var interX = start.block.x; interX < end.block.x + 1; interX++) {
          final intermeidateBlock = blockGrid[z]?[y]?[interX];

          if (intermeidateBlock == null ||
              intermeidateBlock.block.color != start.block.color ||
              intermeidateBlock.isVisited) {
            isAccepted = false;
            break;
          }
        }

        if (isAccepted) {
          ///
          /// If we can accept current row, shift the end.
          ///
          end = blockGrid[z]?[y]?[end.block.x] ?? end;
          y++;
        } else {
          x = end.block.x;
          y = end.block.y;

          break;
        }
      }

      ////
      ///
      /// Expand Via Z Axis
      ///
      while (start.block.color == end!.block.color && z < maxZ) {
        bool isAccepted = true;

        for (var interY = start.block.y; interY < end.block.y + 1; interY++) {
          for (var interX = start.block.x; interX < end.block.x + 1; interX++) {
            final intermeidateBlock = blockGrid[z]?[interY]?[interX];
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
          end = blockGrid[z]?[y]?[x] ?? end;
          z++;
        } else {
          x = end.block.x;
          y = end.block.y;
          z = end.block.z;
          break;
        }
      }

      chunks.add(VoxelChunk(start.block, end.block, start.block.color));
      for (var interZ = start.block.z; interZ <= end.block.z; interZ++) {
        for (var interY = start.block.y; interY <= end.block.y; interY++) {
          for (var interX = start.block.x; interX <= end.block.x; interX++) {
            blockGrid[interZ]?[interY]?[interX]?.markIncluded();
          }
        }
      }
    }

    log(chunks.toString());
    return chunks;
  }
}
