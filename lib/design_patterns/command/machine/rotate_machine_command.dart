import '../../../enum/direction.dart';
import '../../../model/tile.dart';
import 'machine_command.dart';

class RotateMachineCommand extends MachineCommand {
  final Tile tile;
  final bool next;

  RotateMachineCommand(super.machine, this.tile, this.next);

  @override
  void execute() {
    if (tile.machine != null) {
      machine.updateDirection(_where);
      tile.rotateMachine();
    }
  }

  Direction get _where => next ? machine.direction.next() : machine.direction.previous();
}
