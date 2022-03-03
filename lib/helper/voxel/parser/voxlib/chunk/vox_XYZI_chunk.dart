 import '../stream_utils.dart';
import '../voxel.dart';
import 'chunk_factory.dart';
import 'vox_chunk.dart';

class VoxXYZIChunk extends VoxChunk {
	
     final List<Voxel> voxels;

    //  VoxXYZIChunk(): super(ChunkFactory.XYZI){
    
    // }

     VoxXYZIChunk([this. voxels = const []]) : super(ChunkFactory.XYZI);

     static VoxXYZIChunk read(InputStream stream) {
        int voxelCount = StreamUtils.readIntLE(stream);
        var chunk = VoxXYZIChunk();
        //System.out.println(voxelCount + " voxels");

        for (int i = 0; i < voxelCount; i++) {
            var position = StreamUtils.readVector3b(stream);
            var colorIndex =  (stream.read() & 0xff);
            chunk.voxels.add( Voxel(position, colorIndex));
        }
        return chunk;
    }

     List<Voxel> getVoxels() {
        return voxels;
    }

@override
  void writeContent(OutputStream stream)  {
        StreamUtils.writeIntLE(voxels.length, stream);
        for (var voxel in voxels) {
            StreamUtils.writeVector3b(voxel.getPosition(), stream);
            stream.write(voxel.getColourIndex());
        }
    }
}
