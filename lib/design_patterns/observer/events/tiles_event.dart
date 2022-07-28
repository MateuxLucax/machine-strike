import '../../../model/tile.dart';
import '../observer_event.dart';

class TilesEvent implements ObserverEvent {
  final List<List<Tile>> tiles;

  TilesEvent(this.tiles);
}
