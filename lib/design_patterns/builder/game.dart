import '../../enum/player.dart';
import '../../model/board.dart';

class Game {
  final Player initialPlayer;
  final Board board;

  Game(this.initialPlayer, this.board);
}
