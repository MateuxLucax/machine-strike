import '../enum/player.dart';

class GameFinishedException implements Exception {
  final Player winner;

  GameFinishedException(this.winner);

  @override
  String toString() {
    return 'Game finished! Winner: ${winner.toString()}';
  }
}
