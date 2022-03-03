import '../InvalidVoxException.dart';
import '../mat/vox_old_material.dart';
import '../mat/vox_old_material_property.dart';
import '../mat/vox_old_material_type.dart';
import '../stream_utils.dart';
import 'chunk_factory.dart';
import 'vox_chunk.dart';

class VoxMATTChunk extends VoxChunk {
  final VoxOldMaterial material;

  VoxMATTChunk(this.material) : super(ChunkFactory.MATT);

  static VoxMATTChunk read(InputStream stream) {
    int id = StreamUtils.readIntLE(stream);
    int typeIndex = StreamUtils.readIntLE(stream);
    VoxOldMaterialType matType = VoxOldMaterialType.fromIndex(typeIndex);
    double weight = StreamUtils.readFloatLE(stream);
    int propBits = StreamUtils.readIntLE(stream);
    bool isTotalPower = VoxOldMaterialProperty.IS_TOTAL_POWER.isSet(propBits);

    int propCount = propBits.bitLength;

    if (isTotalPower) {
      propCount--; // IS_TOTAL_POWER has no value
    }

    Map<VoxOldMaterialProperty, double> properties = {};

    for (VoxOldMaterialProperty prop in VoxOldMaterialProperty.values) {
      if (prop != VoxOldMaterialProperty.IS_TOTAL_POWER &&
          prop.isSet(propBits)) {
        properties.putIfAbsent(prop, StreamUtils.readFloatLE(stream));
      }
    }

    try {
      var material = VoxOldMaterial(
          id: id,
          weight: weight,
          type: matType,
          properties: properties,
          isTotalPower: isTotalPower);
      return VoxMATTChunk(material);
    } catch (e) {
      throw InvalidVoxException(
        "Material with ID " "$id" " is invalid",
      );
    }
  }

  VoxOldMaterial getMaterial() {
    return material;
  }

  //TODO: write old material, if necessary
}
