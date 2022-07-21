import 'package:flutter/widgets.dart';

import '../../enum/player.dart';
import '../../model/board.dart';
import '../../model/machine.dart';
import 'game.dart';

abstract class GameBuilder {
  @protected
  late Game game;

  void createGame(Player initialPlayer, Board board) {
    game = Game(initialPlayer, board);
  }

  Game getGame() => game;

  GameBuilder addMachine(Machine machine, int x, int y);
  Game build();
}
