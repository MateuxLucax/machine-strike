import '../../../enum/player.dart';

abstract class GameState {
  Player currentPlayer() {
    throw Exception('No player selected');
  }

  Player enemy() {
    throw Exception('No player selected');
  }

  int currentPlayerScore() {
    throw Exception('No player score');
  }

  void nextPlayer() {
    throw Exception('Next player not implemented');
  }
}
