import '../../../enum/player.dart';
import '../../../exceptions/game_finished_exception.dart';
import 'game.dart';
import 'game_state.dart';

class GameFinishedState implements GameState {
  final Game game;

  GameFinishedState(this.game);

  @override
  Player currentPlayer() {
    throw GameFinishedException(game.winner!);
  }

  @override
  Player enemy() {
    throw GameFinishedException(game.winner!);
  }

  @override
  int currentPlayerScore() {
    throw GameFinishedException(game.winner!);
  }

  @override
  void updatePlayerScore(int score) {
    throw GameFinishedException(game.winner!);
  }

  @override
  void nextPlayer() {
    throw GameFinishedException(game.winner!);
  }
}
