import '../design_patterns/decorator/tile/add_widget_on_stack_decorator.dart';
import '../design_patterns/decorator/tile/base_tile_stack.dart';
import '../design_patterns/decorator/tile/tile_stack.dart';
import 'machine.dart';
import 'terrain.dart';
import 'tile_position.dart';

class Tile {
  TilePosition position;
  Terrain terrain;
  Machine? machine;
  TileStack tileStack;
  late bool reachable;
  late bool inAttackRange;

  Tile({
    required this.position,
    required this.terrain,
    required this.tileStack,
    bool? inAttackRange,
    this.machine,
  }) {
    reachable = false;
    this.inAttackRange = inAttackRange ?? false;
  }

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
      tileStack = BaseTileStack(terrain.asset);
      machine = null;
    }
  }

  void addMachine(Machine machine) {
    this.machine = machine;
    tileStack = AddWidgetOnStackDecorator(tileStack, machine.getAsset());
  }

  void rotateMachine() {
    final currentMachine = machine;
    if (currentMachine != null) {
      tileStack = BaseTileStack(terrain.asset);
      tileStack = AddWidgetOnStackDecorator(tileStack, currentMachine.getAsset());
    }
  }

  void updateReachability(bool reachable) {
    this.reachable = reachable;
  }

  void updateInAttackRange(bool inAttackRange) {
    this.inAttackRange = inAttackRange;
  }

  @override
  String toString() {
    return '$position - ${machine?.name} - ${terrain.name} - ${tileStack.getStack().length} - $reachable';
  }
}
