import '../../../config/game_const.dart';
import '../../../enum/player.dart';
import '../../../model/board.dart';
import '../../../model/tile.dart';
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
  Board board;
  Tile? selectedTile;

  Game(this.board) {
    _gameState = PlayerOneState(this);
  }

  void setState(GameState state) {
    _gameState = state;
  }

  int getVictoryPoints() => _gameState.currentPlayerScore();

  void updateScore(Player to, int score) {
    final points = victoryPoints[to];
    if (points != null) {
      victoryPoints[to] = points + score;

      victoryPoints.forEach((player, playerScore) {
        if (playerScore >= GameConst.victoryPointsWin) {
          setState(GameFinishedState(this, player));
        }
      });
    }
  }

  Player get player => _gameState.currentPlayer();

  Player get enemy => _gameState.enemy();

  void nextPlayer() {
    reset(machines: true);
    _gameState.nextPlayer();
  }

  void updateSelectedTile(Tile? tile) => selectedTile = tile;

  void reset({machines = false}) {
    selectedTile = null;
    board.reset(machines: machines);
  }
}
