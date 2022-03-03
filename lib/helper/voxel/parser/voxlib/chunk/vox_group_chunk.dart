

  import '../stream_utils.dart';
import 'chunk_factory.dart';
import 'vox_chunk.dart';

class VoxGroupChunk extends VoxChunk {
	
	 final int id;
	 List<int> child_ids = [];

     VoxGroupChunk(this.id) :super(ChunkFactory.nGRP);

     static VoxGroupChunk read(InputStream stream) {
        var id = StreamUtils.readIntLE(stream);
        var chunk = new VoxGroupChunk(id);
        Map<String, String> dict = StreamUtils.readDictionary(stream);
        /*if (dict.size() > 0) {
    		Settings.p("dict=" + dict);
        }*/
        int num_children = StreamUtils.readIntLE(stream);

        for (int i=0 ; i<num_children ; i++) {
            int child_id = StreamUtils.readIntLE(stream);
            chunk.child_ids.add(child_id);
        }
        return chunk;
    }

 @override
  void writeContent(OutputStream stream) 
  {
        StreamUtils.writeIntLE(id, stream);
        StreamUtils.writeIntLE(0, stream); // dict
        StreamUtils.writeIntLE(child_ids.length, stream);
        for (var childId in child_ids) StreamUtils.writeIntLE(childId, stream);
    }
}
