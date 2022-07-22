import 'package:machinestrike/design_patterns/abstract_factory/imachine_factory.dart';

import '../design_patterns/decorator/tile/tile_stack.dart';
import '../design_patterns/decorator/tile/tile_stack_base.dart';
import 'terrain.dart';
import 'tile_position.dart';

class Tile {
  TilePosition position;
  Terrain terrain;
  IMachineFactory? machine;
  late TileStack tileStack;

  Tile({
    required this.position,
    required this.terrain,
    this.machine,
    TileStack? tileStack,
  }) {
    if (tileStack == null) {
      this.tileStack = TileStackBase(terrain.asset);
    } else {
      this.tileStack = tileStack;
    }
  }

  bool get hasMachine => machine != null;

  Tile copyWith({
    TilePosition? position,
    Terrain? terrain,
    IMachineFactory? machine,
    TileStack? tileStack,
  }) {
    return Tile(
      position: position ?? this.position,
      terrain: terrain ?? this.terrain,
      machine: machine ?? this.machine,
      tileStack: tileStack ?? this.tileStack,
    );
  }

  clear() {
    tileStack = TileStackBase(terrain.asset);
    machine = null;
  }
}
