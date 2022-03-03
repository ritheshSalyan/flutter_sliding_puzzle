import 'GridPoint3.dart';
import 'vox_model_blueprint.dart';

class VoxModelInstance {
  late final int id;
  static int next_id = 0;

  final VoxModelBlueprint model;
  final GridPoint3 worldOffset;

  VoxModelInstance(this.model, this.worldOffset) {
    id = next_id++;
  }

  @override
  String toString() {
    return "ModelInstance#" "$id" "_" + worldOffset.toString();
  }
}
