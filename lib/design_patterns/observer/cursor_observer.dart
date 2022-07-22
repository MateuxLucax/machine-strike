import '../../model/tile.dart';
import '../../model/tile_position.dart';

abstract class CursorObserver {
  void updateCursor(TilePosition cursor, Tile tile);
}
