import '../state/game/game.dart';

abstract class GameObserver {
  void updateGame(Game game);
}
