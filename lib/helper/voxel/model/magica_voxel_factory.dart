import 'dart:developer';

import 'package:sliding_puzzle/helper/voxel/model/voxel_block.dart';
import 'package:sliding_puzzle/helper/voxel/parser/voxlib/voxel.dart';

import '../parser/optimizer/greedy_meshing.dart';
import '../parser/voxlib/vox_file.dart';
import 'voxel_mesh.dart';

class MagicaVoxelFactory {
  final VoxFile file;

  MagicaVoxelFactory(this.file);
  int maxX = -1;
  int maxY = -1;
  int maxZ = -1;
  int minX = 999;
  int minY = 999;
  int minZ = 999;
  VoxelMesh construct() {
    List<VoxelBlock> blocks = [];

    final colors = file.getMaterials();
    log(colors.toString());
    var modelInstances = file.getModelInstances();
    for (var model in modelInstances) {
      var voxels2 = model.model.voxels;
      _buildVoxel(voxels2, blocks);
    }
    for (var model in file.root.models.values) {
      _buildVoxel(model.voxels, blocks);
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

    var construct = ReducingAlgorithm(shiftedBlocks).construct();
    return VoxelMesh(
        blocks: blocks, maxX: maxX, maxY: maxY, maxZ: maxZ, chunks: construct);
  }

  void _buildVoxel(List<Voxel> voxels2, List<VoxelBlock> blocks) {
    log(voxels2.length.toString());
    for (var voxel in voxels2) {
      final x = voxel.position.x;
      final y = voxel.position.y;
      final z = voxel.position.z;
      // const color = "FFFFFFFF";
      final color = "FF" +
          file
              .getPalette()[voxel.colourIndex]
              .toRadixString(16)
              .padLeft(6, "0"); //"FF" + elements[3];
      if (color.length > 2) {
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
}
