import 'package:flutter/foundation.dart';

class VoxMaterial {
  final int id;
  final Map<String, String> properties;

  VoxMaterial(this.id, this.properties);

  int getID() {
    return id;
  }

  Map<String, String> getProps() {
    return properties;
  }

  String? getString(String property) {
    return properties[property];
  }

  int? getInt(String property) {
    return int.tryParse(getString(property) ?? "");
  }

  double? getFloat(String property) {
    return double.tryParse(getString(property) ?? "");
  }

  bool hasProperty(String property) {
    return properties.containsKey(property);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VoxMaterial &&
        other.id == id &&
        mapEquals(other.properties, properties);
  }

  @override
  int get hashCode => id.hashCode ^ properties.hashCode;
}
