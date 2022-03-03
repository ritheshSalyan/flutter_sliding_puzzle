import 'dart:collection';
import 'dart:developer';

import '../GridPoint3.dart';
import '../stream_utils.dart';
import 'chunk_factory.dart';
import 'vox_chunk.dart';

class VoxTransformChunk extends VoxChunk {
  final int id;
  int child_node_id = -1;
  GridPoint3 transform = GridPoint3();

  VoxTransformChunk(this.id) : super(ChunkFactory.nTRN);

  static VoxTransformChunk read(InputStream stream) {
    var id = StreamUtils.readIntLE(stream);
    var chunk = VoxTransformChunk(id);
    HashMap<String, String> dict = StreamUtils.readDictionary(stream);
    /*if (dict.containsKey("_name")) {
			Settings.p("nTrn Name: " + dict.get("_name"));
		}*/
    // todo - check for "_hidden"
    chunk.child_node_id = StreamUtils.readIntLE(stream);
    int neg1 = StreamUtils.readIntLE(stream);
    if (neg1 != -1) {
      throw Exception("neg1 checksum failed");
    }
    int layerId = StreamUtils.readIntLE(stream);
    int numFrames = StreamUtils.readIntLE(stream);

    // Rotation
    for (int i = 0; i < numFrames; i++) {
      HashMap<String, String> rot = StreamUtils.readDictionary(stream);
      if (rot.containsKey("_t")) {
        //Settings.p("Got _t=" + rot.get("_t"));
        final tokens = rot["_t"]!.split(" ");
        GridPoint3 tmp = GridPoint3(
            int.parse(tokens[0]), int.parse(tokens[1]), int.parse(tokens[2]));
        chunk.transform.set(tmp.x, tmp.y, tmp.z);
      }
      if (rot.containsKey("_r")) {
        log("Warning: _r is being ignored");
      }
    }
    return chunk;
  }

  @override
  String toString() {
    return "VoxTransformChunk#" "$id" "_" + transform.toString();
  }

  @override
  void writeContent(OutputStream stream) {
    StreamUtils.writeIntLE(id, stream);
    StreamUtils.writeIntLE(0, stream); // dict
    StreamUtils.writeIntLE(child_node_id, stream);
    StreamUtils.writeIntLE(-1, stream); // neg
    StreamUtils.writeIntLE(0, stream); // layer_id
    if (transform.x != 0 || transform.y != 0 || transform.z != 0) {
      StreamUtils.writeIntLE(1, stream); // frames
      var rot = HashMap<String, String>();
      rot["_t"] = "${transform.x} ${transform.y} ${transform.z}";
      StreamUtils.writeDictionary(rot, stream);
    } else {
      StreamUtils.writeIntLE(0, stream); // frames
    }
  }
}
