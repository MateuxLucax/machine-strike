import '../../../enum/direction.dart';
import 'tiles_command.dart';

class AttackRangeCommand extends GameCommand {
  AttackRangeCommand(super.game);

  @override
  void execute() {
    final tile = game.selectedTile;
    game.board.reset();

    if (tile != null) {
      final machine = tile.machine;
      if (machine != null) {
        if (!machine.alreadyAttacked) {
          switch (machine.direction) {
            case Direction.north:
              for (var row = 0; row < tile.position.row; row++) {
                if ((tile.position.row - row).abs() <= machine.attackRange) {
                  final tileMachine = game.board.tiles[row][tile.position.col].machine;

                  if (tileMachine != null && tileMachine.player != machine.player) {
                    game.board.tiles[row][tile.position.col].updateInAttackRange(true);
                  }
                }
              }
              break;
            case Direction.east:
              for (var col = (game.board.tiles.length - 1); col > tile.position.col; col--) {
                if ((tile.position.col - col).abs() <= machine.attackRange) {
                  final tileMachine = game.board.tiles[tile.position.row][col].machine;

                  if (tileMachine != null && tileMachine.player != machine.player) {
                    game.board.tiles[tile.position.row][col].updateInAttackRange(true);
                  }
                }
              }
              break;
            case Direction.south:
              for (var row = (game.board.tiles.length - 1); row > tile.position.row; row--) {
                if ((tile.position.row - row).abs() <= machine.attackRange) {
                  final tileMachine = game.board.tiles[row][tile.position.col].machine;

                  if (tileMachine != null && tileMachine.player != machine.player) {
                    game.board.tiles[row][tile.position.col].updateInAttackRange(true);
                  }
                }
              }
              break;
            case Direction.west:
              for (var col = 0; col < tile.position.col; col++) {
                if ((tile.position.col - col).abs() <= machine.attackRange) {
                  final tileMachine = game.board.tiles[tile.position.row][col].machine;

                  if (tileMachine != null && tileMachine.player != machine.player) {
                    game.board.tiles[tile.position.row][col].updateInAttackRange(true);
                  }
                }
              }
              break;
          }
        }
      }
    }
  }
}
