import '../enum/player.dart';
import 'machine.dart';
import 'tile.dart';
import 'tile_position.dart';

class Board {
  late List<List<Tile>> tiles;

  Board(this.tiles);

  Tile getByPosition(TilePosition position) {
    return tiles[position.row][position.col];
  }

  List<Tile> get tilesInAttackRange {
    final List<Tile> inAttackRange = [];
    for (var row in tiles) {
      for (var col in row) {
        if (col.inAttackRange) {
          inAttackRange.add(col);
        }
      }
    }

    return inAttackRange;
  }

  List<Machine> getMachinesByPlayer(Player player) {
    final List<Machine> machines = [];
    for (var row in tiles) {
      for (var col in row) {
        final machine = col.machine;
        if (machine != null) {
          if (machine.player == player) {
            machines.add(machine);
          }
        }
      }
    }

    return machines;
  }

  void reset({machines = false}) {
    for (var row in tiles) {
      for (var col in row) {
        if (machines) {
          final machine = col.machine;
          if (machine != null) {
            machine.updateAlreadyAttacked(false);
            machine.updateAlreadyMoved(false);
          }
        }
        col.updateReachability(false);
        col.updateInAttackRange(false);
      }
    }
  }
}
