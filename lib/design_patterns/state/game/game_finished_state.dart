import '../../../enum/player.dart';
import '../../../exceptions/game_finished_exception.dart';
import 'game.dart';
import 'game_state.dart';

class GameFinishedState implements GameState {
  final Game game;
  final Player winner;

  GameFinishedState(this.game, this.winner);

  @override
  Player currentPlayer() {
    throw GameFinishedException(winner);
  }

  @override
  Player enemy() {
    throw GameFinishedException(winner);
  }

  @override
  int currentPlayerScore() {
    throw GameFinishedException(winner);
  }

  @override
  void nextPlayer() {
    throw GameFinishedException(winner);
  }
}
