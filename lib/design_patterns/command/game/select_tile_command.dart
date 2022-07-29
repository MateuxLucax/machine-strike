import '../../../model/tile.dart';
import 'tiles_command.dart';

class SelectTileCommand extends GameCommand {
  final Tile cursorTile;

  SelectTileCommand(super.game, this.cursorTile);

  @override
  void execute() {
    final tile = game.selectedTile;
    final cursorMachine = cursorTile.machine;
    if (tile == null && cursorMachine != null && cursorMachine.player == game.player) {
      if (!(cursorMachine.alreadyAttacked && cursorMachine.alreadyMoved)) {
        game.selectedTile = cursorTile;
      }
    } else if (tile != null) {
      final machine = tile.machine;
      if (machine != null && !machine.alreadyMoved && cursorTile.reachable) {
        game.board.tiles[tile.position.row][tile.position.col].unsetMachine();
        machine.updateAlreadyMoved(true);
        cursorTile.addMachine(machine);
        game.reset();
      }
    }
  }
}
