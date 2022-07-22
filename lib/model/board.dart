import 'tile.dart';
import 'tile_position.dart';

class Board {
  late List<List<Tile>> tiles;

  Board({
    required this.tiles,
  });

  Tile getByPosition(TilePosition position) {
    return tiles[position.x][position.y];
  }
}
