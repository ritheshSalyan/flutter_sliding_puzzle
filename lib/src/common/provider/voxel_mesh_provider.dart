import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/helper/voxel/model/magica_voxel_factory.dart';
import 'package:sliding_puzzle/helper/voxel/model/voxel_mesh.dart';
import 'package:sliding_puzzle/helper/voxel/parser/voxlib/input_stream.dart';

import '../../../helper/voxel/parser/voxlib/vox_reader.dart';

class MeshProvider {
  static final provider =
      FutureProvider.family<VoxelMesh, String>((ref, String assetPath) async {
    var bytes = await rootBundle.load(assetPath);
    return compute(generateMesh, bytes.buffer.asUint8List());
  });

  static VoxelMesh generateMesh(Uint8List bytes) {
    final file = MagicaVoxReader(
            InputStream(bytes.buffer.asByteData(), "All File content: "))
        .read();

    //  final palette = file.getPalette();
    //  for (var model in file.getModelInstances()) {
    //    model.model.voxels
    //  }
    final mesh = MagicaVoxelFactory(file).construct(); //
    return mesh;
    // MagicaVoxelFactory(file)
  }
}
