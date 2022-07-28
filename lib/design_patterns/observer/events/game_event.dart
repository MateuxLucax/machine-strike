import 'package:machinestrike/design_patterns/state/game/game.dart';

import '../observer_event.dart';

class GameEvent implements ObserverEvent {
  final Game game;

  GameEvent(this.game);
}
