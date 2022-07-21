import '../design_patterns/decorator/tile/tile_stack.dart';
import '../design_patterns/decorator/tile/tile_stack_base.dart';
import 'machine.dart';
import 'terrain.dart';
import 'tile_position.dart';

class Tile {
  TilePosition position;
  Terrain terrain;
  Machine? machine;
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

  Tile copyWith({
    TilePosition? position,
    Terrain? terrain,
    Machine? machine,
    TileStack? tileStack,
  }) {
    return Tile(
      position: position ?? this.position,
      terrain: terrain ?? this.terrain,
      machine: machine ?? this.machine,
      tileStack: tileStack ?? this.tileStack,
    );
  }
}
