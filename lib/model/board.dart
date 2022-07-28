import 'tile.dart';
import 'tile_position.dart';

class Board {
  late List<List<Tile>> tiles;

  Board(this.tiles);

  Tile getByPosition(TilePosition position) {
    return tiles[position.row][position.col];
  }

  Board copy() {
    return Board([
      ...tiles.map((row) => [...row]).toList()
    ]);
  }
}
