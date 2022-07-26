import 'package:flutter/widgets.dart';

import '../../enum/player.dart';
import '../../model/board.dart';
import '../../model/machine.dart';
import 'game.dart';

abstract class GameBuilder {
  @protected
  Game game = Game();

  Game getGame() => game;

  GameBuilder setBoard(Board board);
  GameBuilder setInitialPlayer(Player player);
  GameBuilder addMachine(Machine machine);
  Game build();
}
