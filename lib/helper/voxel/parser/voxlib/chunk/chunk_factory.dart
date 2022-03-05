

 import 'dart:developer';

import '../input_stream.dart';
import 'voxMATLChunk.dart';
import 'voxMATTChunk.dart';
import 'voxRootChunk.dart';
import 'vox_RGBA_chunk.dart';
import 'vox_XYZI_chunk.dart';
import 'vox_chunk.dart';
import 'vox_dummy_chunk.dart';
import 'vox_group_chunk.dart';
import 'vox_layer_chunk.dart';
import 'vox_pack_chunk.dart';
import 'vox_shape_chunk.dart';
import 'vox_size_chunk.dart';
import 'vox_transform_chunk.dart';

class ChunkFactory {

	 static const String MAIN = "MAIN"; 
	 static const String PACK = "PACK"; 
	 static const String SIZE = "SIZE"; 
	 static const String XYZI = "XYZI"; 
	 static const String RGBA = "RGBA"; 
	 static const String MATL = "MATL"; 
	 static const String MATT = "MATT"; 
	 static const String nSHP = "nSHP"; 
	 static const String nTRN = "nTRN"; 
	 static const String nGRP = "nGRP"; 
	 static const String LAYR = "LAYR"; 
	
	static Set<String> get supportedTypes  {
	  Set<String> _supportedTypes = {};

		_supportedTypes.add(MAIN);
		_supportedTypes.add(PACK);
		_supportedTypes.add(SIZE);
		_supportedTypes.add(XYZI);
		_supportedTypes.add(RGBA);
		_supportedTypes.add(MATL);
		_supportedTypes.add(nSHP);
		_supportedTypes.add(nTRN);
		_supportedTypes.add(nGRP);
		_supportedTypes.add(LAYR);
    return _supportedTypes;
	}

	 static VoxChunk? createChunk(String type, InputStream stream, InputStream childrenStream){
		VoxChunk? chunk;

		//Settings.p("Reading type " + type);
		
		switch (type) {
		case MAIN:
			chunk = VoxRootChunk.read(childrenStream);
			break;
		case PACK:
			chunk = VoxPackChunk.read(stream);
			break;
		case SIZE:
			chunk = VoxSizeChunk.read(stream);
			break;
		case XYZI:
			chunk = VoxXYZIChunk.read(stream);
			break;
		case RGBA:
			chunk = VoxRGBAChunk.read(stream);
			break;
		case MATT: // Obsolete
			chunk = VoxMATTChunk.read(stream);
			break;
		case MATL:
			chunk = VoxMATLChunk.read(stream);
			break;
			
		case nSHP: // Shape Node Chunk
			chunk = VoxShapeChunk.read(stream);
			break;
			
		case nTRN: // Transform Node Chunk
			chunk = VoxTransformChunk.read(stream);
			break;

		case nGRP: // Group Node Chunk
			chunk = VoxGroupChunk.read(stream);
			break;

		case LAYR:
			chunk = VoxLayerChunk.read(stream);
			break;

			// These chunks are unsupported and simply skipped.
		case "rOBJ":
		case "rCAM":
		case "NOTE":
			chunk = VoxDummyChunk(type);
			break;
			
		default:
			log("Ignoring " + type);
		}

		return chunk;
	}
}
