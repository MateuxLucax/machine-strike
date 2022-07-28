import '../../../config/game_const.dart';
import '../../../enum/player.dart';
import 'game_finished_state.dart';
import 'game_state.dart';
import 'player_one_state.dart';

class Game {
  late GameState _gameState;
  final Map<Player, int> victoryPoints = {
    Player.one: 0,
    Player.two: 0,
  };
  int turn = 1;
  Player? winner;

  Game() {
    _gameState = PlayerOneState(this);
  }

  void setState(GameState state) {
    _gameState = state;
  }

  int getVictoryPoints() => _gameState.currentPlayerScore();

  void updateVictoryPoints(int score) {
    _gameState.updatePlayerScore(score);
    victoryPoints.forEach((player, playerScore) {
      if (playerScore >= GameConst.victoryPointsWin) {
        winner = player;
        setState(GameFinishedState(this));
      }
    });
  }

  Player get player => _gameState.currentPlayer();

  Player get enemy => _gameState.enemy();

  void nextPlayer() => _gameState.nextPlayer();
}
