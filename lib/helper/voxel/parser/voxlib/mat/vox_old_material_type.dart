enum VoxOldMaterialType {
  DIFFUSE,
  METAL,
  GLASS,
  EMISSIVE,
}

extension MaterialTypeExt on VoxOldMaterialType {
  int getIndex() {
    return index;
  }}

  class VoxOldMaterialTypeHelper{

  static VoxOldMaterialType? fromIndex(int index) {
    const materials = VoxOldMaterialType.values;

    if (index >= 0 && index < materials.length) {
      return materials[index];
    }

    return null;
  }

  static VoxOldMaterialType? parse(String material) {
    VoxOldMaterialType? mat;

    switch (material) {
      case "_diffuse":
        mat = VoxOldMaterialType.DIFFUSE;
        break;
      case "_metal":
        mat = VoxOldMaterialType.METAL;
        break;
      case "_glass":
        mat = VoxOldMaterialType.GLASS;
        break;
      case "_emit":
        mat = VoxOldMaterialType.EMISSIVE;
        break;
    }

    return mat;
  }
}
