import 'package:machinestrike/enum/player.dart';
import 'package:machinestrike/model/board.dart';

class Game {
  final Player initialPlayer;
  final Board board;

  Game(this.initialPlayer, this.board);
}
