import 'dart:math';

import 'package:sliding_puzzle/helper/voxel/model/voxel_block.dart';
import 'package:sliding_puzzle/helper/voxel/parser/voxlib/voxel.dart';

import '../../parser/optimizer/greedy_meshing.dart';
import '../../parser/voxlib/vox_file.dart';
import '../voxel_mesh.dart';

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
    // log(colors.toString());
    var modelInstances = file.getModelInstances();
    if (file.root.models.isEmpty) {
      for (var model in modelInstances) {
        var voxels2 = model.model.voxels;
        maxX = max(model.worldOffset.x, maxX);
        maxY = max(model.worldOffset.y, maxY);
        maxZ = max(model.worldOffset.z, maxZ);
        _buildVoxel(voxels2, blocks);
      }
    } else
    // if (modelInstances.isEmpty) {
    {
      for (var model in file.root.models.values) {
        maxX = max(model.size.x, maxX);
        maxY = max(model.size.y, maxY);
        maxZ = max(model.size.z, maxZ);
        _buildVoxel(model.voxels, blocks);
      }
    }
    // }

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

    var construct = GreedyMeshingAlgorithm(shiftedBlocks).construct();
    return VoxelMesh(
        blocks: blocks, maxX: maxX, maxY: maxY, maxZ: maxZ, chunks: construct);
  }

  void _buildVoxel(List<Voxel> voxels2, List<VoxelBlock> blocks) {
    // log(voxels2.length.toString());
    for (var voxel in voxels2) {
      final x = voxel.position.x;
      final y = voxel.position.y;
      final z = voxel.position.z;

      // const color = "FFFFFFFF";
      final color = getColor(voxel.colourIndex);
      if (color.length > 2) {
        blocks.add(VoxelBlock(
            x: x, y: y, z: z, color: color, visibleFaces: VisibleFaces()));

        if (maxX < x) {
          maxX = x + 1;
        }
        if (maxY < y) {
          maxY = y + 1;
        }
        if (maxZ < z) {
          maxZ = z + 1;
        }
        if (minX > x) {
          minX = x - 1;
        }
        if (minY > y) {
          minY = y - 1;
        }
        if (minZ > z) {
          minZ = z - 1;
        }
      }
    }
  }

  // final Map<int, String> _colors = {};
  String getColor(int value) {
    var palette = file.getPalette()[value];
    return palette;
    // if (_colors[palette] != null) return _colors[palette]!;
    // var palette2 = (palette << 24);

    // final a = (palette >> 24);
    // final r = (palette >> 16);
    // final g = (palette >> 8);
    // final b = (palette);

    // final color =
    //     "FF${r.toString().padLeft(2, "0")}${g.toString().padLeft(2, "0")}${b.toString().padLeft(2, "0")}";
    // _colors[palette] = color;
    // return color;
  }
}
