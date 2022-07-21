import 'package:machinestrike/design_patterns/decorator/tile/add_element_on_stack_decorator.dart';

import '../../../enum/player.dart';
import '../../../model/machine.dart';
import '../../singleton/boards.dart';
import '../game.dart';
import '../game_builder.dart';

class StandardGameBuilder extends GameBuilder {
  StandardGameBuilder() {
    super.createGame(Player.playerOne, Boards().get(1));
  }

  @override
  GameBuilder addMachine(Machine machine, int x, int y) {
    game.board.tiles[x][y] = game.board.tiles[x][y].copyWith(
      machine: machine,
      tileStack: AddElementOnStackDecorator(
        game.board.tiles[x][y].tileStack,
        machine.asset,
      ),
    );
    return this;
  }

  @override
  Game build() {
    return game;
  }
}
