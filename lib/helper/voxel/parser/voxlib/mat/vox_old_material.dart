

import 'package:flutter/foundation.dart';

import 'vox_old_material_property.dart';
import 'vox_old_material_type.dart';

class VoxOldMaterial {
     final int id;
     final double weight;
     final VoxOldMaterialType type;
     final Map<VoxOldMaterialProperty, double> properties;
     final bool isTotalPower;
  VoxOldMaterial({
    required this.id,
    required this.weight,
    required this.type,
    required this.properties,
    required this.isTotalPower,
  });

    //  VoxOldMaterial(int id, double weight, VoxOldMaterialType type, HashMap<VoxOldMaterialProperty, double> properties, bool isTotalPower) {
    //     if (type == null) {
    //         throw new IllegalArgumentException("type must not be null");
    //     }

    //     this.type = type;

    //     if (properties == null) {
    //         throw new IllegalArgumentException("properties must not be null");
    //     }

    //     this.properties = properties;

    //     if (id < 1 || id > 255) {
    //         throw new IllegalArgumentException("id must be in [1..255]");
    //     }

    //     this.id = id;

    //     if (type == VoxOldMaterialType.DIFFUSE) {
    //         if (weight != 1.0) {
    //             throw new IllegalArgumentException("A diffuse material must have a weight of 1.0");
    //         }
    //     } else {
    //         if (!(weight > 0.0 && weight <= 1.0)) {
    //             throw new IllegalArgumentException("weight must be in (0.0..1.0]");
    //         }
    //     }

    //     this.weight = weight;
    //     this.isTotalPower = isTotalPower;
    // }

     double? getProperty(VoxOldMaterialProperty property) {
        return properties[property];
    }

    //  bool isTotalPower() {
    //     return isTotalPower;
    // }

     int getID() {
        return id;
    }

     double getWeight() {
        return weight;
    }

     VoxOldMaterialType getType() {
        return type;
    }

     Map<VoxOldMaterialProperty, double> getProperties() {
        return properties;
    }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is VoxOldMaterial &&
      other.id == id &&
      other.weight == weight &&
      other.type == type &&
      mapEquals(other.properties, properties) &&
      other.isTotalPower == isTotalPower;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      weight.hashCode ^
      type.hashCode ^
      properties.hashCode ^
      isTotalPower.hashCode;
  }
}
