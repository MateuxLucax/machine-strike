import 'package:machinestrike/model/machine.dart';

import '../design_patterns/abstract_factory/igame_factory.dart';
import '../design_patterns/decorator/tile/tile_stack.dart';
import '../design_patterns/decorator/tile/tile_stack_decorator.dart';
import '../enum/direction.dart';
import '../enum/reachability.dart';
import 'terrain.dart';
import 'tile_position.dart';

class Tile {
  TilePosition position;
  Terrain terrain;
  Machine? machine;
  TileStack tileStack = TileStackDecorator([]);
  Reachability? reachability;
  late Direction direction;

  Tile({
    required this.position,
    required this.terrain,
    Direction? direction,
    TileStack? tileStack,
    this.machine,
  }) {
    if (tileStack == null) {
      this.tileStack.addToStack(terrain.asset);
    } else {
      this.tileStack = tileStack;
    }
    this.direction = direction ?? Direction.north;
  }

  bool get hasMachine => machine != null;

  Tile copyWith({
    TilePosition? position,
    Terrain? terrain,
    Machine? machine,
    Direction? direction,
    TileStack? tileStack,
  }) {
    return Tile(
      position: position ?? this.position,
      terrain: terrain ?? this.terrain,
      machine: machine ?? this.machine,
      tileStack: tileStack ?? this.tileStack,
      direction: direction ?? this.direction,
    );
  }

  void unsetMachine() {
    final currentMachine = machine;
    if (currentMachine != null) {
      final key = currentMachine.getAsset().key;
      if (key != null) {
        tileStack.removeFromStack(key);
      }
      machine = null;
    }
  }

  void updateReachability(Reachability? reachability) {
    this.reachability = reachability;
  }

  void addMachine(Machine machine) {
    this.machine = machine;
    tileStack.addToStack(machine.getAsset());
  }

  @override
  String toString() {
    return '$position - ${machine?.name} - ${terrain.name} - ${tileStack.getStack().length} - $reachability - $direction';
  }
}
