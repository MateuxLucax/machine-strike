import '../../model/machine.dart';
import '../../model/tile.dart';

abstract class IGameFactory {
  Future<List<List<Tile>>> getTiles(String file);
  Future<Machine> getMachine(String file);
}
