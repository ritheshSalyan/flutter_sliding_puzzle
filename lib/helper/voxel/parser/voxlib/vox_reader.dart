import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'InvalidVoxException.dart';
import 'chunk/voxRootChunk.dart';
import 'chunk/vox_chunk.dart';
import 'input_stream.dart';
import 'stream_utils.dart';
import 'vox_file.dart';

class VoxReader implements Disposable {
  static const int VERSION = 150;

  static List<int> get MAGIC_BYTES => 'VOX '.codeUnits;

  InputStream stream;
  VoxReader(this.stream);

  VoxFile read() {
    List<int> magicBytes = List.filled(4, -1);
    if (stream.read(magicBytes) != 4) {
      throw InvalidVoxException("Could not read magic bytes");
    }

    if (!listEquals(magicBytes, MAGIC_BYTES)) {
      throw InvalidVoxException("Invalid magic bytes");
    }

    int fileVersion = StreamUtils.readIntLE(stream);

    if (fileVersion < VERSION) {
      throw InvalidVoxException(
        "Vox versions older than $VERSION are not supported",
      );
    }




    VoxChunk? chunk = VoxChunk.readChunk(stream);

    if (chunk == null) {
      throw InvalidVoxException("No root chunk present in the file");
    }

    if (chunk is! VoxRootChunk) {
      throw InvalidVoxException("First chunk is not of ID \"MAIN\"");
    }

    return VoxFile(fileVersion, chunk);
  }

  @override
  void dispose() {
    // stream.close();
  }
}
