import '../../../enum/player.dart';
import '../../../model/board.dart';
import '../../abstract_factory/imachine_factory.dart';
import '../../decorator/tile/add_element_on_stack_decorator.dart';
import '../game.dart';
import '../game_builder.dart';

class StandardGameBuilder extends GameBuilder {
  @override
  GameBuilder addMachine(IMachineFactory machine) {
    final x = machine.getPosition().x;
    final y = machine.getPosition().y;
    game.board.tiles[x][y] = game.board.tiles[x][y].copyWith(
      machine: machine,
      tileStack: AddElementOnStackDecorator(
        game.board.tiles[x][y].tileStack,
        machine.getAsset(),
      ),
    );

    return this;
  }

  @override
  Game build() {
    return game;
  }

  @override
  GameBuilder setBoard(Board board) {
    game.board = board;
    return this;
  }

  @override
  GameBuilder setInitialPlayer(Player player) {
    game.initialPlayer = player;
    return this;
  }
}
