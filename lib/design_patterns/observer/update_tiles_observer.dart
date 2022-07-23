import '../../model/tile.dart';

abstract class UpdateTilesObserver {
  void update(List<List<Tile>> tiles);
}
