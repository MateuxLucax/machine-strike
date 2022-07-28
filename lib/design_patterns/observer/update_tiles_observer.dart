import '../../model/tile.dart';

abstract class UpdateTilesObserver {
  void updateTiles(List<List<Tile>> tiles);
}
