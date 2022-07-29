import 'tile.dart';
import 'tile_position.dart';

class Board {
  late List<List<Tile>> tiles;

  Board(this.tiles);

  Tile getByPosition(TilePosition position) {
    return tiles[position.row][position.col];
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
        col.updateReachability(null);
        col.updateInAttackRange(false);
      }
    }
  }
}
