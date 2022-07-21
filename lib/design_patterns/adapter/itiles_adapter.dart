import '../../model/tile.dart';

// TODO: read game from xml or any other shit

abstract class ITilesAdapter {
  Future<List<List<Tile>>> getTiles(String file);
}
