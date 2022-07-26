import '../design_patterns/decorator/tile/tile_stack.dart';
import '../design_patterns/decorator/tile/tile_stack_decorator.dart';
import '../enum/reachability.dart';
import 'machine.dart';
import 'terrain.dart';
import 'tile_position.dart';

class Tile {
  TilePosition position;
  Terrain terrain;
  Machine? machine;
  TileStack tileStack = TileStackDecorator([]);
  Reachability? reachability;
  late bool inAttackRange;

  Tile({
    required this.position,
    required this.terrain,
    bool? inAttackRange,
    TileStack? tileStack,
    this.machine,
  }) {
    if (tileStack == null) {
      this.tileStack.addToStack(terrain.asset);
    } else {
      this.tileStack = tileStack;
    }
    this.inAttackRange = inAttackRange ?? false;
  }

  bool get hasMachine => machine != null;

  Tile copyWith({
    TilePosition? position,
    Terrain? terrain,
    Machine? machine,
    TileStack? tileStack,
    bool? inAttackRange,
  }) {
    return Tile(
      position: position ?? this.position,
      terrain: terrain ?? this.terrain,
      machine: machine ?? this.machine,
      tileStack: tileStack ?? this.tileStack,
      inAttackRange: inAttackRange ?? this.inAttackRange,
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

  void addMachine(Machine machine) {
    this.machine = machine;
    tileStack.addToStack(machine.getAsset());
  }

  void updateMachine() {
    final currentMachine = machine;
    if (currentMachine != null) {
      final key = currentMachine.getAsset().key;
      if (key != null) {
        tileStack.removeFromStack(key);
        tileStack.addToStack(currentMachine.getAsset());
      }
    }
  }

  void updateReachability(Reachability? reachability) {
    this.reachability = reachability;
  }

  void updateInAttackRange(bool inAttackRange) {
    this.inAttackRange = inAttackRange;
  }

  @override
  String toString() {
    return '$position - ${machine?.name} - ${terrain.name} - ${tileStack.getStack().length} - $reachability';
  }
}
