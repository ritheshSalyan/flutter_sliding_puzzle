 import 'dart:collection';
import 'dart:core';

import '../GridPoint3.dart';
import '../mat/voxMaterial.dart';
import '../mat/vox_old_material.dart';
import '../vox_model_blueprint.dart';
import '../vox_model_instance.dart';
import 'chunk_factory.dart';
import 'voxMATLChunk.dart';
import 'voxMATTChunk.dart';
import 'vox_RGBA_chunk.dart';
import 'vox_XYZI_chunk.dart';
import 'vox_chunk.dart';
import 'vox_group_chunk.dart';
import 'vox_pack_chunk.dart';
import 'vox_shape_chunk.dart';
import 'vox_size_chunk.dart';
import 'vox_transform_chunk.dart';

class VoxRootChunk extends VoxChunk {

	 final HashMap<int, VoxModelBlueprint> models = HashMap<int, VoxModelBlueprint>();
	 final List<VoxModelInstance> model_instances = [];
	 List<int> palette = VoxRGBAChunk.DEFAULT_PALETTE;
	 final HashMap<int, VoxMaterial> materials = HashMap<int, VoxMaterial>();
	 final HashMap<int, VoxOldMaterial> oldMaterials = HashMap<int, VoxOldMaterial>();
	 final HashMap<int, VoxShapeChunk> shapeChunks = HashMap<int, VoxShapeChunk>();
	 final HashMap<int, VoxTransformChunk> transformChunks = HashMap<int, VoxTransformChunk>();
	 final HashMap<int, VoxGroupChunk> groupChunks = HashMap<int, VoxGroupChunk>();
	 VoxTransformChunk? root_transform;
	 GridPoint3? size;
	 final List<VoxChunk> children = [];

	 VoxRootChunk() :
		super(ChunkFactory.MAIN);



	 static VoxRootChunk read(InputStream stream, InputStream childrenStream){
		var root = VoxRootChunk();
		VoxChunk? first = VoxChunk.readChunk(childrenStream);

		if (first is VoxPackChunk) {
			//VoxPackChunk pack = (VoxPackChunk)first;
			//modelCount = pack.getModelCount(); // Ignore this, it is obsolete
			first = null;
		}

		while (childrenStream.available() > 0) {
			VoxChunk chunk1;

			if (first != null) {
				// If first != null, then that means that the first chunk was not a PACK chunk,
				// and we've already read a SIZE chunk.
				chunk1 = first;
				first = null;
			} else {
				chunk1 = VoxChunk.readChunk(childrenStream);
			}
			root.appendChunk(chunk1);

			if (chunk1 is VoxSizeChunk) {
				VoxChunk? chunk2 = VoxChunk.readChunk(childrenStream, ChunkFactory.XYZI);
				root.appendChunk(chunk2);
			}
		}

		// Calc world offset by iterating through the scenegraph
		root.iterateThruScengraph();
		return root;
	}

	 void appendChunk(VoxChunk chunk) {
		children.add(chunk);

		if (chunk is VoxSizeChunk) {
			size = ( chunk).getSize();
		} else if (chunk is VoxXYZIChunk) {
			VoxXYZIChunk xyzi = chunk;
			models.putIfAbsent(
				models.length,
			()=> VoxModelBlueprint(models.length, size!, xyzi.getVoxels())
			);
		} else if (chunk is VoxRGBAChunk) {
			VoxRGBAChunk rgba = chunk;
			palette = rgba.getPalette();
		} else {
			processChunk(chunk);
		}
	}

	 void processChunk(VoxChunk chunk) {
		if (chunk is VoxMATLChunk) {
			VoxMaterial mat = (chunk).getMaterial();
			materials[mat.getID()]=mat;
		} else if (chunk is VoxMATTChunk) {
			VoxOldMaterial mat = ( chunk).getMaterial();
			oldMaterials[mat.getID()]=mat;
		} else if (chunk is VoxShapeChunk) {
			VoxShapeChunk shapeChunk = chunk;
			shapeChunks[shapeChunk.id]= shapeChunk;
		} else if (chunk is VoxTransformChunk) {
			VoxTransformChunk transformChunk = chunk;
			if (transformChunks.isEmpty) {
				root_transform = transformChunk;
			}
			transformChunks[transformChunk.id]= transformChunk;
		} else if (chunk is VoxGroupChunk) {
			VoxGroupChunk groupChunk = chunk;
			groupChunks[groupChunk.id]= groupChunk;
		}
	}

	
	 GridPoint3 findShapeOrGroupParent(int shapeId) {
		GridPoint3 offset = GridPoint3(0, 0, 0);

		for(VoxTransformChunk transformChunk in transformChunks.values) {
			if (transformChunk.child_node_id == shapeId) {
				offset.addGP(transformChunk.transform);
				offset.addGP(findTransformParent(transformChunk.id));
				break;
			}
		}

		return offset;		
	}


	 GridPoint3 findTransformParent(int transformId) {
		GridPoint3 offset = GridPoint3(0, 0, 0);

		for(VoxGroupChunk groupChunk in groupChunks.values) {
			if (groupChunk.child_ids.contains(transformId)) {
				GridPoint3 suboffset = findShapeOrGroupParent(groupChunk.id);
				offset.addGP(suboffset);
				break;
			}
		}

		return offset;		
	}



	 List<VoxModelInstance> getModelInstances() {
		return model_instances;
	}


	 List<int> getPalette() {
		return palette;
	}


	 HashMap<int, VoxMaterial> getMaterials() {
		return materials;
	}


	 HashMap<int, VoxOldMaterial> getOldMaterials() {
		return oldMaterials;
	}


	 void iterateThruScengraph() {
		findTransformParent(root_transform!.id);
		processTransformChunk(root_transform!, root_transform!.transform);
	}


	 void processTransformChunk(VoxTransformChunk transformChunk, GridPoint3 pos) {
		GridPoint3 newPos = GridPoint3.fromPoints(pos);
		if (groupChunks.containsKey(transformChunk.child_node_id)) {
			processGroupChunk(groupChunks[transformChunk.child_node_id]!, newPos);
		} else if (shapeChunks.containsKey(transformChunk.child_node_id)) {
			processShapeChunk(shapeChunks[transformChunk.child_node_id]!, newPos);
		}
	}


	 void processGroupChunk(VoxGroupChunk groupChunk, GridPoint3 pos) {
		for (int childId in groupChunk.child_ids) {
			VoxTransformChunk trn = transformChunks.get(childId);
			GridPoint3 newPos = GridPoint3.fromPoints(pos);
			newPos.addGP(trn.transform);
			processTransformChunk(trn, newPos);
		}
	}


	 void processShapeChunk(VoxShapeChunk shapeChunk, GridPoint3 pos) {
		for (int modelId in shapeChunk.model_ids) {
			VoxModelBlueprint model = models.get(modelId);
			if (model.getVoxels().isNotEmpty) {
				VoxModelInstance instance = VoxModelInstance(model, GridPoint3.fromPoints(pos));
				model_instances.add(instance);
			}
		}
	}

	@override
writeChildren(OutputStream stream)  {
		for (var chunk in children) {
			if (ChunkFactory.supportedTypes.contains(chunk.getType())) {
				chunk.writeTo(stream);
			}
		}
	}
}

extension HashmapExtension<K,V> on HashMap<K,V>{
  V get(K key) =>this[key]!;
}