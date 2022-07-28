import '../../../model/tile.dart';
import '../observer_event.dart';

class CursorEvent implements ObserverEvent {
  final Tile tile;

  CursorEvent(this.tile);
}
