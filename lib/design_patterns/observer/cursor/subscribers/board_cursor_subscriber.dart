import '../../../../model/tile_position.dart';
import '../default_subscriber.dart';

class BoardCursorSubscriber extends DefaultSubscriber<TilePosition> {
  BoardCursorSubscriber(int x, int y) {
    observed = TilePosition(x, y);
  }

  @override
  void update(TilePosition observed) {
    streamController.add(observed);
  }
}
