import 'package:machinestrike/enum/reachability.dart';

import '../design_patterns/abstract_factory/imachine_factory.dart';
import '../design_patterns/decorator/tile/tile_stack.dart';
import '../design_patterns/decorator/tile/tile_stack_decorator.dart';
import 'terrain.dart';
import 'tile_position.dart';

class Tile {
  TilePosition position;
  Terrain terrain;
  IMachineFactory? machine;
  TileStack tileStack = TileStackDecorator([]);
  Reachability? reachability;

  Tile({
    required this.position,
    required this.terrain,
    this.machine,
    TileStack? tileStack,
  }) {
    if (tileStack == null) {
      this.tileStack.addToStack(terrain.asset);
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

  void addMachine(IMachineFactory machine) {
    this.machine = machine;
    tileStack.addToStack(machine.getAsset());
  }

  @override
  String toString() {
    return '$position - ${machine?.getName()} - ${terrain.name} - ${tileStack.getStack().length}';
  }
}
