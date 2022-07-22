import '../../../../model/terrain.dart';
import '../default_subscriber.dart';

class TerrainSubscriber extends DefaultSubscriber<Terrain> {
  @override
  void update(Terrain observed) {
    streamController.add(observed);
  }
}
