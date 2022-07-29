import 'tiles_command.dart';

class ReachablePiecesCommand extends GameCommand {
  ReachablePiecesCommand(super.game);

  @override
  void execute() {
    final tile = game.selectedTile;
    if (tile != null) {
      final machine = tile.machine;

      if (machine != null) {
        if (!(machine.alreadyMoved)) {
          final position = tile.position;
          final movementRange = tile.machine?.movementRange ?? 0;

          for (var row in game.board.tiles) {
            for (var col in row) {
              if (col.machine == tile.machine) {
                continue;
              }
              final colPos = col.position;
              final dist = (position.row - colPos.row).abs() + (position.col - colPos.col).abs();
              if (dist > movementRange || col.machine != null) {
                col.updateReachability(false);
              } else {
                col.updateReachability(true);
              }
            }
          }
        }
      }
    }
  }
}
