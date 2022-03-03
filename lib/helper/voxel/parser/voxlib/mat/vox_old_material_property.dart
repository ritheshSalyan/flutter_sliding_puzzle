enum VoxOldMaterialProperty {
  PLASTIC,
  ROUGHNESS,
  SPECULAR,
  IOR,
  ATTENUATION,
  POWER,
  GLOW,
  IS_TOTAL_POWER,
}

extension VoxMatProp on VoxOldMaterialProperty {
  int flag() {
    return 1 << index;
  }

  bool isSet(int flags) {
    int flag1 = flag();
    return (flags & flag1) == flag1;
  }
}
