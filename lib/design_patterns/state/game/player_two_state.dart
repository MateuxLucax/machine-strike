import '../../../enum/player.dart';
import 'game.dart';
import 'game_state.dart';
import 'player_one_state.dart';

class PlayerTwoState implements GameState {
  final Game game;

  PlayerTwoState(this.game);

  @override
  Player currentPlayer() {
    return Player.two;
  }

  @override
  Player enemy() {
    return Player.one;
  }

  @override
  int currentPlayerScore() {
    return game.victoryPoints[Player.two] ?? 0;
  }

  @override
  void nextPlayer() {
    game.turn++;
    game.setState(PlayerOneState(game));
  }
}
