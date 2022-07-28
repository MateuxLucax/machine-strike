import '../../../enum/player.dart';
import 'game.dart';
import 'game_state.dart';
import 'player_two_state.dart';

class PlayerOneState implements GameState {
  final Game game;

  PlayerOneState(this.game);

  @override
  Player currentPlayer() {
    return Player.one;
  }

  @override
  int currentPlayerScore() {
    return game.victoryPoints[Player.one] ?? 0;
  }

  @override
  void updatePlayerScore(int score) {
    game.victoryPoints[Player.one] = score + currentPlayerScore();
  }

  @override
  void nextPlayer() {
    game.turn++;
    game.setState(PlayerTwoState(game));
  }
}
