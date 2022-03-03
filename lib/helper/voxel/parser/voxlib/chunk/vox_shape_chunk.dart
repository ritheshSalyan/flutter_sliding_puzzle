import 'dart:collection';

import '../stream_utils.dart';
import 'chunk_factory.dart';
import 'vox_chunk.dart';

class VoxShapeChunk extends VoxChunk {
	
	 final int id;
	 List<int> model_ids = <int>[];

     VoxShapeChunk(this. id) :
        super(ChunkFactory.nSHP);


     static VoxShapeChunk read(InputStream stream) {
        var id = StreamUtils.readIntLE(stream);
        var chunk = VoxShapeChunk(id);

        HashMap<String, String> dict = StreamUtils.readDictionary(stream);
        /*if (dict.size() > 0) {
    		Settings.p("dict=" + dict);
        }*/

        int numModels = StreamUtils.readIntLE(stream);

        for (int i=0 ; i<numModels ; i++) {
            int modelId = StreamUtils.readIntLE(stream);
            HashMap<String, String> modelDict = StreamUtils.readDictionary(stream);
            /*if (model_dict.size() > 0) {
        		Settings.p("model_dict=" + dict);
            }*/

            chunk.model_ids.add(modelId);
        }
        return chunk;
	}

@override
  void writeContent(OutputStream stream)  {
        StreamUtils.writeIntLE(id, stream);
        StreamUtils.writeIntLE(0, stream); // dict
        StreamUtils.writeIntLE(model_ids.length, stream);
        for (var modelId in model_ids) {
            StreamUtils.writeIntLE(modelId, stream);
            StreamUtils.writeIntLE(0, stream); // dict
        }
    }
}
