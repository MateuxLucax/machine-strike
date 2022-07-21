import 'package:machinestrike/model/tile.dart';

abstract class ITilesAdapter {
  Future<List<List<Tile>>> getTiles(String file);
}
